import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'wannsee_transaction_model.dart';

export 'wannsee_transaction_model.dart';

import '../shared/shared.dart';

class WannseeTransactionsModel with EquatableMixin {
  final List<WannseeTransactionModel>? items;
  final dynamic nextPageParams;

  const WannseeTransactionsModel({this.items, this.nextPageParams});

  factory WannseeTransactionsModel.fromMap(Map<String, dynamic> data) {
    return WannseeTransactionsModel(
      items: (data['items'] as List<dynamic>?)
          ?.map((dynamic e) =>
              WannseeTransactionModel.fromMap(e as Map<String, dynamic>))
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
  /// Parses the string and returns the resulting Json object as [WannseeTransactionsModel].
  factory WannseeTransactionsModel.fromJson(String data) {
    return WannseeTransactionsModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [WannseeTransactionsModel] to a JSON string.
  String toJson() => json.encode(toMap());

  WannseeTransactionsModel copyWith({
    List<WannseeTransactionModel>? items,
    dynamic nextPageParams,
  }) {
    return WannseeTransactionsModel(
      items: items ?? this.items,
      nextPageParams: nextPageParams ?? this.nextPageParams,
    );
  }

  @override
  List<Object?> get props => [items, nextPageParams];
}
