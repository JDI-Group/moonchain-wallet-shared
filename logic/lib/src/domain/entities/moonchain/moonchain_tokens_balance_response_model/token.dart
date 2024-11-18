import 'dart:convert';

import 'package:equatable/equatable.dart';

class Token extends Equatable {

  const Token({
    this.address,
    this.decimals,
    this.exchangeRate,
    this.holders,
    this.name,
    this.symbol,
    this.totalSupply,
    this.type,
  });

  factory Token.fromMap(Map<String, dynamic> data) => Token(
        address: data['address'] as String?,
        decimals: data['decimals'] as String?,
        exchangeRate: data['exchange_rate'] as dynamic,
        holders: data['holders'] as String?,
        name: data['name'] as String?,
        symbol: data['symbol'] as String?,
        totalSupply: data['total_supply'] as String?,
        type: data['type'] as String?,
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Token].
  factory Token.fromJson(String data) {
    return Token.fromMap(json.decode(data) as Map<String, dynamic>);
  }
  final String? address;
  final String? decimals;
  final dynamic exchangeRate;
  final String? holders;
  final String? name;
  final String? symbol;
  final String? totalSupply;
  final String? type;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'address': address,
        'decimals': decimals,
        'exchange_rate': exchangeRate,
        'holders': holders,
        'name': name,
        'symbol': symbol,
        'total_supply': totalSupply,
        'type': type,
      };

  /// `dart:convert`
  ///
  /// Converts [Token] to a JSON string.
  String toJson() => json.encode(toMap());

  Token copyWith({
    String? address,
    String? decimals,
    dynamic exchangeRate,
    String? holders,
    String? name,
    String? symbol,
    String? totalSupply,
    String? type,
  }) {
    return Token(
      address: address ?? this.address,
      decimals: decimals ?? this.decimals,
      exchangeRate: exchangeRate ?? this.exchangeRate,
      holders: holders ?? this.holders,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      totalSupply: totalSupply ?? this.totalSupply,
      type: type ?? this.type,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      address,
      decimals,
      exchangeRate,
      holders,
      name,
      symbol,
      totalSupply,
      type,
    ];
  }
}
