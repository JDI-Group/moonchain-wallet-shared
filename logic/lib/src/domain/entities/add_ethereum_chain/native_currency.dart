import 'dart:convert';

import 'package:equatable/equatable.dart';

class NativeCurrency extends Equatable {
  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [NativeCurrency].
  factory NativeCurrency.fromJson(String data) {
    return NativeCurrency.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  factory NativeCurrency.fromMap(Map<String, dynamic> data) {
    return NativeCurrency(
      name: data['name'] as String?,
      symbol: data['symbol'] as String?,
      decimals: data['decimals'] as int?,
    );
  }

  const NativeCurrency({this.name, this.symbol, this.decimals});
  final String? name;
  final String? symbol;
  final int? decimals;

  Map<String, dynamic> toMap() => {
        'name': name,
        'symbol': symbol,
        'decimals': decimals,
      };

  /// `dart:convert`
  ///
  /// Converts [NativeCurrency] to a JSON string.
  String toJson() => json.encode(toMap());

  NativeCurrency copyWith({
    String? name,
    String? symbol,
    int? decimals,
  }) {
    return NativeCurrency(
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      decimals: decimals ?? this.decimals,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name, symbol, decimals];
}
