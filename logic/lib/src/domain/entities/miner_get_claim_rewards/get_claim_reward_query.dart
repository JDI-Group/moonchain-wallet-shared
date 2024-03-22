import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../miner_list_model/mep1004_token_detail.dart';

class GetClaimRewardsQuery {
  factory GetClaimRewardsQuery.fromJson(String source) =>
      GetClaimRewardsQuery.fromMap(json.decode(source));

  factory GetClaimRewardsQuery.fromMap(Map<String, dynamic> map) {
    return GetClaimRewardsQuery(
      type: map['type'] ?? '',
      miners: map['miners'] != null
          ? List<Mep1004TokenDetail>.from(
              map['miners']?.map((x) => Mep1004TokenDetail.fromMap(x)))
          : null,
    );
  }

  GetClaimRewardsQuery({
    required this.type,
    this.miners,
  });

  final String type;
  final List<Mep1004TokenDetail>? miners;

  GetClaimRewardsQuery copyWith({
    String? type,
    ValueGetter<List<Mep1004TokenDetail>?>? miners,
  }) {
    return GetClaimRewardsQuery(
      type: type ?? this.type,
      miners: miners != null ? miners() : this.miners,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'miners': miners?.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'GetClaimRewardsQuery(type: $type, miners: $miners)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetClaimRewardsQuery &&
        other.type == type &&
        listEquals(other.miners, miners);
  }

  @override
  int get hashCode => type.hashCode ^ miners.hashCode;
}
