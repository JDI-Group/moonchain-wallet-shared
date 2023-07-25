import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'item.dart';

class WannseeNftCollectionDetail extends Equatable {
  final List<Item>? items;
  final dynamic nextPageParams;

  const WannseeNftCollectionDetail({this.items, this.nextPageParams});

  factory WannseeNftCollectionDetail.fromMap(Map<String, dynamic> data) {
    return WannseeNftCollectionDetail(
      items: (data['items'] as List<dynamic>?)
          ?.map((dynamic e) => Item.fromMap(e as Map<String, dynamic>))
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
  /// Parses the string and returns the resulting Json object as [WannseeNftCollectionDetail].
  factory WannseeNftCollectionDetail.fromJson(String data) {
    return WannseeNftCollectionDetail.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [WannseeNftCollectionDetail] to a JSON string.
  String toJson() => json.encode(toMap());

  WannseeNftCollectionDetail copyWith({
    List<Item>? items,
    dynamic nextPageParams,
  }) {
    return WannseeNftCollectionDetail(
      items: items ?? this.items,
      nextPageParams: nextPageParams ?? this.nextPageParams,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [items, nextPageParams];
}
