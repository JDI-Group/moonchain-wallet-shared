import 'dart:convert';

import 'package:equatable/equatable.dart';

class Token extends Equatable {

  factory Token.fromMap(Map<String, dynamic> data) => Token(
        address: data['address'] as String?,
        circulatingMarketCap: data['circulating_market_cap'] as dynamic,
        decimals: data['decimals'] as dynamic,
        exchangeRate: data['exchange_rate'] as dynamic,
        holders: data['holders'] as String?,
        iconUrl: data['icon_url'] as dynamic,
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
  const Token({
    this.address,
    this.circulatingMarketCap,
    this.decimals,
    this.exchangeRate,
    this.holders,
    this.iconUrl,
    this.name,
    this.symbol,
    this.totalSupply,
    this.type,
  });

  final String? address;
  final dynamic circulatingMarketCap;
  final dynamic decimals;
  final dynamic exchangeRate;
  final String? holders;
  final dynamic iconUrl;
  final String? name;
  final String? symbol;
  final String? totalSupply;
  final String? type;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'address': address,
        'circulating_market_cap': circulatingMarketCap,
        'decimals': decimals,
        'exchange_rate': exchangeRate,
        'holders': holders,
        'icon_url': iconUrl,
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
    dynamic circulatingMarketCap,
    dynamic decimals,
    dynamic exchangeRate,
    String? holders,
    dynamic iconUrl,
    String? name,
    String? symbol,
    String? totalSupply,
    String? type,
  }) {
    return Token(
      address: address ?? this.address,
      circulatingMarketCap: circulatingMarketCap ?? this.circulatingMarketCap,
      decimals: decimals ?? this.decimals,
      exchangeRate: exchangeRate ?? this.exchangeRate,
      holders: holders ?? this.holders,
      iconUrl: iconUrl ?? this.iconUrl,
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
      circulatingMarketCap,
      decimals,
      exchangeRate,
      holders,
      iconUrl,
      name,
      symbol,
      totalSupply,
      type,
    ];
  }
}
