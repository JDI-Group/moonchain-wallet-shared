import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../shared/shared.dart';

class MoonchainTokenTransfersResponseModel extends Equatable {

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MoonchainTokenTransfersResponseModel].
  factory MoonchainTokenTransfersResponseModel.fromJson(String data) {
    return MoonchainTokenTransfersResponseModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  factory MoonchainTokenTransfersResponseModel.fromMap(
      Map<String, dynamic> data) {
    return MoonchainTokenTransfersResponseModel(
      items: (data['items'] as List<dynamic>?)
          ?.map((dynamic e) => TokenTransfer.fromMap(e as Map<String, dynamic>))
          .toList(),
      nextPageParams: data['next_page_params'] as dynamic,
    );
  }

  const MoonchainTokenTransfersResponseModel({this.items, this.nextPageParams});
  final List<TokenTransfer>? items;
  final dynamic nextPageParams;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'items': items?.map((e) => e.toMap()).toList(),
        'next_page_params': nextPageParams,
      };

  /// `dart:convert`
  ///
  /// Converts [MoonchainTokenTransfersResponseModel] to a JSON string.
  String toJson() => json.encode(toMap());

  MoonchainTokenTransfersResponseModel copyWith({
    List<TokenTransfer>? items,
    dynamic nextPageParams,
  }) {
    return MoonchainTokenTransfersResponseModel(
      items: items ?? this.items,
      nextPageParams: nextPageParams ?? this.nextPageParams,
    );
  }

  @override
  List<Object?> get props => [items, nextPageParams];
}
