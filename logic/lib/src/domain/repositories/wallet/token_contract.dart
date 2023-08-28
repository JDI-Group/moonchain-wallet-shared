import 'dart:async';
import 'package:ens_dart/ens_dart.dart';
import 'package:flutter/services.dart';
import 'package:mxc_logic/src/data/api/client/rest_client.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/data/api/client/web3_client.dart';
import 'package:mxc_logic/src/data/socket/mxc_socket_client.dart';
import 'package:mxc_logic/src/domain/const/const.dart';
import 'package:web3dart/web3dart.dart';

typedef TransferEvent = void Function(
  EthereumAddress from,
  EthereumAddress to,
  BigInt value,
);

class TokenContractRepository {
  TokenContractRepository(
    this._web3Client,
  ) : _restClient = RestClient();

  final DatadashClient _web3Client;
  final RestClient _restClient;

  EthPrivateKey getCredentials(String privateKey) =>
      EthPrivateKey.fromHex(privateKey);

  Future<EtherAmount> getEthBalance(String from) async {
    final data = EthereumAddress.fromHex(from);
    return _web3Client.getBalance(data);
  }

  Future<WannseeTransactionsModel?> getTransactionsByAddress(
    String address,
  ) async {
    final selectedNetwork = _web3Client.network!;
    final apiBaseUrl = selectedNetwork.chainId == Config.mxcMainnetChainId
        ? Config.mainnetApiBaseUrl
        : selectedNetwork.chainId == Config.mxcTestnetChainId
            ? Config.testnetApiBaseUrl
            : null;

    if (apiBaseUrl != null) {
      final response = await _restClient.client.get(
        Uri.parse(
          Urls.transactions(apiBaseUrl, address),
        ),
        headers: {'accept': 'application/json'},
      );
      if (response.statusCode == 200) {
        final txList = WannseeTransactionsModel.fromJson(response.body);
        return txList;
      }
      if (response.statusCode == 404) {
        // new wallet and nothing is returned
        final txList = WannseeTransactionsModel(
          items: const [],
        );
        return txList;
      } else {
        return null;
      }
    }
  }

  Future<WannseeTokenTransfersModel?> getTokenTransfersByAddress(
    String address,
    TokenType tokenType,
  ) async {
    final selectedNetwork = _web3Client.network!;
    final apiBaseUrl = selectedNetwork.chainId == Config.mxcMainnetChainId
        ? Config.mainnetApiBaseUrl
        : selectedNetwork.chainId == Config.mxcTestnetChainId
            ? Config.testnetApiBaseUrl
            : null;

    if (apiBaseUrl != null) {
      final response = await _restClient.client.get(
        Uri.parse(
          Urls.tokenTransfers(apiBaseUrl, address, tokenType),
        ),
        headers: {'accept': 'application/json'},
      );
      if (response.statusCode == 200) {
        final txList = WannseeTokenTransfersModel.fromJson(response.body);
        return txList;
      }
      if (response.statusCode == 404) {
        // new wallet and nothing is returned
        const txList = WannseeTokenTransfersModel(
          items: [],
        );
        return txList;
      } else {
        return null;
      }
    }
  }

