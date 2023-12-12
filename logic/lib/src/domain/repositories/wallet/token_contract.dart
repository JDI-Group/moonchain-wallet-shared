import 'dart:async';
import 'package:ens_dart/ens_dart.dart';
import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:flutter/services.dart';
import 'package:mxc_logic/src/data/api/client/rest_client.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/data/api/client/web3_client.dart';
import 'package:mxc_logic/src/data/socket/mxc_socket_client.dart';
import 'package:mxc_logic/src/domain/const/const.dart';
import 'package:mxc_logic/src/domain/utils/utils.dart';
import 'package:web3dart/crypto.dart';
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

  MXCSocketClient get _mxcSocketClient => MXCSocketClient();

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
        ? Urls.mainnetApiBaseUrl
        : selectedNetwork.chainId == Config.mxcTestnetChainId
            ? Urls.testnetApiBaseUrl
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
        ? Urls.mainnetApiBaseUrl
        : selectedNetwork.chainId == Config.mxcTestnetChainId
            ? Urls.testnetApiBaseUrl
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
        ? Urls.mainnetApiBaseUrl
        : selectedNetwork.chainId == Config.mxcTestnetChainId
            ? Urls.testnetApiBaseUrl
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

  Future<TransactionInformation?> getTransactionByHashCustomChain(String hash) {
    return _web3Client.getTransactionByHash(hash);
  }

  Future<bool> checkConnectionToNetwork() async {
    final isConnected = await _web3Client.isListeningForNetwork();
    return isConnected;
  }

  Future<bool> connectToWebSocket() async {
    _mxcSocketClient.initialize();
    return await _mxcSocketClient
        .connect(_web3Client.network!.web3WebSocketUrl!);
  }

  void disconnectWebSocket() async {
    _mxcSocketClient.disconnect();
  }

  Future<Stream<dynamic>?> subscribeEvent(
    String event,
  ) async {
    if (Config.isMxcChains(_web3Client.network!.chainId)) {
      return _mxcSocketClient.subscribeToEvent(
        event,
      );
    } else {
      return null;
    }
  }

  Future<DefaultTokens?> getDefaultTokens() async {
    final selectedNetwork = _web3Client.network!;
    final tokenListUrl = selectedNetwork.chainId == Config.mxcMainnetChainId
        ? Urls.mainnetTokenListUrl
        : selectedNetwork.chainId == Config.mxcTestnetChainId
            ? Urls.testnetTokenListUrl
            : selectedNetwork.chainId == 1
                ? Urls.ethereumMainnetTokenListUrl
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
      try {
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
          final double tokenBalance =
              ethBalance.getValueInUnit(EtherUnit.ether).toDouble();
          tokens[i] = token.copyWith(balance: tokenBalance);
        }
      } catch (e) {
        continue;
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

  Network getCurrentNetwork() {
    return _web3Client.network!;
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

  /// This function is only used for native token transfer gas estimation
  Future<TransactionGasEstimation> estimateGasFeeForCoinTransfer({
    required String from,
    required String to,
    required EtherAmount? gasPrice,
    required EtherAmount value,
  }) =>
      estimateGasFee(from: from, to: to, gasPrice: gasPrice, value: value);

  /// This function is only used for token transfer gas estimation
  Future<TransactionGasEstimation> estimateGasFeeForContractCall({
    required String from,
    required String to,
    required Uint8List data,
    EtherAmount? gasPrice,
    BigInt? amountOfGas,
    EtherAmount? value,
  }) =>
      estimateGasFee(
        from: from,
        to: to,
        data: data,
        gasPrice: gasPrice,
        amountOfGas: amountOfGas,
        value: value,
      );

  Future<TransactionGasEstimation> estimateGasFee({
    required String from,
    required String to,
    EtherAmount? gasPrice,
    Uint8List? data,
    BigInt? amountOfGas,
    EtherAmount? value,
  }) async {
    final sender = EthereumAddress.fromHex(from);
    final toAddress = EthereumAddress.fromHex(to);

    final gasPriceData = gasPrice ?? await _web3Client.getGasPrice();

    EtherAmount maxFeePerGas = MXCGas.calculateMaxFeePerGas(gasPriceData);

    // NOTE: If data is not null then value should be null vice versa
    final gas = await _web3Client.estimateGas(
      sender: sender,
      to: toAddress,
      data: data,
      maxFeePerGas: maxFeePerGas,
      maxPriorityFeePerGas: Config.maxPriorityFeePerGas,
      value: value,
    );

    final fee = gasPriceData.getInWei * gas;
    final gasFee = EtherAmount.fromBigInt(EtherUnit.wei, fee);

    return TransactionGasEstimation(
      gasPrice: gasPriceData,
      gas: gas,
      gasFee: gasFee.getValueInUnit(EtherUnit.ether),
    );
  }

  Future<TransactionModel> sendTransaction({
    required String privateKey,
    required String to,
    required String? from,
    required EtherAmount amount,
    TransactionGasEstimation? estimatedGasFee,
    Uint8List? data,
    String? tokenAddress,
    Token? token,
  }) async {
    final toAddress = EthereumAddress.fromHex(to);
    EthereumAddress? fromAddress;
    if (from != null) fromAddress = EthereumAddress.fromHex(from);
    final cred = EthPrivateKey.fromHex(privateKey);
    final gasLimit = estimatedGasFee?.gas.toInt();
    EtherAmount maxFeePerGas =
        MXCGas.calculateMaxFeePerGas(estimatedGasFee!.gasPrice);

    final nonce = await _web3Client.getTransactionCount(fromAddress!);

    late TransactionModel transactionData;
    String? result;

    if (tokenAddress == null) {
      final transaction = Transaction(
          to: toAddress,
          from: fromAddress,
          maxFeePerGas: maxFeePerGas,
          maxPriorityFeePerGas: Config.maxPriorityFeePerGas,
          value: amount,
          data: data,
          nonce: nonce,
          maxGas: gasLimit);

      transactionData = TransactionModel.fromTransaction(transaction, token);

      result = await _web3Client.sendTransaction(
        cred,
        transaction,
        chainId: _web3Client.network!.chainId,
      );
    } else {
      final tokenHash = EthereumAddress.fromHex(tokenAddress);
      final erc20Token = EnsToken(address: tokenHash, client: _web3Client);
      final tokenAmount = amount.getValueInUnitBI(EtherUnit.wei);

      final transaction = Transaction(
          to: tokenHash,
          from: fromAddress,
          maxFeePerGas: maxFeePerGas,
          maxPriorityFeePerGas: Config.maxPriorityFeePerGas,
          nonce: nonce,
          maxGas: gasLimit);

      transactionData = TransactionModel.fromTransaction(transaction, token);

      result = await erc20Token.transfer(
        toAddress,
        tokenAmount,
        credentials: cred,
        transaction: transaction,
      );

      transactionData = transactionData.copyWith(
        data: MXCType.uint8ListToString(
          getTokenTransferData(
            tokenHash.hex,
            toAddress,
            tokenAmount,
          ),
        ),
      );
    }

    // Updating hash since we have put empty string for hash
    transactionData = transactionData.copyWith(hash: result);

    return transactionData;
  }

  Uint8List getTokenTransferData(
    String tokenHash,
    EthereumAddress toAddress,
    BigInt amount,
  ) {
    final erc20Token = EnsToken(
      address: EthereumAddress.fromHex(tokenHash),
      client: _web3Client,
    );
    final function = erc20Token.self.functions[33];
    assert(checkSignature(function, 'a9059cbb'));
    final params = [toAddress, amount];
    return function.encodeCall(params);
  }

  bool checkSignature(ContractFunction function, String expected) {
    return bytesToHex(function.selector) == expected;
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

  StreamSubscription<TransactionReceipt?> spyTransaction(
    String hash,
  ) {
    final controller = StreamController<TransactionReceipt?>();

    final stream = Stream.periodic(const Duration(seconds: 60), (count) async {
      final receipt = await _web3Client.getTransactionReceipt(hash);
      return receipt;
    }).asyncMap((event) => event).listen(controller.add);

    return stream;
  }

  String signTypedMessage({required String privateKey, required String data}) {
    final result = EthSigUtil.signTypedData(
      jsonData: data,
      version: TypedDataVersion.V4,
      privateKey: privateKey,
    );
    return result;
  }

  Future<TransactionReceipt?> getTransactionReceipt(String hash) async {
    return await _web3Client.getTransactionReceipt(hash);
  }

  /// This functions will send a dump transaction (sending 0 ETH to ourselves) with increased fees in order to
  /// be included in a block before the old transaction.
  Future<String> cancelTransaction(
    TransactionModel toCancelTransaction,
    Account account,
    EtherAmount maxFeePerGas,
    EtherAmount priorityFee,
  ) async {
    final cred = EthPrivateKey.fromHex(account.privateKey);
    late Transaction cancelTransaction;
    late String result;

    cancelTransaction =
        MXCTransaction.buildCancelTransactionFromTransactionModel(
      toCancelTransaction,
      account,
      maxFeePerGas,
      priorityFee,
    );

    result = await _web3Client.sendTransaction(
      cred,
      cancelTransaction,
      chainId: _web3Client.network!.chainId,
    );

    return result;
  }

  /// Either get transaction here or get transaction from api The downside for this is that there is a fetch involved which makes the fetching take longer
  /// Or add properties to transaction model
  /// The first problem that I might encounter is the old saved models in other chains
  /// I can handle that by making the properties optional
  /// On MXC chains I might not encounter any issues since data is remote

  Future<String> speedUpTransaction(
    TransactionModel toSpeedUpTransaction,
    Account account,
    EtherAmount maxFeePerGas,
    EtherAmount priorityFee,
  ) async {
    final cred = EthPrivateKey.fromHex(account.privateKey);
    late Transaction speedUpTransaction;

    speedUpTransaction =
        MXCTransaction.buildSpeedUpTransactionFromTransactionModel(
      toSpeedUpTransaction,
      account,
      maxFeePerGas,
      priorityFee,
    );

    final result = await _web3Client.sendTransaction(
      cred,
      speedUpTransaction,
      chainId: _web3Client.network!.chainId,
    );

    return result;
  }

  Future<void> dispose() async {
    await _web3Client.dispose();
  }
}
