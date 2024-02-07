import 'dart:convert';

import 'package:flutter/foundation.dart';

class RewardsRequestModel {
  factory RewardsRequestModel.fromJson(String source) =>
      RewardsRequestModel.fromMap(json.decode(source));

  factory RewardsRequestModel.fromMap(Map<String, dynamic> map) {
    return RewardsRequestModel(
      amount: List<BigInt>.from(map['amount']?.map((x) => BigInt.parse(x))),
      token: List<String>.from(map['token']),
    );
  }
  RewardsRequestModel({
    required this.amount,
    required this.token,
  });
  List<BigInt> amount;
  List<String> token;

  RewardsRequestModel copyWith({
    List<BigInt>? amount,
    List<String>? token,
  }) {
    return RewardsRequestModel(
      amount: amount ?? this.amount,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount.map((x) => x.toString()).toList(),
      'token': token,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'RewardsRequestModel(amount: $amount, token: $token)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RewardsRequestModel &&
        listEquals(other.amount, amount) &&
        listEquals(other.token, token);
  }

  @override
  int get hashCode => amount.hashCode ^ token.hashCode;
}
