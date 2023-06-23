import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:mxc_logic/src/domain/entities/network_type.dart';
import 'package:mxc_logic/src/domain/entities/wannsee/wannsee_transactions_model/wannsee_transactions_model.dart';
import 'package:web3dart/web3dart.dart';
import '../../../data/socket/mxc_socket_client.dart';
import '../../entities/wallet_transfer.dart';
import 'package:http/http.dart' as http;


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
  Future<dynamic> getTransactionsByAddress();
  Future<dynamic> getTokenRecentTransactions(EthereumAddress from);
  Future<bool> checkConnectionToNetwork();
  Future<void> subscribeToBalanceEvent(
      String event, void Function(dynamic) listeningCallBack);
  Future<void> subscribeToTransactionsEvent();
}

class ContractService implements IContractService {
  ContractService(this._client, {this.contract});

  final Web3Client _client;
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

      print('transact started $transactionId');

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

      print('$from}');
      print('$to}');
      print('$value}');

      onTransfer(from, to, value);
    });
  }

  @override
  Future<WannseeTransactionsModel?> getTransactionsByAddress() async {
//     final _httpLink = HttpLink(
//       'https://wannsee-explorer-v1.mxc.com/graphiql',
//     );

//     Link? _link;

//     final _wsLink = WebSocketLink('wss://wannsee-explorer-v1.mxc.com/socket');
//     _link = Link.split((request) => request.isSubscription, _wsLink, _httpLink);

//     final GraphQLClient client = GraphQLClient(
//       /// **NOTE** The default store is the InMemoryStore, which does NOT persist to disk
//       cache: GraphQLCache(),
//       link: _link,
//     );
//     const String txHash = "0xe87fff848427687077d522d1a04449902d34083a";

//     const String getTransactions = r'''
//       query {address(hash: "0xe87fff848427687077d522d1a04449902d34083a") {
//   transactions (first: 5) {pageInfo{hasNextPage hasPreviousPage} edges { node {s r v  fromAddressHash toAddressHash value error hash id} }}
// }}
//       ''';

//     final QueryOptions options = QueryOptions(
//       document: gql(getTransactions),
//       variables: <String, dynamic>{
//         'txHash': txHash,
//       },
//     );

//     final QueryResult result = await client.query(options);

//     if (result.hasException) {
//       print(result.exception.toString());
//     } else {
//       print(result.data);
//       final txList = Transactions.fromMap(result.data as Map<String, dynamic>);
//       inspect(txList);
//     }

    // final response = await http.Client().get(Uri.parse('https://wannsee-explorer-v1.mxc.com/api?module=account&action=txlist&address=0xE87FfF848427687077d522d1A04449902d34083a'),headers: {'accept': 'application/json'});

    // if (response.statusCode == 200){
    //   TransactionHistory.fromJson(jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>);
    // }

    final response = await http.Client().get(
        Uri.parse(
            'https://wannsee-explorer-v1.mxc.com/api/v2/addresses/0xe87fff848427687077d522d1a04449902d34083a/transactions'),
        headers: {'accept': 'application/json'});

    if (response.statusCode == 200) {
      final txList = WannseeTransactionsModel.fromJson(response.body);
      return txList;
    }else {
      return null;
    }
  }

  @override
  Future getTokenRecentTransactions(EthereumAddress from) {
    // TODO: implement getTokenRecentTransactions
    throw UnimplementedError();
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
      print('Error with connection');
      return false;
    } else {
      _mxcSocketService.subscribeToEvent(event, listeningCallBack);
      return true;
    }
  }

  @override
  Future<void> subscribeToTransactionsEvent() {
    // TODO: implement subscribeToTransactionsEvent
    throw UnimplementedError();
  }

  @override
  Future<void> dispose() async {
    await _client.dispose();
  }
}
