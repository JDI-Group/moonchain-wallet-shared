import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../shared/shared.dart';

class WannseeTokenTransfersModel extends Equatable {
  final List<TokenTransfer>? items;
  final dynamic nextPageParams;

  const WannseeTokenTransfersModel({this.items, this.nextPageParams});

  factory WannseeTokenTransfersModel.fromMap(Map<String, dynamic> data) {
    return WannseeTokenTransfersModel(
      items: (data['items'] as List<dynamic>?)
          ?.map((dynamic e) => TokenTransfer.fromMap(e as Map<String, dynamic>))
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
  /// Parses the string and returns the resulting Json object as [WannseeTokenTransfersModel].
  factory WannseeTokenTransfersModel.fromJson(String data) {
    return WannseeTokenTransfersModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [WannseeTokenTransfersModel] to a JSON string.
  String toJson() => json.encode(toMap());

  WannseeTokenTransfersModel copyWith({
    List<TokenTransfer>? items,
    dynamic nextPageParams,
  }) {
    return WannseeTokenTransfersModel(
      items: items ?? this.items,
      nextPageParams: nextPageParams ?? this.nextPageParams,
    );
  }

  @override
  List<Object?> get props => [items, nextPageParams];
}
