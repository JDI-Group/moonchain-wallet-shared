import 'dart:convert';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/domain/utils/utils.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

enum TransactionType { sent, received, contractCall, all }

enum TransactionStatus { done, pending, failed }

enum TransactionActions { cancel, speedUp }

class TransactionModel {
  factory TransactionModel.fromMXCTransaction(
    WannseeTransactionModel mxcTransaction,
    String walletAddress,
  ) {
    String? value = '0';
    Token token = Token();
    DateTime? timeStamp;
    String hash = mxcTransaction.hash ?? 'Unknown';
    TransactionType type = TransactionType.sent;
    TransactionStatus status = TransactionStatus.done;
    String? from;
    String? to;
    double? feePerGas;
    String? data;
    int? gasLimit;

    // two type of tx : coin_transfer from filtered tx list & token transfer from token transfer list
    // If not 'contract_call' or 'coin_transfer' then empty and that means failed in other words
    // another tx that we have are : pending coin transfer (which is received on both sides) &
    // pending token transfer (which is only received on the sender side)
    if (mxcTransaction.result == 'pending') {
      // could be contract_call (token transfer || unknown transactions) || coin_transfer
      status = TransactionStatus.pending;
      final time = DateTime.now();
      timeStamp = time;
      final isCoinTransfer = mxcTransaction.txTypes!.contains('coin_transfer');

      // Getting tx info to tx model for speed up & cancel operation
      from = mxcTransaction.from?.hash;
      to = mxcTransaction.to?.hash;
      if (mxcTransaction.gasPrice != null) {
        feePerGas = double.parse(mxcTransaction.gasPrice!);
      }
      data = mxcTransaction.rawInput;
      if (mxcTransaction.gasLimit != null) {
        gasLimit = int.parse(mxcTransaction.gasLimit!);
      }

      if (mxcTransaction.decodedInput == null && !isCoinTransfer) {
        // It's contract call
        type = TransactionType.contractCall;
        value = mxcTransaction.txBurntFee;
      } else {
        type = mxcTransaction.checkForTransactionType(
          walletAddress,
          mxcTransaction.from!.hash!.toLowerCase(),
        );
        value = mxcTransaction.value ?? '0';
        token =
            token.copyWith(logoUri: Config.mxcLogoUri, symbol: Config.mxcName);

        if (mxcTransaction.decodedInput != null) {
          // It should be token transfer
          if (mxcTransaction.to?.hash != null) {
            token = token.copyWith(
                address: mxcTransaction.to?.hash,
                symbol: mxcTransaction.to!.name!);
            value = mxcTransaction.decodedInput?.parameters?[1].value ?? '0';
          }
        }
      }
    } else if (mxcTransaction.txTypes != null &&
        mxcTransaction.txTypes!.contains('coin_transfer')) {
      token =
          token.copyWith(logoUri: Config.mxcLogoUri, symbol: Config.mxcName);

      timeStamp = mxcTransaction.timestamp!;

      type = mxcTransaction.checkForTransactionType(
          walletAddress, mxcTransaction.from!.hash!.toLowerCase());
      value = mxcTransaction.value ?? '0';
    } else if (mxcTransaction.txTypes == null &&
        mxcTransaction.tokenTransfers != null &&
        mxcTransaction.tokenTransfers!
                .indexWhere((element) => element.type == 'token_transfer') !=
            -1) {
      token = token.copyWith(
          symbol: mxcTransaction.tokenTransfers![0].token!.name!);

      if (mxcTransaction.tokenTransfers?[0].token?.name != null) {
        token = token.copyWith(
            address: mxcTransaction.tokenTransfers?[0].token?.address);
      }

      timeStamp = mxcTransaction.tokenTransfers?[0].timestamp;

      value = mxcTransaction.tokenTransfers![0].total!.value ?? '0';
      hash = mxcTransaction.tokenTransfers![0].txHash ?? 'Unknown';
      type = mxcTransaction.checkForTransactionType(
        walletAddress,
        mxcTransaction.tokenTransfers![0].from!.hash!.toLowerCase(),
      );
    } else if (mxcTransaction.txTypes != null &&
        mxcTransaction.txTypes!.contains('contract_call')) {
      timeStamp = mxcTransaction.timestamp!;
      type = TransactionType.contractCall;
      value = mxcTransaction.txBurntFee;
    }

    return TransactionModel(
      hash: hash,
      timeStamp: timeStamp,
      status: status,
      type: type,
      value: value,
      token: token,
      action: null,
      from: from,
      to: to,
      feePerGas: feePerGas,
      data: data,
      gasLimit: gasLimit,
    );
  }

