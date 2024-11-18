import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/domain/entities/moonchain/moonchain_transactions_model/decoded_input.dart';import 'decoded_input.dart';


import 'fee.dart';

class MoonchainTransactionModel extends Equatable {

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MoonchainTransactionModel].
  factory MoonchainTransactionModel.fromJson(String data) {
    return MoonchainTransactionModel.fromMap(
        json.decode(data) as Map<String, dynamic>,);
  }

  factory MoonchainTransactionModel.fromMap(Map<String, dynamic> data) {
    return MoonchainTransactionModel(
      timestamp: data['timestamp'] == null
          ? null
          : DateTime.parse(data['timestamp'] as String),
      fee: data['fee'] == null
          ? null
          : Fee.fromMap(data['fee'] as Map<String, dynamic>),
      gasLimit: data['gas_limit'] as String?,
      block: data['block'] as int?,
      status: data['status'] as String?,
      method: data['method'] as String?,
      confirmations: data['confirmations'] as int?,
      type: data['type'] as int?,
      exchangeRate: data['exchange_rate'] as dynamic,
      to: data['to'] == null
          ? null
          : To.fromMap(data['to'] as Map<String, dynamic>),
      txBurntFee: data['tx_burnt_fee'] as String?,
      maxFeePerGas: data['max_fee_per_gas'] as String?,
      result: data['result'] as String?,
      hash: data['hash'] as String?,
      gasPrice: data['gas_price'] as String?,
      priorityFee: data['priority_fee'] as String?,
      baseFeePerGas: data['base_fee_per_gas'] as String?,
      from: data['from'] == null
          ? null
          : From.fromMap(data['from'] as Map<String, dynamic>),
      tokenTransfers: (data['token_transfers'] as List<dynamic>?)
          ?.map((dynamic e) => TokenTransfer.fromMap(e as Map<String, dynamic>))
          .toList(),
      txTypes: (data['tx_types'] as List<dynamic>?)?.cast<String>(),
      gasUsed: data['gas_used'] as String?,
      createdContract: data['created_contract'] as dynamic,
      position: data['position'] as int?,
      nonce: data['nonce'] as int?,
      hasErrorInInternalTxs: data['has_error_in_internal_txs'] as bool?,
      actions: data['actions'] as List<dynamic>?,
      decodedInput: data['decoded_input'] == null
          ? null
          : DecodedInput.fromJson(data['decoded_input']),
      tokenTransfersOverflow: data['token_transfers_overflow'] as bool?,
      rawInput: data['raw_input'] as String?,
      value: data['value'] as String?,
      maxPriorityFeePerGas: data['max_priority_fee_per_gas'] as String?,
      revertReason: data['revert_reason'] as dynamic,
      confirmationDuration: (data['confirmation_duration'] as List<dynamic>?)
          ?.map<double>((dynamic item) => double.parse(item.toString()))
          .toList(),
      txTag: data['tx_tag'] as dynamic,
    );
  }

  MoonchainTransactionModel({
    this.timestamp,
    this.fee,
    this.gasLimit,
    this.block,
    this.status,
    this.method,
    this.confirmations,
    this.type,
    this.exchangeRate,
    this.to,
    this.txBurntFee,
    this.maxFeePerGas,
    this.result,
    this.hash,
    this.gasPrice,
    this.priorityFee,
    this.baseFeePerGas,
    this.from,
    this.tokenTransfers,
    this.txTypes,
    this.gasUsed,
    this.createdContract,
    this.position,
    this.nonce,
    this.hasErrorInInternalTxs,
    this.actions,
    this.decodedInput,
    this.tokenTransfersOverflow,
    this.rawInput,
    this.value,
    this.maxPriorityFeePerGas,
    this.revertReason,
    this.confirmationDuration,
    this.txTag,
  });
  final DateTime? timestamp;
  final Fee? fee;
  final String? gasLimit;
  final int? block;
  final String? status;
  final String? method;
  final int? confirmations;
  final int? type;
  final dynamic exchangeRate;
  final To? to;
  final String? txBurntFee;
  final String? maxFeePerGas;
  final String? result;
  final String? hash;
  final String? gasPrice;
  final String? priorityFee;
  final String? baseFeePerGas;
  final From? from;
  final List<TokenTransfer>? tokenTransfers;
  final List<String>? txTypes;
  final String? gasUsed;
  final dynamic createdContract;
  final int? position;
  final int? nonce;
  final bool? hasErrorInInternalTxs;
  final List<dynamic>? actions;
  final DecodedInput? decodedInput;
  final bool? tokenTransfersOverflow;
  final String? rawInput;
  String? value;
  final String? maxPriorityFeePerGas;
  final dynamic revertReason;
  final List<double>? confirmationDuration;
  final dynamic txTag;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'timestamp': timestamp?.toIso8601String(),
        'fee': fee?.toMap(),
        'gas_limit': gasLimit,
        'block': block,
        'status': status,
        'method': method,
        'confirmations': confirmations,
        'type': type,
        'exchange_rate': exchangeRate,
        'to': to?.toMap(),
        'tx_burnt_fee': txBurntFee,
        'max_fee_per_gas': maxFeePerGas,
        'result': result,
        'hash': hash,
        'gas_price': gasPrice,
        'priority_fee': priorityFee,
        'base_fee_per_gas': baseFeePerGas,
        'from': from?.toMap(),
        'token_transfers': tokenTransfers?.map((e) => e.toMap()).toList(),
        'tx_types': txTypes,
        'gas_used': gasUsed,
        'created_contract': createdContract,
        'position': position,
        'nonce': nonce,
        'has_error_in_internal_txs': hasErrorInInternalTxs,
        'actions': actions,
        'decoded_input': decodedInput,
        'token_transfers_overflow': tokenTransfersOverflow,
        'raw_input': rawInput,
        'value': value,
        'max_priority_fee_per_gas': maxPriorityFeePerGas,
        'revert_reason': revertReason,
        'confirmation_duration': confirmationDuration,
        'tx_tag': txTag,
      };

  /// `dart:convert`
  ///
  /// Converts [MoonchainTransactionModel] to a JSON string.
  String toJson() => json.encode(toMap());

  MoonchainTransactionModel copyWith({
    DateTime? timestamp,
    Fee? fee,
    String? gasLimit,
    int? block,
    String? status,
    String? method,
    int? confirmations,
    int? type,
    dynamic exchangeRate,
    To? to,
    String? txBurntFee,
    String? maxFeePerGas,
    String? result,
    String? hash,
    String? gasPrice,
    String? priorityFee,
    String? baseFeePerGas,
    From? from,
    List<TokenTransfer>? tokenTransfers,
    List<String>? txTypes,
    String? gasUsed,
    dynamic createdContract,
    int? position,
    int? nonce,
    bool? hasErrorInInternalTxs,
    List<dynamic>? actions,
    dynamic decodedInput,
    bool? tokenTransfersOverflow,
    String? rawInput,
    String? value,
    String? maxPriorityFeePerGas,
    dynamic revertReason,
    List<double>? confirmationDuration,
    dynamic txTag,
  }) {
    return MoonchainTransactionModel(
      timestamp: timestamp ?? this.timestamp,
      fee: fee ?? this.fee,
      gasLimit: gasLimit ?? this.gasLimit,
      block: block ?? this.block,
      status: status ?? this.status,
      method: method ?? this.method,
      confirmations: confirmations ?? this.confirmations,
      type: type ?? this.type,
      exchangeRate: exchangeRate ?? this.exchangeRate,
      to: to ?? this.to,
      txBurntFee: txBurntFee ?? this.txBurntFee,
      maxFeePerGas: maxFeePerGas ?? this.maxFeePerGas,
      result: result ?? this.result,
      hash: hash ?? this.hash,
      gasPrice: gasPrice ?? this.gasPrice,
      priorityFee: priorityFee ?? this.priorityFee,
      baseFeePerGas: baseFeePerGas ?? this.baseFeePerGas,
      from: from ?? this.from,
      tokenTransfers: tokenTransfers ?? this.tokenTransfers,
      txTypes: txTypes ?? this.txTypes,
      gasUsed: gasUsed ?? this.gasUsed,
      createdContract: createdContract ?? this.createdContract,
      position: position ?? this.position,
      nonce: nonce ?? this.nonce,
      hasErrorInInternalTxs:
          hasErrorInInternalTxs ?? this.hasErrorInInternalTxs,
      actions: actions ?? this.actions,
      decodedInput: decodedInput ?? this.decodedInput,
      tokenTransfersOverflow:
          tokenTransfersOverflow ?? this.tokenTransfersOverflow,
      rawInput: rawInput ?? this.rawInput,
      value: value ?? this.value,
      maxPriorityFeePerGas: maxPriorityFeePerGas ?? this.maxPriorityFeePerGas,
      revertReason: revertReason ?? this.revertReason,
      confirmationDuration: confirmationDuration ?? this.confirmationDuration,
      txTag: txTag ?? this.txTag,
    );
  }

  TransactionType checkForTransactionType(
    String userAddress,
    String currentTxFromHash,
  ) {
    if (EthereumAddress.fromHex(currentTxFromHash) ==
        EthereumAddress.fromHex(userAddress)) {
      return TransactionType.sent;
    } else {
      return TransactionType.received;
    }
  }

  @override
  List<Object?> get props {
    return [
      timestamp,
      fee,
      gasLimit,
      block,
      status,
      method,
      confirmations,
      type,
      exchangeRate,
      to,
      txBurntFee,
      maxFeePerGas,
      result,
      hash,
      gasPrice,
      priorityFee,
      baseFeePerGas,
      from,
      tokenTransfers,
      txTypes,
      gasUsed,
      createdContract,
      position,
      nonce,
      hasErrorInInternalTxs,
      actions,
      decodedInput,
      tokenTransfersOverflow,
      rawInput,
      value,
      maxPriorityFeePerGas,
      revertReason,
      confirmationDuration,
      txTag,
    ];
  }
}