  /// If the transaction is successful then not null
  Future<WannseeTransactionModel?> getTransactionByHash(
    String hash,
  ) async {
    final selectedNetwork = _web3Client.network!;
    final apiBaseUrl = selectedNetwork.chainId == Config.mxcMainnetChainId
        ? Config.mainnetApiBaseUrl
        : selectedNetwork.chainId == Config.mxcTestnetChainId
            ? Config.testnetApiBaseUrl
            : null;

    if (apiBaseUrl != null) {
      final response = await _restClient.client.get(
        Uri.parse(
          Urls.transaction(apiBaseUrl, hash),
        ),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final txList = WannseeTransactionModel.fromJson(response.body);
        return txList;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<bool> checkConnectionToNetwork() async {
    final isConnected = await _web3Client.isListeningForNetwork();
    return isConnected;
  }

  Future<Stream<dynamic>?> subscribeToBalanceEvent(
    String event,
  ) async {
    if ((_web3Client.network!.networkType == NetworkType.testnet ||
            _web3Client.network!.networkType == NetworkType.mainnet) &&
        _web3Client.network!.web3WebSocketUrl!.isNotEmpty) {
      final mxcSocketService = MXCSocketClient();
      mxcSocketService.initialize();
      await mxcSocketService.connect(_web3Client.network!.web3WebSocketUrl!);
      return mxcSocketService.subscribeToEvent(
        event,
      );
    } else {
      return null;
    }
  }

  Future<DefaultTokens?> getDefaultTokens() async {
    final selectedNetwork = _web3Client.network!;
    final tokenListUrl = selectedNetwork.chainId == Config.mxcMainnetChainId
        ? Config.mainnetTokenListUrl
        : selectedNetwork.chainId == Config.mxcTestnetChainId
            ? Config.testnetTokenListUrl
            : null;
    if (tokenListUrl != null) {
      final response = await _restClient.client.get(
        Uri.parse(
          tokenListUrl,
        ),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final defaultTokens = DefaultTokens.fromJson(response.body);
        return defaultTokens;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<List<Token>> getTokensBalance(
    List<Token> tokens,
    String walletAddress,
  ) async {
    final address = EthereumAddress.fromHex(walletAddress);

    for (int i = 0; i < tokens.length; i++) {
      final token = tokens[i];
      final tokenDecimal = token.decimals!;
      if (token.address != null) {
        final data = EthereumAddress.fromHex(token.address!);
        final ensToken = EnsToken(client: _web3Client, address: data);

        final tokenBalanceResponse = await ensToken.balanceOf(address);
        // making number human understandable
        final double tokenBalance = MxcAmount.convertWithTokenDecimal(
            tokenBalanceResponse.toDouble(), tokenDecimal);
        tokens[i] = token.copyWith(balance: tokenBalance);
      } else {
        // native token
        final ethBalance = await getEthBalance(walletAddress);
        final double tokenBalance = ethBalance.getInEther.toDouble();
        tokens[i] = token.copyWith(balance: tokenBalance);
      }
    }
    return tokens;
  }

  Future<Token?> getToken(String address) async {
    try {
      final data = EthereumAddress.fromHex(address);
      final ensToken = EnsToken(client: _web3Client, address: data);
      final symbol = await ensToken.symbol();
      final decimals = await ensToken.decimals();

      return Token(
        address: address,
        name: symbol,
        symbol: symbol,
        decimals: decimals.toInt(),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> getName(String address) async {
    try {
      final selectedNetwork = _web3Client.network!;
      final ensResolverAddress =
          selectedNetwork.chainId == Config.mxcMainnetChainId
              ? Config.mainnetEnsAddresses.ensResolver
              : selectedNetwork.chainId == Config.mxcTestnetChainId
                  ? Config.testnetEnsAddresses.ensResolver
                  : null;
      final ensFallBackRegistryAddress =
          selectedNetwork.chainId == Config.mxcMainnetChainId
              ? Config.mainnetEnsAddresses.ensFallbackRegistry
              : selectedNetwork.chainId == Config.mxcTestnetChainId
                  ? Config.testnetEnsAddresses.ensFallbackRegistry
                  : null;
      if (ensResolverAddress != null && ensFallBackRegistryAddress != null) {
        final ens = Ens(
                client: _web3Client,
                address: EthereumAddress.fromHex(ensResolverAddress),
                ensFallBackRegistryAddress:
                    EthereumAddress.fromHex(ensFallBackRegistryAddress))
            .withAddress(address);
        final name = await ens.getName();

        return name;
      }

      throw Exception('Ens addresses missing.');
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> getAddress(String? name) async {
    try {
      final selectedNetwork = _web3Client.network!;
      final ensResolverAddress =
          selectedNetwork.chainId == Config.mxcMainnetChainId
              ? Config.mainnetEnsAddresses.ensResolver
              : selectedNetwork.chainId == Config.mxcTestnetChainId
                  ? Config.testnetEnsAddresses.ensResolver
                  : null;
      final ensFallBackRegistryAddress =
          selectedNetwork.chainId == Config.mxcMainnetChainId
              ? Config.mainnetEnsAddresses.ensFallbackRegistry
              : selectedNetwork.chainId == Config.mxcTestnetChainId
                  ? Config.testnetEnsAddresses.ensFallbackRegistry
                  : null;
      if (ensResolverAddress != null && ensFallBackRegistryAddress != null) {
        final ens = Ens(
                client: _web3Client,
                address: EthereumAddress.fromHex(ensResolverAddress),
                ensFallBackRegistryAddress:
                    EthereumAddress.fromHex(ensFallBackRegistryAddress))
            .withName(name);
        final address = await ens.getAddress();

        return address.hex;
      }

      throw Exception('Ens addresses missing.');
    } catch (e) {
      throw e.toString();
    }
  }

  Future<EtherAmount> getGasPrice() async => await _web3Client.getGasPrice();

  Future<EstimatedGasFee> estimateGesFee({
    required String from,
    required String to,
    EtherAmount? gasPrice,
    Uint8List? data,
  }) async {
    final sender = EthereumAddress.fromHex(from);
    final toAddress = EthereumAddress.fromHex(to);

    final gasPriceData = gasPrice ?? await _web3Client.getGasPrice();

    final gas = await _web3Client.estimateGas(
      sender: sender,
      to: toAddress,
      data: data,
    );

    final fee = gasPriceData.getInWei * gas;
    final gasFee = EtherAmount.fromBigInt(EtherUnit.wei, fee);

    return EstimatedGasFee(
      gasPrice: gasPriceData,
      gas: gas,
      gasFee: gasFee.getValueInUnit(EtherUnit.ether),
    );
  }

  Future<String> sendTransaction({
    required String privateKey,
    required String to,
    required String? from,
    required EtherAmount amount,
    EstimatedGasFee? estimatedGasFee,
    Uint8List? data,
  }) async {
    final toAddress = EthereumAddress.fromHex(to);
    EthereumAddress? fromAddress;
    if (from != null) fromAddress = EthereumAddress.fromHex(from);
    final cred = EthPrivateKey.fromHex(privateKey);

    final result = await _web3Client.sendTransaction(
        cred,
        Transaction(
          to: toAddress,
          from: fromAddress,
          value: amount,
          gasPrice: estimatedGasFee?.gasPrice,
          data: data,
        ),
        fetchChainIdFromNetworkId: true,
        chainId: null);

    return result;
  }

  Future<int> getChainId(String rpcUrl) async {
    try {
      final client = _restClient.client;
      final chainId = await Web3Client(
        rpcUrl,
        client,
      ).getChainId();
      return chainId.toInt();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> dispose() async {
    await _web3Client.dispose();
  }
}
