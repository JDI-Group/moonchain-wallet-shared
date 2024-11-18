import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'moonchain_transaction_model.dart';

export 'moonchain_transaction_model.dart';

import '../shared/shared.dart';

class MoonchainTransactionsModel extends Equatable {

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MoonchainTransactionsModel].
  factory MoonchainTransactionsModel.fromJson(String data) {
    return MoonchainTransactionsModel.fromMap(
        json.decode(data) as Map<String, dynamic>,);
  }

  factory MoonchainTransactionsModel.fromMap(Map<String, dynamic> data) {
    return MoonchainTransactionsModel(
      items: (data['items'] as List<dynamic>?)
          ?.map((dynamic e) =>
              MoonchainTransactionModel.fromMap(e as Map<String, dynamic>),)
          .toList(),
      nextPageParams: data['next_page_params'] as dynamic,
    );
  }

  const MoonchainTransactionsModel({this.items, this.nextPageParams});
  final List<MoonchainTransactionModel>? items;
  final dynamic nextPageParams;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'items': items?.map((e) => e.toMap()).toList(),
        'next_page_params': nextPageParams,
      };

  /// `dart:convert`
  ///
  /// Converts [MoonchainTransactionsModel] to a JSON string.
  String toJson() => json.encode(toMap());

  MoonchainTransactionsModel copyWith({
    List<MoonchainTransactionModel>? items,
    dynamic nextPageParams,
  }) {
    return MoonchainTransactionsModel(
      items: items ?? this.items,
      nextPageParams: nextPageParams ?? this.nextPageParams,
    );
  }

  @override
  List<Object?> get props => [items, nextPageParams];
}
