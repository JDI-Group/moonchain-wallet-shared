import 'dart:async';
import 'dart:developer';
import 'package:mxc_logic/src/data/api/client/rest_client.dart';
import 'package:mxc_logic/src/domain/entities/default_tokens/default_tokens.dart';
import 'package:mxc_logic/src/domain/entities/network_type.dart';
import 'package:mxc_logic/src/domain/entities/wannsee/wannsee_token_transfers_model/wannsee_token_transfer_model.dart';
import 'package:mxc_logic/src/domain/entities/wannsee/wannsee_transactions_model/wannsee_transactions_model.dart';
import 'package:web3dart/web3dart.dart';
import '../../../data/socket/mxc_socket_client.dart';
import '../../entities/wallet_transfer.dart';

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
}

class ContractService implements IContractService {
  ContractService(this._client, this._restClient, {this.contract});

  final Web3Client _client;
  final RestClient _restClient;
  final DeployedContract? contract;

  ContractEvent _transferEvent() => contract!.event('Transfer');
  ContractFunction _balanceFunction() => contract!.function('balanceOf');
  ContractFunction _sendFunction() => contract!.function('transfer');

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
    final networkId = await _client.getNetworkId();

    final gasPrice = await _client.getGasPrice();
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
      final transactionId = await _client.sendTransaction(
        credentials,
        transaction,
        chainId: networkId,
      );

      // pooling the transaction receipt every x seconds.
      Timer.periodic(const Duration(seconds: 2), (timer) async {
        final receipt = await _client.getTransactionReceipt(transactionId);

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
    return _client.getBalance(from);
  }

  @override
  Future<BigInt> getTokenBalance(EthereumAddress from) async {
    final response = await _client.call(
      contract: contract!,
      function: _balanceFunction(),
      params: <EthereumAddress>[from],
    );

    return response.first as BigInt;
  }

  @override
  StreamSubscription<FilterEvent> listenTransfer(TransferEvent onTransfer,
      {int? take}) {
    var events = _client.events(FilterOptions.events(
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

  @override
  Future<WannseeTransactionsModel?> getTransactionsByAddress(EthereumAddress address,
  ) async {
    final response = await _restClient.client.get(
        Uri.parse(
            'https://wannsee-explorer-v1.mxc.com/api/v2/addresses/$address/transactions'),
        headers: {'accept': 'application/json'});

    if (response.statusCode == 200) {
      final txList = WannseeTransactionsModel.fromJson(response.body);
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
    final isConnected = await _client.isListeningForNetwork();
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
        'https://raw.githubusercontent.com/reasje/wannseeswap-tokenlist/main/tokenlist.json',
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
  Future<void> dispose() async {
    await _client.dispose();
  }
}
