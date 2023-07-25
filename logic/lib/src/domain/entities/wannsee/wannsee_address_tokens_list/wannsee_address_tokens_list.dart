import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'item.dart';

class WannseeAddressTokensList extends Equatable {
  const WannseeAddressTokensList({this.items, this.nextPageParams});

  final List<Item>? items;
  final dynamic nextPageParams;

  factory WannseeAddressTokensList.fromMap(Map<String, dynamic> data) {
    return WannseeAddressTokensList(
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
  /// Parses the string and returns the resulting Json object as [WannseeAddressTokensList].
  factory WannseeAddressTokensList.fromJson(String data) {
    return WannseeAddressTokensList.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [WannseeAddressTokensList] to a JSON string.
  String toJson() => json.encode(toMap());

  WannseeAddressTokensList copyWith({
    List<Item>? items,
    dynamic nextPageParams,
  }) {
    return WannseeAddressTokensList(
      items: items ?? this.items,
      nextPageParams: nextPageParams ?? this.nextPageParams,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [items, nextPageParams];
}
