import 'dart:convert';

class ClaimReward {
  factory ClaimReward.fromJson(String source) =>
      ClaimReward.fromMap(json.decode(source));

  factory ClaimReward.fromMap(Map<String, dynamic> map) {
    return ClaimReward(
      blockTimestamp: map['blockTimestamp'] ?? '',
      feeMXC: map['feeMXC'] ?? '',
      mep1004TokenId: map['mep1004TokenId'] ?? '',
      valueMXC: map['valueMXC'] ?? '',
    );
  }
  ClaimReward({
    required this.blockTimestamp,
    required this.feeMXC,
    required this.mep1004TokenId,
    required this.valueMXC,
  });
  final String blockTimestamp;
  final String feeMXC;
  final String mep1004TokenId;
  final String valueMXC;

  ClaimReward copyWith({
    String? blockTimestamp,
    String? feeMXC,
    String? mep1004TokenId,
    String? valueMXC,
  }) {
    return ClaimReward(
      blockTimestamp: blockTimestamp ?? this.blockTimestamp,
      feeMXC: feeMXC ?? this.feeMXC,
      mep1004TokenId: mep1004TokenId ?? this.mep1004TokenId,
      valueMXC: valueMXC ?? this.valueMXC,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'blockTimestamp': blockTimestamp,
      'feeMXC': feeMXC,
      'mep1004TokenId': mep1004TokenId,
      'valueMXC': valueMXC,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ClaimReward(blockTimestamp: $blockTimestamp, feeMXC: $feeMXC, mep1004TokenId: $mep1004TokenId, valueMXC: $valueMXC)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClaimReward &&
        other.blockTimestamp == blockTimestamp &&
        other.feeMXC == feeMXC &&
        other.mep1004TokenId == mep1004TokenId &&
        other.valueMXC == valueMXC;
  }

  @override
  int get hashCode {
    return blockTimestamp.hashCode ^
        feeMXC.hashCode ^
        mep1004TokenId.hashCode ^
        valueMXC.hashCode;
  }
}
