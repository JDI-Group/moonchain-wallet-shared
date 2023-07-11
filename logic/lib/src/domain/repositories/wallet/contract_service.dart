import 'dart:async';
import 'package:ens_dart/ens_dart.dart';
import 'package:mxc_logic/src/data/api/client/rest_client.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/data/socket/mxc_socket_client.dart';
import 'package:web3dart/web3dart.dart';

typedef TransferEvent = void Function(
  EthereumAddress from,
  EthereumAddress to,
  BigInt value,
);

abstract class IContractService {
  EthPrivateKey getCredentials(String privateKey);
  Future<String?> send(
    String privateKey,
    WalletTransferType type,
    EthereumAddress receiver,
    EtherAmount amount, {
    TransferEvent? onTransfer,
    Function(Object exeception)? onError,
  });
  Future<BigInt> getTokenBalance(EthereumAddress from);
  Future<EtherAmount> getEthBalance(EthereumAddress from);
  Future<void> dispose();
  StreamSubscription<FilterEvent> listenTransfer(TransferEvent onTransfer);
  Future<dynamic> getTransactionsByAddress(EthereumAddress address);
  Future<WannseeTransactionModel?> getTransactionByHash(String hash);
  Future<bool> checkConnectionToNetwork();
  Future<bool> subscribeToBalanceEvent(
    String event,
    void Function(dynamic) listeningCallBack,
  );
  Future<DefaultTokens?> getDefaultTokens();
  Future<WannseeTokenTransfersModel?> getTokenTransfersByAddress(
    EthereumAddress address,
  );
  Future<WannseeTokensBalanceModel?> getTokensBalance(EthereumAddress from);
  Future<Token?> getToken(String address);
}

class ContractService implements IContractService {
  ContractService(this._web3Client, this._ens, this._restClient,
      {this.contract});

  final Web3Client _web3Client;
  final Ens _ens;
  final RestClient _restClient;
  final DeployedContract? contract;

  ContractEvent _transferEvent() => contract!.event('Transfer');
  ContractFunction _balanceFunction() => contract!.function('balanceOf');
  ContractFunction _sendFunction() => contract!.function('sendCoin');

  @override
  EthPrivateKey getCredentials(String privateKey) =>
      EthPrivateKey.fromHex(privateKey);

  @override
  Future<String?> send(
    String privateKey,
    WalletTransferType type,
    EthereumAddress receiver,
    EtherAmount amount, {
    TransferEvent? onTransfer,
    Function(Object exeception)? onError,
  }) async {
    final credentials = getCredentials(privateKey);
    final from = credentials.address;
    final networkId = await _web3Client.getNetworkId();

    final gasPrice = await _web3Client.getGasPrice();
    final transaction = type == WalletTransferType.ether
        ? Transaction(
            from: from,
            to: receiver,
            gasPrice: gasPrice,
            value: amount,
          )
        : Transaction.callContract(
            contract: contract!,
            function: _sendFunction(),
            parameters: <dynamic>[receiver, amount.getInWei],
            gasPrice: gasPrice,
            from: from,
          );

    try {
      final transactionId = await _web3Client.sendTransaction(
        credentials,
        transaction,
        chainId: networkId,
      );

      // pooling the transaction receipt every x seconds.
      Timer.periodic(const Duration(seconds: 2), (timer) async {
        final receipt = await _web3Client.getTransactionReceipt(transactionId);

        if (receipt?.status ?? false) {
          if (onTransfer != null) {
            onTransfer(from, receiver, amount.getInEther);
          }

          timer.cancel();
        }
      });

      return transactionId;
    } catch (ex) {
      if (onError != null) {
        onError(ex);
      }
      return null;
    }
  }

  @override
  Future<EtherAmount> getEthBalance(EthereumAddress from) async {
    return _web3Client.getBalance(from);
  }

  @override
  Future<BigInt> getTokenBalance(EthereumAddress from) async {
    final response = await _web3Client.call(
      contract: contract!,
      function: _balanceFunction(),
      params: <EthereumAddress>[from],
    );

    return response.first as BigInt;
  }

  @override
  Future<WannseeTokensBalanceModel?> getTokensBalance(
      EthereumAddress from) async {
    final response = await _restClient.client.get(
      Uri.parse(
        'https://wannsee-explorer-v1.mxc.com/api/v2/addresses/${from.hex}/tokens?type=ERC-20',
      ),
      headers: {'accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final txList = WannseeTokensBalanceModel.fromJson(response.body);
      return txList;
    }
    if (response.statusCode == 404) {
      // new wallet and nothing is returned
      const txList = WannseeTokensBalanceModel(
        items: [],
      );
      return txList;
    } else {
      return null;
    }
  }

  @override
  StreamSubscription<FilterEvent> listenTransfer(TransferEvent onTransfer,
      {int? take}) {
    var events = _web3Client.events(FilterOptions.events(
      contract: contract!,
      event: _transferEvent(),
    ));

    if (take != null) {
      events = events.take(take);
    }

    return events.listen((event) {
      if (event.topics == null || event.data == null) {
        return;
      }

      final decoded =
          _transferEvent().decodeResults(event.topics!, event.data!);

      final from = decoded[0] as EthereumAddress;
      final to = decoded[1] as EthereumAddress;
      final value = decoded[2] as BigInt;

      onTransfer(from, to, value);
    });
  }

  // Reza wallet -> Token  Contract address -> Adam wallet confirmed
  @override
  Future<WannseeTransactionsModel?> getTransactionsByAddress(
    EthereumAddress address,
  ) async {
    final response = await _restClient.client.get(
        Uri.parse(
            'https://wannsee-explorer-v1.mxc.com/api/v2/addresses/$address/transactions'),
        headers: {'accept': 'application/json'});

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

  @override
  Future<WannseeTokenTransfersModel?> getTokenTransfersByAddress(
    EthereumAddress address,
  ) async {
    final response = await _restClient.client.get(
      Uri.parse(
          'https://wannsee-explorer-v1.mxc.com/api/v2/addresses/$address/token-transfers?type='),
      headers: {'accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      final txList = WannseeTokenTransfersModel.fromJson(response.body);
      return txList;
    }
    if (response.statusCode == 404) {
      // new wallet and nothing is returned
      final txList = WannseeTokenTransfersModel(
        items: [],
      );
      return txList;
    } else {
      return null;
    }
  }

  /// If the transaction is successful then not null
  @override
  Future<WannseeTransactionModel?> getTransactionByHash(
    String hash,
  ) async {
    final response = await _restClient.client.get(
      Uri.parse(
        'https://wannsee-explorer-v1.mxc.com/api/v2/transactions/$hash',
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

  @override
  Future<bool> checkConnectionToNetwork() async {
    final isConnected = await _web3Client.isListeningForNetwork();
    return isConnected;
  }

  @override
  Future<bool> subscribeToBalanceEvent(
      String event, void Function(dynamic) listeningCallBack) async {
    final _mxcSocketService = MXCSocketClient();
    _mxcSocketService.initialize(NetworkType.Wannsee);
    final isConnected = await _mxcSocketService.connect();
    if (isConnected == false) {
      return false;
    } else {
      _mxcSocketService.subscribeToEvent(event, listeningCallBack);
      return true;
    }
  }

  @override
  Future<DefaultTokens?> getDefaultTokens() async {
    final response = await _restClient.client.get(
      Uri.parse(
        'https://raw.githubusercontent.com/MXCzkEVM/wannseeswap-tokenlist/main/tokenlist.json',
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

  @override
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

  @override
  Future<void> dispose() async {
    await _web3Client.dispose();
  }
}
