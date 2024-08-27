import 'dart:async';
import 'dart:typed_data';
import 'package:ens_dart/ens_dart.dart' as contracts;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mxc_logic/src/data/api/client/rest_client.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/data/api/client/web3_client.dart';
import 'package:mxc_logic/src/domain/entities/wannsee/wannsee_nft_collection_detail/item.dart';
import 'package:mxc_logic/src/domain/utils/mxc_urls.dart';
import 'package:web3dart/web3dart.dart';

class NftContractRepository {
  NftContractRepository(
    this._web3Client,
  ) : _restClient = RestClient();

  final DatadashClient _web3Client;
  final RestClient _restClient;

  Future<bool> checkConnectionToNetwork() async {
    final isConnected = await _web3Client.isListeningForNetwork();
    return isConnected;
  }

  Future<String> getOwnerOf({
    required String address,
    required int tokenId,
  }) async {
    try {
      final addressValue = EthereumAddress.fromHex(address);
      final tokenIdValue = BigInt.from(tokenId);

      final ensNft =
          contracts.EnsNft(address: addressValue, client: _web3Client);
      final result = await ensNft.ownerOf(tokenIdValue);

      return result.hex;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Nft> getNft({
    required String address,
    required int tokenId,
  }) async {
    try {
      final addressValue = EthereumAddress.fromHex(address);
      final tokenIdValue = BigInt.from(tokenId);

      final ensNft =
          contracts.EnsNft(address: addressValue, client: _web3Client);
      final tokenMetaDataUri = await ensNft.tokenURI(tokenIdValue);

      RegExp regExp = RegExp(r'ipfs://(.+)');
      Match? match = regExp.firstMatch(tokenMetaDataUri);

      if (match != null) {
        String hash = match.group(1)!;
        final metaDataResponse = await _restClient.client
            .get(Uri.parse('https://ipfs.io/ipfs/$hash'));

        if (metaDataResponse.statusCode == 200) {
          final tokenMetaData =
              WannseeTokenMetaData.fromJson(metaDataResponse.body);

          final name = await ensNft.name();

          return Nft(
            address: address,
            tokenId: tokenId,
            image: tokenMetaData.image ?? '',
            name: name,
          );
        } else {
          throw Exception('Image Meta Data fetch error.');
        }
      } else {
        throw Exception('Image Meta Data fetch error.');
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> sendTransaction({
    required String address,
    required int tokenId,
    required String privateKey,
    required String to,
    TransactionGasEstimation? estimatedGasFee,
  }) async {
    try {
      final addressValue = EthereumAddress.fromHex(address);
      final tokenIdValue = BigInt.from(tokenId);

      final ensNft =
          contracts.EnsNft(address: addressValue, client: _web3Client);

      final toAddress = EthereumAddress.fromHex(to);
      final cred = EthPrivateKey.fromHex(privateKey);

      final result = await ensNft.transferFrom(
        cred.address,
        toAddress,
        tokenIdValue,
        credentials: cred,
      );

      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Nft>> getNftsByAddress(
    String address,
    String ipfsGateWay,
  ) async {
    final List<Nft> finalList = [];

    final selectedNetwork = _web3Client.network!;
    final currentChainId = selectedNetwork.chainId;
    final apiBaseUrl = Urls.getApiBaseUrl(currentChainId);

    final response = await _restClient.client.get(
      Uri.parse(
        Urls.tokens(apiBaseUrl, address, TokenType.erc_721),
      ),
      headers: {'accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final addressCollections =
          WannseeAddressTokensList.fromJson(response.body);

      for (int i = 0; i < addressCollections.items!.length; i++) {
        final collectionItem = addressCollections.items![i];
        final tokenAddress = collectionItem.token!.address!;
        final response = await _restClient.client.get(
          Uri.parse(
            Urls.tokenInstances(
              apiBaseUrl,
              tokenAddress,
              TokenType.erc_721,
            ),
          ),
          headers: {'accept': 'application/json'},
        );

        if (response.statusCode != 200) {
          continue;
        }
        final collectionDetail =
            WannseeNftCollectionDetail.fromJson(response.body);
        final currentCollectionNfts = collectionDetail.items!
            .where(
              (element) => element.owner!.hash!.toLowerCase() == address,
            )
            .toList();

        for (int i = 0; i < currentCollectionNfts.length; i++) {
          Item tokenInstance = currentCollectionNfts[i];

          final hexagonNamingAddress =
              ContractAddresses.getContractAddressString(
            MXCContacts.hexagonNaming,
            currentChainId,
          );

          if (tokenAddress == hexagonNamingAddress) {
            final hexlified = MXCType.hexlify(BigInt.parse(tokenInstance.id!));
            final color = MXCColors.getColorFromH3Id(hexlified);
            final hexString = MXCColors.colorToHexString(color);
            tokenInstance = tokenInstance.copyWith(imageUrl: hexString);
          } else if (tokenInstance.imageUrl == null) {
            try {
              final erc721Contract = contracts.Erc721(
                address: EthereumAddress.fromHex(tokenAddress),
                client: _web3Client,
              );
              final tokenId = BigInt.parse(tokenInstance.id!);
              final tokenMetaDataUrl = await erc721Contract.tokenURI(tokenId);
              final cid = MXCUrls.extractCIDFromUrl(tokenMetaDataUrl);

              final metaDataUrl = '$ipfsGateWay$cid';

              final response = await _restClient.client.get(
                Uri.parse(
                  metaDataUrl,
                ),
                headers: {'accept': 'application/json'},
              );

              if (response.statusCode != 200) {
                continue;
              }

              final metaData = WannseeTokenMetaData.fromJson(response.body);

              // IPFS gateway get metaData
              // MetaData parse
              tokenInstance = tokenInstance.copyWith(imageUrl: metaData.image);
            } catch (e) {
              continue;
            }
          }

          if (tokenInstance.imageUrl == null ||
              tokenInstance.token == null ||
              tokenInstance.token!.address == null ||
              tokenInstance.id == null ||
              tokenInstance.token!.name == null) {
            continue;
          }

          final collectionAddress = tokenInstance.token!.address!;
          final tokenId = int.parse(tokenInstance.id!);
          final String? image = tokenInstance.imageUrl;
          final name = tokenInstance.token!.name!;

          final nft = Nft(
            address: collectionAddress,
            tokenId: tokenId,
            image: image,
            name: name,
          );

          finalList.add(nft);
        }
      }
      return finalList;
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw 'Error while trying to fetch NFTs!';
    }
  }

  Future<List<Nft>> getERC_11_55TokensByAddress(
    String address,
    String ipfsGateWay,
  ) async {
    final selectedNetwork = _web3Client.network!;
    final currentChainId = selectedNetwork.chainId;
    final mnsSubGraphsUri = Urls.getMNSSubGraphsUrl(currentChainId);

    final graphQLClient =
        _web3Client.graphQLClient.copyWith(link: HttpLink(mnsSubGraphsUri));

    final QueryOptions options = QueryOptions(
      document: gql(
        queryDomainNames(),
      ),
    );
    final QueryResult result = await graphQLClient.query(options);

    if (result.data == null) {
      return [];
    }

    final response = DomainNamesQueryResponse.fromMap(result.data!);

    final addressDomains = response.domains
        .where((element) => element.wrappedDomain.owner.id == address)
        .toList();

    final List<Nft> finalList = addressDomains.map((e) {
      final nameWrapperAddress = ContractAddresses.getContractAddressString(
        MXCContacts.nameWrapper,
        currentChainId,
      );

      String hexString = e.id.replaceFirst('0x', '');
      final tokenId = BigInt.parse(hexString, radix: 16).toInt();
      final image = e.name;
      const name = 'MNS';

      final nft = Nft(
        address: nameWrapperAddress,
        tokenId: tokenId,
        image: image,
        name: name,
      );
      return nft;
    }).toList();

    return finalList;
  }

  Future<void> dispose() async {
    await _web3Client.dispose();
  }
}
