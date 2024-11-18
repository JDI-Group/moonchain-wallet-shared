import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'item.dart';

class MoonchainAddressTokensListResponse extends Equatable {

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MoonchainAddressTokensListResponse].
  factory MoonchainAddressTokensListResponse.fromJson(String data) {
    return MoonchainAddressTokensListResponse.fromMap(
        json.decode(data) as Map<String, dynamic>,);
  }

  factory MoonchainAddressTokensListResponse.fromMap(
      Map<String, dynamic> data,) {
    return MoonchainAddressTokensListResponse(
      items: (data['items'] as List<dynamic>?)
          ?.map((dynamic e) => Item.fromMap(e as Map<String, dynamic>))
          .toList(),
      nextPageParams: data['next_page_params'] as dynamic,
    );
  }
  const MoonchainAddressTokensListResponse({this.items, this.nextPageParams});

  final List<Item>? items;
  final dynamic nextPageParams;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'items': items?.map((e) => e.toMap()).toList(),
        'next_page_params': nextPageParams,
      };

  /// `dart:convert`
  ///
  /// Converts [MoonchainAddressTokensListResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  MoonchainAddressTokensListResponse copyWith({
    List<Item>? items,
    dynamic nextPageParams,
  }) {
    return MoonchainAddressTokensListResponse(
      items: items ?? this.items,
      nextPageParams: nextPageParams ?? this.nextPageParams,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [items, nextPageParams];
}
