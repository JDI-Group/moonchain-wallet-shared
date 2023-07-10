import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'item.dart';

class WannseeTokensBalanceModel extends Equatable {
  final List<TokenItem>? items;
  final dynamic nextPageParams;

  const WannseeTokensBalanceModel({this.items, this.nextPageParams});

  factory WannseeTokensBalanceModel.fromMap(Map<String, dynamic> data) {
    return WannseeTokensBalanceModel(
      items: (data['items'] as List<dynamic>?)
          ?.map((dynamic e) => TokenItem.fromMap(e as Map<String, dynamic>))
          .toList(),
      nextPageParams: data['next_page_params'] as dynamic,
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'items': items?.map((e) => e.toMap()).toList(),
        'next_page_params': nextPageParams,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [WannseeTokensBalanceModel].
  factory WannseeTokensBalanceModel.fromJson(String data) {
    return WannseeTokensBalanceModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [WannseeTokensBalanceModel] to a JSON string.
  String toJson() => json.encode(toMap());

  WannseeTokensBalanceModel copyWith({
    List<TokenItem>? items,
    dynamic nextPageParams,
  }) {
    return WannseeTokensBalanceModel(
      items: items ?? this.items,
      nextPageParams: nextPageParams ?? this.nextPageParams,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [items, nextPageParams];
}
