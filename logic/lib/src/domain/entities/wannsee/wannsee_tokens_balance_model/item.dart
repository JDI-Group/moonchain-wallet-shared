import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'token.dart';

class TokenItem extends Equatable {
  final Token? token;
  final dynamic tokenId;
  final String? value;

  const TokenItem({this.token, this.tokenId, this.value});

  factory TokenItem.fromMap(Map<String, dynamic> data) => TokenItem(
        token: data['token'] == null
            ? null
            : Token.fromMap(data['token'] as Map<String, dynamic>),
        tokenId: data['token_id'] as dynamic,
        value: data['value'] as String?,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'token': token?.toMap(),
        'token_id': tokenId,
        'value': value,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TokenItem].
  factory TokenItem.fromJson(String data) {
    return TokenItem.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TokenItem] to a JSON string.
  String toJson() => json.encode(toMap());

  TokenItem copyWith({
    Token? token,
    dynamic tokenId,
    String? value,
  }) {
    return TokenItem(
      token: token ?? this.token,
      tokenId: tokenId ?? this.tokenId,
      value: value ?? this.value,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [token, tokenId, value];
}
