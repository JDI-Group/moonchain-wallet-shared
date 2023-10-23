import 'dart:convert';

import 'package:equatable/equatable.dart';

class WatchAssetModel extends Equatable {
  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [WatchAssetModel].
  factory WatchAssetModel.fromJson(String data) {
    return WatchAssetModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  factory WatchAssetModel.fromMap(Map<String, dynamic> data) {
    return WatchAssetModel(
      contract: data['contract'] as String?,
      symbol: data['symbol'] as String?,
      decimals: data['decimals'] as int?,
    );
  }

  const WatchAssetModel({this.contract, this.symbol, this.decimals});
  final String? contract;
  final String? symbol;
  final int? decimals;

  Map<String, dynamic> toMap() => {
        'contract': contract,
        'symbol': symbol,
        'decimals': decimals,
      };

  /// `dart:convert`
  ///
  /// Converts [WatchAssetModel] to a JSON string.
  String toJson() => json.encode(toMap());

  WatchAssetModel copyWith({
    String? contract,
    String? symbol,
    int? decimals,
  }) {
    return WatchAssetModel(
      contract: contract ?? this.contract,
      symbol: symbol ?? this.symbol,
      decimals: decimals ?? this.decimals,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [contract, symbol, decimals];
}
