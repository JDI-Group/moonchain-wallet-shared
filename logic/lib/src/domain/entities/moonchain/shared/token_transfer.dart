import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'from.dart';
import 'to.dart';
import 'token.dart';
import 'total.dart';

class TokenTransfer extends Equatable {

  TokenTransfer({
    this.blockHash,
    this.from,
    this.logIndex,
    this.method,
    this.timestamp,
    this.to,
    this.token,
    this.total,
    this.txHash,
    this.type,
  });

  factory TokenTransfer.fromMap(Map<String, dynamic> data) => TokenTransfer(
        blockHash: data['block_hash'] as String?,
        from: data['from'] == null
            ? null
            : From.fromMap(data['from'] as Map<String, dynamic>),
        logIndex: data['log_index'] as int?,
        method: data['method'] as dynamic,
        timestamp: data['timestamp'] == null
            ? null
            : DateTime.parse(data['timestamp'] as String),
        to: data['to'] == null
            ? null
            : To.fromMap(data['to'] as Map<String, dynamic>),
        token: data['token'] == null
            ? null
            : Token.fromMap(data['token'] as Map<String, dynamic>),
        total: data['total'] == null
            ? null
            : Total.fromMap(data['total'] as Map<String, dynamic>),
        txHash: data['tx_hash'] as String?,
        type: data['type'] as String?,
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TokenTransfer].
  factory TokenTransfer.fromJson(String data) {
    return TokenTransfer.fromMap(json.decode(data) as Map<String, dynamic>);
  }
  final String? blockHash;
  From? from;
  final int? logIndex;
  final dynamic method;
  final DateTime? timestamp;
  To? to;
  final Token? token;
  final Total? total;
  final String? txHash;
  final String? type;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'block_hash': blockHash,
        'from': from?.toMap(),
        'log_index': logIndex,
        'method': method,
        'timestamp': timestamp?.toIso8601String(),
        'to': to?.toMap(),
        'token': token?.toMap(),
        'total': total?.toMap(),
        'tx_hash': txHash,
        'type': type,
      };

  /// `dart:convert`
  ///
  /// Converts [TokenTransfer] to a JSON string.
  String toJson() => json.encode(toMap());

  TokenTransfer copyWith({
    String? blockHash,
    From? from,
    int? logIndex,
    dynamic method,
    DateTime? timestamp,
    To? to,
    Token? token,
    Total? total,
    String? txHash,
    String? type,
  }) {
    return TokenTransfer(
      blockHash: blockHash ?? this.blockHash,
      from: from ?? this.from,
      logIndex: logIndex ?? this.logIndex,
      method: method ?? this.method,
      timestamp: timestamp ?? this.timestamp,
      to: to ?? this.to,
      token: token ?? this.token,
      total: total ?? this.total,
      txHash: txHash ?? this.txHash,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props {
    return [
      blockHash,
      from,
      logIndex,
      method,
      timestamp,
      to,
      token,
      total,
      txHash,
      type,
    ];
  }
}
