import 'dart:async';
import 'package:mxc_logic/src/data/api/client/rest_client.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/data/api/client/web3_client.dart';
import 'package:mxc_logic/src/data/socket/mxc_socket_client.dart';
import 'package:web3dart/web3dart.dart';

class TransactionControllerRepository {
  TransactionControllerRepository(
    this._web3Client,
  );

  final DatadashClient _web3Client;

  /// This functions will send a dump transaction (sending 0 ETH to ourselves) with increased fees in order to
  /// be included in a block before the old transaction.
  Future<TransactionModel> cancelTransaction(
    TransactionModel toCancelTransaction,
    Account account,
    EtherAmount maxFeePerGas,
    EtherAmount priorityFee,
  ) async {
    final cred = EthPrivateKey.fromHex(account.privateKey);
    late Transaction cancelTransaction;
    late TransactionModel transactionData;
    late String result;

    cancelTransaction =
        MXCTransaction.buildCancelTransactionFromTransactionModel(
      toCancelTransaction,
      account,
      maxFeePerGas,
      priorityFee,
    );

    transactionData = TransactionModel.fromTransaction(cancelTransaction, null);

    result = await _web3Client.sendTransaction(
      cred,
      cancelTransaction,
      chainId: _web3Client.network!.chainId,
    );

    transactionData = transactionData.copyWith(hash: result);

    return transactionData;
  }

  /// Either get transaction here or get transaction from api The downside for this is that there is a fetch involved which makes the fetching take longer
  /// Or add properties to transaction model
  /// The first problem that I might encounter is the old saved models in other chains
  /// I can handle that by making the properties optional
  /// On MXC chains I might not encounter any issues since data is remote

  Future<TransactionModel> speedUpTransaction(
    TransactionModel toSpeedUpTransaction,
    Account account,
    EtherAmount maxFeePerGas,
    EtherAmount priorityFee,
  ) async {
    final cred = EthPrivateKey.fromHex(account.privateKey);
    late Transaction speedUpTransaction;
    late TransactionModel transactionData;

    speedUpTransaction =
        MXCTransaction.buildSpeedUpTransactionFromTransactionModel(
      toSpeedUpTransaction,
      account,
      maxFeePerGas,
      priorityFee,
    );

    transactionData = TransactionModel.fromTransaction(
        speedUpTransaction, toSpeedUpTransaction.token);

    final result = await _web3Client.sendTransaction(
      cred,
      speedUpTransaction,
      chainId: _web3Client.network!.chainId,
    );

    // Because
    transactionData = transactionData.copyWith(
        hash: result,
        value: toSpeedUpTransaction.transferType == TransferType.erc20
            ? toSpeedUpTransaction.value
            : transactionData.value);

    return transactionData;
  }
}
