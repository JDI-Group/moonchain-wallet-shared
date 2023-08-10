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
    final response = await _restClient.client.get(
      Uri.parse(
        Urls.transactions(address),
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

  Future<WannseeTokenTransfersModel?> getTokenTransfersByAddress(
    String address,
  ) async {
    final response = await _restClient.client.get(
      Uri.parse(
        Urls.tokenTransfers(address),
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

  /// If the transaction is successful then not null
  Future<WannseeTransactionModel?> getTransactionByHash(
    String hash,
  ) async {
    final response = await _restClient.client.get(
      Uri.parse(
        Urls.transaction(hash),
      ),
      headers: {'accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final txList = WannseeTransactionModel.fromJson(response.body);
      return txList;
    } else {
      return null;
    }
  }

  Future<bool> checkConnectionToNetwork() async {
    final isConnected = await _web3Client.isListeningForNetwork();
    return isConnected;
  }

  Future<bool> subscribeToBalanceEvent(
      String event, void Function(dynamic) listeningCallBack) async {
    if ((_web3Client.network!.networkType == NetworkType.testnet ||
            _web3Client.network!.networkType == NetworkType.mainnet) &&
        _web3Client.network!.web3WebSocketUrl!.isNotEmpty) {
      final _mxcSocketService = MXCSocketClient();
      _mxcSocketService.initialize();

      final isConnected = await _mxcSocketService
          .connect(_web3Client.network!.web3WebSocketUrl!);

      if (isConnected) {
        _mxcSocketService.subscribeToEvent(event, listeningCallBack);
      }

      return isConnected;
    } else {
      return false;
    }
  }

  Future<DefaultTokens?> getDefaultTokens() async {
    final response = await _restClient.client.get(
      Uri.parse(
        Urls.defaultTokenList,
      ),
      headers: {'accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final defaultTokens = DefaultTokens.fromJson(response.body);
      return defaultTokens;
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
      if (token.address != null) {
        final data = EthereumAddress.fromHex(token.address!);
        final ensToken = EnsToken(client: _web3Client, address: data);

        final tokenBalanceResponse = await ensToken.balanceOf(address);
        tokens[i] = token.copyWith(balance: tokenBalanceResponse.toDouble());
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
      final ens = Ens(client: _web3Client).withAddress(address);
      final name = await ens.getName();

      return name;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> getAddress(String? name) async {
    try {
      final ens = Ens(client: _web3Client).withName(name);
      final address = await ens.getAddress();

      return address.hex;
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
    try {
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
        gasFee: MxcAmount.toDoubleByEther(gasFee.getInWei.toString()),
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> sendTransaction({
    required String privateKey,
    required String to,
    required String amount,
    EstimatedGasFee? estimatedGasFee,
    Uint8List? data,
  }) async {
    try {
      final toAddress = EthereumAddress.fromHex(to);
      final cred = EthPrivateKey.fromHex(privateKey);
      final amountFromDouble = double.parse(amount);
      final amountValue = MxcAmount.fromDoubleByEther(amountFromDouble);

      final result = await _web3Client.sendTransaction(
        cred,
        Transaction(
          to: toAddress,
          value: amountValue,
          gasPrice: estimatedGasFee?.gasPrice,
          data: data,
        ),
        fetchChainIdFromNetworkId: true,
        chainId: null,
      );

      return result;
    } catch (e) {
      throw e.toString();
    }
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

  Future<DefaultTweets> getDefaultTweets() async {
    final response = await _restClient.client.get(
      Uri.parse(
        Urls.defaultTweets,
      ),
      headers: {'accept': 'application/json'},
    );

    final defaultTweets = DefaultTweets.fromJson(response.body);
    return defaultTweets;
  }

  Future<void> dispose() async {
    await _web3Client.dispose();
  }
}
