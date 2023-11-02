import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

import '../const/const.dart';

enum TransactionType { sent, received, contractCall, all }

enum TransactionStatus { done, pending, failed }

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

    // two type of tx : coin_transfer from filtered tx list & token transfer from token transfer list
    // If not 'contract_call' or 'coin_transfer' then empty and that means failed in other words
    // another tx that we have are : pending coin transfer (which is received on both sides) &
    // pending token transfer (which is only received on the sender side)
    if (mxcTransaction.result == 'pending') {
      // could be contract_call || coin_transfer
      status = TransactionStatus.pending;
      final time = DateTime.now();
      timeStamp = time;
      final isCoinTransfer = mxcTransaction.txTypes!.contains('coin_transfer');

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
    );
  }

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

    return TransactionModel(
      hash: txHash,
      timeStamp: timeStamp,
      status: txStatus,
      type: txType,
      value: '0',
      token: token,
    );
  }

  factory TransactionModel.fromTransaction(
      TransactionInformation receipt, String walletAddress, Token token) {
    final txHash = receipt.hash;
    final timeStamp = DateTime.now();
    const txStatus = TransactionStatus.pending;
    const txType = TransactionType.sent;

    return TransactionModel(
      hash: txHash,
      timeStamp: timeStamp,
      status: txStatus,
      type: txType,
      value: '0',
      token: token,
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
    );
  }

  TransactionModel({
    required this.hash,
    this.timeStamp,
    required this.status,
    required this.type,
    required this.value,
    required this.token,
  });

  TransactionModel copyWith({
    String? hash,
    DateTime? timeStamp,
    TransactionStatus? status,
    TransactionType? type,
    String? value,
    Token? token,
  }) {
    return TransactionModel(
      hash: hash ?? this.hash,
      timeStamp: timeStamp ?? this.timeStamp,
      status: status ?? this.status,
      type: type ?? this.type,
      value: value ?? this.value,
      token: token ?? this.token,
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

  /// Whether this transaction was sent or received.
  final TransactionType type;

  /// The value that is transferred in transaction.
  final String? value;

  final Token token;
}
