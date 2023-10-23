import 'dart:convert';

import 'package:equatable/equatable.dart';

class ChainRpcUrl extends Equatable {
  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ChainRpcUrl].
  factory ChainRpcUrl.fromJson(String data) {
    return ChainRpcUrl.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  factory ChainRpcUrl.fromMap(Map<String, dynamic> data) => ChainRpcUrl(
        chainId: data['chain_id'] as int?,
        httpUrl: data['http_url'] as String,
        wssUrl: data['wss_url'] as String,
      );

  const ChainRpcUrl({this.chainId, this.wssUrl, this.httpUrl});
  final int? chainId;
  final String? httpUrl;
  final String? wssUrl;

  Map<String, dynamic> toMap() =>
      {'chain_id': chainId, 'http_url': httpUrl, 'wss_url': wssUrl};

  /// `dart:convert`
  ///
  /// Converts [ChainRpcUrl] to a JSON string.
  String toJson() => json.encode(toMap());

  ChainRpcUrl copyWith({
    int? chainId,
    String? httpUrl,
    String? wssUrl,
  }) {
    return ChainRpcUrl(
        chainId: chainId ?? this.chainId,
        httpUrl: httpUrl ?? this.httpUrl,
        wssUrl: wssUrl ?? this.wssUrl);
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [chainId, httpUrl, wssUrl];
}
