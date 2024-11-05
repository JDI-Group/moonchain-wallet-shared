import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'item.dart';

class MoonchainTokensBalanceResponseModel extends Equatable {

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MoonchainTokensBalanceResponseModel].
  factory MoonchainTokensBalanceResponseModel.fromJson(String data) {
    return MoonchainTokensBalanceResponseModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  factory MoonchainTokensBalanceResponseModel.fromMap(Map<String, dynamic> data) {
    return MoonchainTokensBalanceResponseModel(
      items: (data['items'] as List<dynamic>?)
          ?.map((dynamic e) => TokenItem.fromMap(e as Map<String, dynamic>))
          .toList(),
      nextPageParams: data['next_page_params'] as dynamic,
    );
  }

  const MoonchainTokensBalanceResponseModel({this.items, this.nextPageParams});
  final List<TokenItem>? items;
  final dynamic nextPageParams;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'items': items?.map((e) => e.toMap()).toList(),
        'next_page_params': nextPageParams,
      };

  /// `dart:convert`
  ///
  /// Converts [MoonchainTokensBalanceResponseModel] to a JSON string.
  String toJson() => json.encode(toMap());

  MoonchainTokensBalanceResponseModel copyWith({
    List<TokenItem>? items,
    dynamic nextPageParams,
  }) {
    return MoonchainTokensBalanceResponseModel(
      items: items ?? this.items,
      nextPageParams: nextPageParams ?? this.nextPageParams,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [items, nextPageParams];
}
