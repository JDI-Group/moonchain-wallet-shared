import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'item.dart';

class MoonchainNftCollectionDetailResponse extends Equatable {

  const MoonchainNftCollectionDetailResponse({this.items, this.nextPageParams});

  factory MoonchainNftCollectionDetailResponse.fromMap(
      Map<String, dynamic> data) {
    return MoonchainNftCollectionDetailResponse(
      items: (data['items'] as List<dynamic>?)
          ?.map((dynamic e) => Item.fromMap(e as Map<String, dynamic>))
          .toList(),
      nextPageParams: data['next_page_params'] as dynamic,
    );
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MoonchainNftCollectionDetailResponse].
  factory MoonchainNftCollectionDetailResponse.fromJson(String data) {
    return MoonchainNftCollectionDetailResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }
  final List<Item>? items;
  final dynamic nextPageParams;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'items': items?.map((e) => e.toMap()).toList(),
        'next_page_params': nextPageParams,
      };

  /// `dart:convert`
  ///
  /// Converts [MoonchainNftCollectionDetailResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  MoonchainNftCollectionDetailResponse copyWith({
    List<Item>? items,
    dynamic nextPageParams,
  }) {
    return MoonchainNftCollectionDetailResponse(
      items: items ?? this.items,
      nextPageParams: nextPageParams ?? this.nextPageParams,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [items, nextPageParams];
}
