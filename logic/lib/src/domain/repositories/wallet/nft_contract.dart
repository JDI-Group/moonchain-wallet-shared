import 'dart:async';
import 'package:ens_dart/ens_dart.dart';
import 'package:mxc_logic/src/data/api/client/rest_client.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/domain/const/const.dart';
import 'package:web3dart/web3dart.dart';

class NftContractRepository {
  NftContractRepository(
    this._web3Client,
  ) : _restClient = RestClient();

  final Web3Client _web3Client;
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

      final ensNft = EnsNft(address: addressValue, client: _web3Client);
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

      final ensNft = EnsNft(address: addressValue, client: _web3Client);
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
    EstimatedGasFee? estimatedGasFee,
  }) async {
    try {
      final addressValue = EthereumAddress.fromHex(address);
      final tokenIdValue = BigInt.from(tokenId);

      final ensNft = EnsNft(address: addressValue, client: _web3Client);

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

  Future<List<Nft>?> getNftsByAddress(
    String address,
  ) async {
    try {
      final List<Nft> finalList = [];

      final response = await _restClient.client.get(
        Uri.parse(
          Urls.tokens(address, TokenType.erc_721),
        ),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final addressCollections =
            WannseeAddressTokensList.fromJson(response.body);

        for (int i = 0; i < addressCollections.items!.length; i++) {
          final tokenAddress = addressCollections.items![i].token!.address!;
          final response = await _restClient.client.get(
            Uri.parse(
              Urls.tokenInstances(tokenAddress, TokenType.erc_721),
            ),
            headers: {'accept': 'application/json'},
          );

          if (response.statusCode == 200) {
            final collectionDetail =
                WannseeNftCollectionDetail.fromJson(response.body);
            final currentCollectionNfts = collectionDetail.items!
                .where(
                    (element) => element.owner!.hash!.toLowerCase() == address)
                .toList();

            for (int i = 0; i < currentCollectionNfts.length; i++) {
              final tokenInstance = currentCollectionNfts[i];

              if (tokenInstance.token == null ||
                  tokenInstance.token!.address == null ||
                  tokenInstance.imageUrl == null ||
                  tokenInstance.id == null ||
                  tokenInstance.token!.name == null) {
                throw Exception('NFT Data fetch error.');
              }

              final collectionAddress = tokenInstance.token!.address!;
              final tokenId = int.parse(tokenInstance.id!);
              final image = tokenInstance.imageUrl!;
              final name = tokenInstance.token!.name!;

              final nft = Nft(
                address: collectionAddress,
                tokenId: tokenId,
                image: image,
                name: name,
              );

              finalList.add(nft);
            }
          } else {
            return null;
          }
        }
        return finalList;
      }

      if (response.statusCode == 404) {
        // new wallet
        return [];
      } else {
        return null;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<DefaultIpfsGateways?> getDefaultIpfsGateways() async {
    final response = await _restClient.client.get(
      Uri.parse(
        Urls.defaultIpfsGateway,
      ),
      headers: {'accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final defaultIpfsGateways = DefaultIpfsGateways.fromJson(response.body);
      return defaultIpfsGateways;
    } else {
      return null;
    }
  }

  Future<bool> checkIpfsGateway(String url) async {
    try {
      final response = await _restClient.client.get(
        Uri.parse(
          url + Const.hashToTest,
        ),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> dispose() async {
    await _web3Client.dispose();
  }
}
