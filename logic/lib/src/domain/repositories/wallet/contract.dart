import 'dart:async';
import 'package:ens_dart/ens_dart.dart';
import 'package:mxc_logic/contracts/Nft.g.dart';
import 'package:mxc_logic/src/data/api/client/rest_client.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/data/socket/mxc_socket_client.dart';
import 'package:web3dart/web3dart.dart';

import '../extensions/extensions.dart';

import 'app_config.dart';

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
    String receiver,
    EtherAmount amount, {
    TransferEvent? onTransfer,
    Function(Object exeception)? onError,
  });
  Future<BigInt> getTokenBalance(String from);
  Future<EtherAmount> getEthBalance(String from);
  Future<void> dispose();
  StreamSubscription<FilterEvent> listenTransfer(TransferEvent onTransfer);
  Future<dynamic> getTransactionsByAddress(String address);
  Future<WannseeTransactionModel?> getTransactionByHash(String hash);
  Future<bool> checkConnectionToNetwork();
  Future<bool> subscribeToBalanceEvent(
    String event,
    void Function(dynamic) listeningCallBack,
  );
  Future<DefaultTokens?> getDefaultTokens();
  Future<WannseeTokenTransfersModel?> getTokenTransfersByAddress(
    String address,
  );
  // Future<WannseeTokensBalanceModel?> getTokensBalance(EthereumAddress from);
  Future<Token?> getToken(String address);
  Future<List<Token>> getTokensBalance(
    List<Token> tokens,
    String walletAddress,
  );
  Future<String> getName(String address);
  Future<String> getAddress(String? name);
  Future<EstimatedGasFee> estimateGesFee({
    required String from,
    required String to,
  });
  Future<String> sendTransaction({
    required String privateKey,
    required String to,
    required String amount,
    EstimatedGasFee? estimatedGasFee,
  });

  Future<WannseeTokenMetaData?> getTokenInfo(
    EthereumAddress collectionAddress,
    int tokenId,
    EthereumAddress userAddress,
  );

  Future<bool?> checkTokenOwnership(
    EthereumAddress collectionAddress,
    int tokenId,
    EthereumAddress userAddress,
  );
}

class ContractRepository implements IContractService {
  ContractRepository(
    this._web3Client,
    this._restClient, {
    required this.networkConfig,
    this.contract,
  });

  final Web3Client _web3Client;
  final RestClient _restClient;
  final DeployedContract? contract;
  final AppConfigParams networkConfig;

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
    String receiver,
    EtherAmount amount, {
    TransferEvent? onTransfer,
    Function(Object exeception)? onError,
  }) async {
    final credentials = getCredentials(privateKey);
    final from = credentials.address;
    final to = EthereumAddress.fromHex(receiver);
    final networkId = await _web3Client.getNetworkId();

    final gasPrice = await _web3Client.getGasPrice();
    final transaction = type == WalletTransferType.ether
        ? Transaction(
            from: from,
            to: to,
            gasPrice: gasPrice,
            value: amount,
          )
        : Transaction.callContract(
            contract: contract!,
            function: _sendFunction(),
            parameters: <dynamic>[to, amount.getInWei],
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
            onTransfer(from, to, amount.getInEther);
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
  Future<EtherAmount> getEthBalance(String from) async {
    final data = EthereumAddress.fromHex(from);
    return _web3Client.getBalance(data);
  }

  @override
  Future<BigInt> getTokenBalance(String from) async {
    final data = EthereumAddress.fromHex(from);
    final response = await _web3Client.call(
      contract: contract!,
      function: _balanceFunction(),
      params: <EthereumAddress>[data],
    );

    return response.first as BigInt;
  }

  // @override
  // Future<WannseeTokensBalanceModel?> getTokensBalance(
  //     EthereumAddress from) async {
  //   final response = await _restClient.client.get(
  //     Uri.parse(
  //       'https://wannsee-explorer-v1.mxc.com/api/v2/addresses/${from.hex}/tokens?type=ERC-20',
  //     ),
  //     headers: {'accept': 'application/json'},
  //   );

  //   if (response.statusCode == 200) {
  //     final txList = WannseeTokensBalanceModel.fromJson(response.body);
  //     return txList;
  //   }
  //   if (response.statusCode == 404) {
  //     // new wallet and nothing is returned
  //     const txList = WannseeTokensBalanceModel(
  //       items: [],
  //     );
  //     return txList;
  //   } else {
  //     return null;
  //   }
  // }

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
    String address,
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
    String address,
  ) async {
    final response = await _restClient.client.get(
      Uri.parse(
        'https://wannsee-explorer-v1.mxc.com/api/v2/addresses/$address/token-transfers?type=',
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
  Future<WannseeTokenMetaData?> getTokenInfo(
    EthereumAddress collectionAddress,
    int tokenId,
    EthereumAddress userAddress,
  ) async {
    final collectionContract =
        Nft(address: collectionAddress, client: _web3Client);

    try {
      // Uri is something like ipfs://<CID>
      final tokenMetaDataUri =
          await collectionContract.tokenURI(BigInt.from(tokenId));

      RegExp regExp = RegExp(r'ipfs://(.+)');
      Match? match = regExp.firstMatch(tokenMetaDataUri);

      if (match != null) {
        String hash = match.group(1)!;
        final metaDataResponse = await _restClient.client
            .get(Uri.parse('https://ipfs.io/ipfs/$hash'));

        if (metaDataResponse.statusCode == 200) {
          return WannseeTokenMetaData.fromJson(metaDataResponse.body);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<bool?> checkTokenOwnership(
    EthereumAddress collectionAddress,
    int tokenId,
    EthereumAddress userAddress,
  ) async {
    try {
      final collectionContract =
          Nft(address: collectionAddress, client: _web3Client);

      final owner = await collectionContract.ownerOf(BigInt.from(tokenId));

      return owner == userAddress;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
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
  Future<String> getName(String address) async {
    try {
      final ens = Ens(client: _web3Client).withAddress(address);
      final name = await ens.getName();

      return name;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<String> getAddress(String? name) async {
    try {
      final ens = Ens(client: _web3Client).withName(name);
      final address = await ens.getAddress();

      return address.hex;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<EstimatedGasFee> estimateGesFee({
    required String from,
    required String to,
  }) async {
    try {
      final sender = EthereumAddress.fromHex(from);
      final toAddress = EthereumAddress.fromHex(to);

      final gasPrice = await _web3Client.getGasPrice();

      final gas = await _web3Client.estimateGas(
        sender: sender,
        to: toAddress,
      );

      final fee = gasPrice.getInWei * gas;
      final gasFee = EtherAmount.fromBigInt(EtherUnit.wei, fee);

      return EstimatedGasFee(
        gasPrice: gasPrice,
        gas: gas,
        gasFee: MxcAmount.toDoubleByEther(gasFee.getInWei.toString()),
      );
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<String> sendTransaction({
    required String privateKey,
    required String to,
    required String amount,
    EstimatedGasFee? estimatedGasFee,
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
        ),
        fetchChainIdFromNetworkId: true,
        chainId: null,
      );

      return result;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> dispose() async {
    await _web3Client.dispose();
  }
}
