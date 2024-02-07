import 'dart:convert';

import 'package:flutter/foundation.dart';

class RewardQueryModel {
  factory RewardQueryModel.fromJson(String source) =>
      RewardQueryModel.fromMap(json.decode(source));

  factory RewardQueryModel.fromMap(Map<String, dynamic> map) {
    return RewardQueryModel(
      mep1004TokenId: map['mep1004TokenId'] as int? ?? 0,
      epochNumbers: List<int>.from(map['epochNumbers']),
    );
  }
  RewardQueryModel({
    required this.mep1004TokenId,
    required this.epochNumbers,
  });
  int mep1004TokenId;
  List<int> epochNumbers;

  RewardQueryModel copyWith({
    int? mep1004TokenId,
    List<int>? epochNumbers,
  }) {
    return RewardQueryModel(
      mep1004TokenId: mep1004TokenId ?? this.mep1004TokenId,
      epochNumbers: epochNumbers ?? this.epochNumbers,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mep1004TokenId': mep1004TokenId,
      'epochNumbers': epochNumbers,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'RewardQueryModel(mep1004TokenId: $mep1004TokenId, epochNumbers: $epochNumbers)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RewardQueryModel &&
        other.mep1004TokenId == mep1004TokenId &&
        listEquals(other.epochNumbers, epochNumbers);
  }

  @override
  int get hashCode => mep1004TokenId.hashCode ^ epochNumbers.hashCode;
}