  // In this state the tx
  factory TransactionModel.fromTransactionReceipt(
      TransactionReceipt receipt, String walletAddress, Token token) {
    final txHash = bytesToHex(receipt.transactionHash, include0x: true);
    final timeStamp = DateTime.now();
    final txStatus = receipt.status == true
        ? TransactionStatus.done
        : TransactionStatus.pending;
    final txType = receipt.from!.hex == walletAddress
        ? TransactionType.sent
        : TransactionType.received;
    // When the receipt is available no need to have these props, since these props are used for
    // speed up & cancel operations.
    // final from = receipt.from;
    // final to = receipt.to;
    // final feePerGas = receipt.cumulativeGasUsed;
    // final data = receipt.;
    // final gasLimit = receipt.gasUsed?.toInt();

    return TransactionModel(
      hash: txHash,
      timeStamp: timeStamp,
      status: txStatus,
      type: txType,
      value: '0',
      token: token,
      action: null,
      // from: from?.hex,
      // to: to?.hex,
      // feePerGas: feePerGas.toDouble(), gasLimit: gasLimit,
    );
  }

  factory TransactionModel.fromTransaction(
      TransactionInformation receipt, String walletAddress, Token token) {
    final txHash = receipt.hash;
    final timeStamp = DateTime.now();
    const txStatus = TransactionStatus.pending;
    const txType = TransactionType.sent;
    final from = receipt.from;
    final to = receipt.to;
    final feePerGas = receipt.gasPrice;
    final data = MXCType.uint8ListToString(receipt.input);
    final gasLimit = receipt.gas;

    return TransactionModel(
      hash: txHash,
      timeStamp: timeStamp,
      status: txStatus,
      type: txType,
      value: '0',
      token: token,
      action: null,
      from: from.hex,
      to: to?.hex,
      feePerGas: feePerGas.getInWei.toDouble(),
      data: data,
      gasLimit: gasLimit,
    );
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      timeStamp: map['timeStamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['timeStamp'])
          : null,
      hash: map['hash'],
      status: TransactionStatus.values.firstWhere(
          (status) => status.toString().split('.').last == map['status']),
      type: TransactionType.values
          .firstWhere((type) => type.toString().split('.').last == map['type']),
      value: map['value'],
      token: Token.fromMap(map['token']),
      action: map['action'] != null && map['action'] != 'null'
          ? TransactionActions.values.firstWhere(
              (action) => action.toString().split('.').last == map['action'],
            )
          : null,
      from: map['from'] as String?,
      to: map['to'] as String?,
      feePerGas: map['feePerGas'] as double?,
      data: map['data'] as String?,
      gasLimit: map['gasLimit'] as int?,
    );
  }

  TransactionModel({
    required this.hash,
    this.timeStamp,
    required this.status,
    required this.type,
    required this.value,
    required this.token,
    required this.action,
    this.from,
    this.to,
    this.feePerGas,
    this.data,
    this.gasLimit,
  });

  TransactionModel copyWith(
      {String? hash,
      DateTime? timeStamp,
      TransactionStatus? status,
      TransactionActions? action,
      TransactionType? type,
      String? value,
      Token? token,
      String? from,
      String? to,
      double? feePerGas,
      String? data,
      int? gasLimit}) {
    return TransactionModel(
      hash: hash ?? this.hash,
      timeStamp: timeStamp ?? this.timeStamp,
      status: status ?? this.status,
      type: type ?? this.type,
      value: value ?? this.value,
      token: token ?? this.token,
      action: action ?? this.action,
      from: from ?? this.from,
      to: to ?? this.to,
      feePerGas: feePerGas ?? this.feePerGas,
      data: data ?? this.data,
      gasLimit: gasLimit ?? this.gasLimit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timeStamp': timeStamp?.millisecondsSinceEpoch,
      'hash': hash,
      'status': status.toString().split('.').last,
      'type': type.toString().split('.').last,
      'value': value,
      'token': token.toMap(),
      'action': action?.toString().split('.').last,
      'from': from,
      'to': to,
      'feePerGas': feePerGas,
      'data': data,
      'gasLimit': gasLimit
    };
  }

  String toJson() => json.encode(toMap());

  static TransactionModel fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  /// Time details about transaction took place.
  final DateTime? timeStamp;

  /// Hash of the transaction.
  final String hash;

  /// Whether this transaction was executed successfully.
  final TransactionStatus status;

  /// The action that are taken over this transaction
  final TransactionActions? action;

  /// Whether this transaction was sent or received.
  final TransactionType type;

  /// The value that is transferred in transaction.
  final String? value;

  final Token token;

  // Below variables are added for speed up & cancel feature
  // pending transactions must contains these props (Some props depending on the case) .
  final String? from;

  final String? to;

  final double? feePerGas;

  final int? gasLimit;

  final String? data;
}
