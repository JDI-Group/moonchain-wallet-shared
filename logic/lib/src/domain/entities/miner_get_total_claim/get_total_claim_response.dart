import 'dart:convert';

class GetTotalClaimResponse {
  factory GetTotalClaimResponse.fromJson(String source) =>
      GetTotalClaimResponse.fromMap(json.decode(source));

  factory GetTotalClaimResponse.fromMap(Map<String, dynamic> map) {
    return GetTotalClaimResponse(
      totalMXC: map['totalMXC'] ?? '',
      totalFee: map['totalFee'] ?? '',
    );
  }
  GetTotalClaimResponse({
    required this.totalMXC,
    required this.totalFee,
  });
  String totalMXC;
  String totalFee;

  GetTotalClaimResponse copyWith({
    String? totalMXC,
    String? totalFee,
  }) {
    return GetTotalClaimResponse(
      totalMXC: totalMXC ?? this.totalMXC,
      totalFee: totalFee ?? this.totalFee,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalMXC': totalMXC,
      'totalFee': totalFee,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'GetTotalClaimResponse(totalMXC: $totalMXC, totalFee: $totalFee)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetTotalClaimResponse &&
        other.totalMXC == totalMXC &&
        other.totalFee == totalFee;
  }

  @override
  int get hashCode => totalMXC.hashCode ^ totalFee.hashCode;
}
