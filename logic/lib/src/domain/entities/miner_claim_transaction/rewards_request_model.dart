import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mxc_logic/mxc_logic.dart';

class RewardsRequestModel {
  factory RewardsRequestModel.fromJson(String source) =>
      RewardsRequestModel.fromMap(json.decode(source));

  factory RewardsRequestModel.fromMap(Map<String, dynamic> map) {
    return RewardsRequestModel(
      amount: List<BigInt>.from(map['amount']?.map((x) => BigInt.parse(x))),
      token: List<EthereumAddress>.from(map['token']),
    );
  }
  RewardsRequestModel({
    required this.amount,
    required this.token,
  });
  List<BigInt> amount;
  List<EthereumAddress> token;

  RewardsRequestModel copyWith({
    List<BigInt>? amount,
    List<EthereumAddress>? token,
  }) {
    return RewardsRequestModel(
      amount: amount ?? this.amount,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token.map((e) => e.toString() as dynamic).toList().toString(),
      'amount': amount.map((e) => e.toString() as dynamic).toList().toString(),
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
