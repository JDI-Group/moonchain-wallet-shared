import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'token.dart';

class Item extends Equatable {

  factory Item.fromMap(Map<String, dynamic> data) => Item(
        token: data['token'] == null
            ? null
            : Token.fromMap(data['token'] as Map<String, dynamic>),
        tokenId: data['token_id'] as dynamic,
        tokenInstance: data['token_instance'] as dynamic,
        value: data['value'] as String?,
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Item].
  factory Item.fromJson(String data) {
    return Item.fromMap(json.decode(data) as Map<String, dynamic>);
  }
  const Item({this.token, this.tokenId, this.tokenInstance, this.value});

  final Token? token;
  final dynamic tokenId;
  final dynamic tokenInstance;
  final String? value;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'token': token?.toMap(),
        'token_id': tokenId,
        'token_instance': tokenInstance,
        'value': value,
      };

  /// `dart:convert`
  ///
  /// Converts [Item] to a JSON string.
  String toJson() => json.encode(toMap());

  Item copyWith({
    Token? token,
    dynamic tokenId,
    dynamic tokenInstance,
    String? value,
  }) {
    return Item(
      token: token ?? this.token,
      tokenId: tokenId ?? this.tokenId,
      tokenInstance: tokenInstance ?? this.tokenInstance,
      value: value ?? this.value,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [token, tokenId, tokenInstance, value];
}
