import 'dart:convert';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

enum TransactionType { sent, received, contractCall, all, unknown }

enum TransferType { coin, erc20, erc1155, erc721, none }

enum TransactionStatus { done, pending, failed }

/// cancelSpeedUp = null (show both buttons) => speed up => (show cancel) cancel ==> Show nothing
/// speedUpCancel = null (show both buttons) => cancel => (show speed up cancellation) speed up  ==> Show speed up cancellation
/// null (show both buttons) => speed up => speed up => speed up ....
/// speedUpCancel = null (show both buttons) => cancel => cancel => cancel ....
enum TransactionActions { cancel, speedUp, cancelSpeedUp, speedUpCancel }

class TransactionModel {
  factory TransactionModel.fromMXCTransaction(
    WannseeTransactionModel mxcTransaction,
    String walletAddress,
  ) {
    String? value = '0';
    Token token = Token();
    DateTime? timeStamp = mxcTransaction.timestamp;
    String hash = mxcTransaction.hash ?? 'Unknown';
    TransactionType type = TransactionType.sent;
    TransactionStatus status = mxcTransaction.status == 'error'
        ? TransactionStatus.failed
        : TransactionStatus.done;
    String? from;
    String? to;
    double? feePerGas;
    String? data;
    int? gasLimit;
    int? nonce;
    BigInt? maxPriorityFee;
    TransferType? transferType;

    try {
      // two type of tx : coin_transfer from filtered tx list & token transfer from token transfer list
      // If not 'contract_call' or 'coin_transfer' then empty and that means failed in other words
      // another tx that we have are : pending coin transfer (which is received on both sides) &
      // pending token transfer (which is only received on the sender side)
      if (mxcTransaction.result == 'pending') {
        // could be contract_call (token transfer || unknown transactions) || coin_transfer
        status = TransactionStatus.pending;
        final time = DateTime.now();
        timeStamp = time;
        final isCoinTransfer =
            mxcTransaction.txTypes!.contains('coin_transfer');

        // Getting tx info to tx model for speed up & cancel operation
        from = mxcTransaction.from?.hash;
        to = mxcTransaction.to?.hash;
        if (mxcTransaction.gasPrice != null) {
          feePerGas = double.parse(mxcTransaction.maxFeePerGas!);
        }
        data = mxcTransaction.rawInput;
        if (mxcTransaction.gasLimit != null) {
          gasLimit = int.parse(mxcTransaction.gasLimit!);
        }

        if (mxcTransaction.nonce != null) {
          nonce = mxcTransaction.nonce;
        }

        if (mxcTransaction.maxPriorityFeePerGas != null) {
          maxPriorityFee = BigInt.parse(mxcTransaction.maxPriorityFeePerGas!);
        }

        // if (!isCoinTransfer && from == to && value == '0') {
        //   // It's cancel transaction

        // }
        // Avoid cancel transaction to be trapped in contract by  && from != to check.
        if (mxcTransaction.decodedInput?.methodId !=
                ContractAddresses.erc20TransferMethodId &&
            !isCoinTransfer &&
            from != to) {
          // It's contract call
          type = TransactionType.contractCall;
          value = mxcTransaction.txBurntFee;
        } else {
          type = mxcTransaction.checkForTransactionType(
            walletAddress,
            mxcTransaction.from!.hash!.toLowerCase(),
          );
          value = mxcTransaction.value ?? '0';
          token = token.copyWith(
              logoUri: Config.mxcLogoUri, symbol: Config.mxcName);

          if (mxcTransaction.decodedInput?.methodId ==
              ContractAddresses.erc20TransferMethodId) {
            // It should be token transfer
            if (mxcTransaction.to?.hash != null) {
              transferType = TransferType.erc20;
              token = token.copyWith(
                address: mxcTransaction.to?.hash,
                symbol: mxcTransaction.to!.name!,
              );
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
        nonce: nonce,
        maxPriorityFee: maxPriorityFee,
        transferType: transferType,
      );
    } catch (e) {
      return TransactionModel(
        hash: hash,
        timeStamp: timeStamp,
        status: TransactionStatus.done,
        type: TransactionType.unknown,
        value: value,
        token: token,
        action: null,
        from: from,
        to: to,
        feePerGas: feePerGas,
        data: data,
        gasLimit: gasLimit,
        nonce: nonce,
        maxPriorityFee: maxPriorityFee,
        transferType: transferType,
      );
    }
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

  // Does not cover the priority fee
  factory TransactionModel.fromTransactionInformation(
    TransactionInformation transactionInformation,
    String walletAddress,
    Token token,
  ) {
    final txHash = transactionInformation.hash;
    final timeStamp = DateTime.now();
    const txStatus = TransactionStatus.pending;
    const txType = TransactionType.sent;
    final from = transactionInformation.from;
    final to = transactionInformation.to;
    final feePerGas = transactionInformation.gasPrice;
    final data = MXCType.uint8ListToString(transactionInformation.input);
    final gasLimit = transactionInformation.gas;
    final nonce = transactionInformation.nonce;

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
      nonce: nonce,
      maxPriorityFee: null,
      transferType: null,
    );
  }

  factory TransactionModel.fromTransaction(
    Transaction transaction,
    Token? token,
  ) {
    final timeStamp = DateTime.now();
    const txStatus = TransactionStatus.pending;
    final from = transaction.from;
    final to = transaction.to!;
    final feePerGas = transaction.maxFeePerGas?.getInWei.toDouble();
    final maxPriorityFeePerGas = transaction.maxPriorityFeePerGas?.getInWei;
    final gasLimit = transaction.maxGas;
    final value = transaction.value?.getInWei.toDouble().toString();
    final nonce = transaction.nonce;

    final transferType = token?.address != null ? TransferType.erc20 : null;

    // For token transfer If It's null It's going to be initialized after tx is done
    final data = transaction.data != null
        ? MXCType.uint8ListToString(transaction.data!)
        : null;

    // How about token transfer which contains data but is contract call
    final txType = token?.address != null || data == null
        ? TransactionType.sent
        : TransactionType.contractCall;

    return TransactionModel(
      hash: '',
      timeStamp: timeStamp,
      status: txStatus,
      type: txType,
      value: value,
      token: token ?? const Token(),
      action: null,
      from: from?.hex,
      to: to.hex,
      feePerGas: feePerGas,
      data: data,
      gasLimit: gasLimit,
      nonce: nonce,
      maxPriorityFee: maxPriorityFeePerGas,
      transferType: transferType,
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
      nonce: map['nonce'] as int?,
      maxPriorityFee:
          map['maxPriorityFee'] != null && map['maxPriorityFee'] != 'null'
              ? BigInt.parse(map['maxPriorityFee'])
              : null,
      transferType: map['transferType'] != null && map['transferType'] != 'null'
          ? TransferType.values.firstWhere(
              (transferType) =>
                  transferType.toString().split('.').last ==
                  map['transferType'],
            )
          : null,
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
    this.nonce,
    this.maxPriorityFee,
    this.transferType,
  });

  TransactionModel copyWith({
    String? hash,
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
    int? gasLimit,
    int? nonce,
    BigInt? maxPriorityFee,
    TransferType? transferType,
  }) {
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
      nonce: nonce ?? this.nonce,
      maxPriorityFee: maxPriorityFee ?? this.maxPriorityFee,
      transferType: transferType ?? this.transferType,
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
      'gasLimit': gasLimit,
      'nonce': nonce,
      'maxPriorityFee': maxPriorityFee.toString(),
      'transferType': transferType?.toString().split('.').last,
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

  /// The value that is transferred in transaction, The unit is in Wei.
  final String? value;

  final Token token;

  // Below variables are added for speed up & cancel feature
  // pending transactions must contains these props (Some props depending on the case) .
  final String? from;

  final String? to;

  final double? feePerGas;

  final BigInt? maxPriorityFee;

  final int? gasLimit;

  final String? data;

  final int? nonce;

  // This is for detecting the token transfer from coin transfer in MXC Chains since BlockScout sends value in both cases
  // And that makes hard to detect wether to send the value for speed up.
  final TransferType? transferType;
}
