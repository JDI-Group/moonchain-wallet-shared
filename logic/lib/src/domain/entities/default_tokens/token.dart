import 'dart:convert';

import 'package:equatable/equatable.dart';

class Token extends Equatable {
  const Token({
    this.chainId,
    this.address,
    this.name,
    this.symbol,
    this.decimals,
    this.logoUri,
    this.balance = 0.0,
    this.balancePrice = 0.0,
  });

  final int? chainId;
  final String? address;
  final String? name;
  final String? symbol;
  final int? decimals;
  final String? logoUri;
  final double? balance;
  final double? balancePrice;

  factory Token.fromMap(Map<String, dynamic> data) => Token(
        chainId: data['chainId'] as int?,
        address: data['address'] as String?,
        name: data['name'] as String?,
        symbol: data['symbol'] as String?,
        decimals: data['decimals'] as int?,
        logoUri: data['logoURI'] as String?,
        balance: data['balance'] == null ? 0.0 : data['balance'] as double,
        balancePrice:
            data['balancePrice'] == null ? 0.0 : data['balancePrice'] as double,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'chainId': chainId,
        'address': address,
        'name': name,
        'symbol': symbol,
        'decimals': decimals,
        'logoURI': logoUri,
        'balance': balance,
        'balancePrice': balancePrice
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Token].
  factory Token.fromJson(String data) {
    return Token.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Token] to a JSON string.
  String toJson() => json.encode(toMap());

  Token copyWith({
    int? chainId,
    String? address,
    String? name,
    String? symbol,
    int? decimals,
    String? logoUri,
    double? balance,
    double? balancePrice,
  }) {
    return Token(
        chainId: chainId ?? this.chainId,
        address: address ?? this.address,
        name: name ?? this.name,
        symbol: symbol ?? this.symbol,
        decimals: decimals ?? this.decimals,
        logoUri: logoUri ?? this.logoUri,
        balance: balance ?? this.balance,
        balancePrice: balancePrice ?? this.balancePrice);
  }

  @override
  List<Object?> get props {
    return [chainId, address, name, symbol, decimals, logoUri, balance, balancePrice];
  }
}
