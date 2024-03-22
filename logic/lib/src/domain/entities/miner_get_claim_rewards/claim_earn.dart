import 'dart:convert';

import 'package:flutter/foundation.dart';

class ClaimEarn {
  factory ClaimEarn.fromJson(String source) =>
      ClaimEarn.fromMap(json.decode(source));

  factory ClaimEarn.fromMap(Map<String, dynamic> map) {
    return ClaimEarn(
      timestamp: map['timestamp']?.toInt() ?? 0,
      fee: map['fee'] ?? '',
      mxc: map['mxc'] ?? '',
      ids: List<String>.from(map['ids']),
    );
  }
  ClaimEarn({
    required this.timestamp,
    required this.fee,
    required this.mxc,
    required this.ids,
  });
  final int timestamp;
  final String fee;
  final String mxc;
  final List<String> ids;

  ClaimEarn copyWith({
    int? timestamp,
    String? fee,
    String? mxc,
    List<String>? ids,
  }) {
    return ClaimEarn(
      timestamp: timestamp ?? this.timestamp,
      fee: fee ?? this.fee,
      mxc: mxc ?? this.mxc,
      ids: ids ?? this.ids,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'fee': fee,
      'mxc': mxc,
      'ids': ids,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ClaimEarn(timestamp: $timestamp, fee: $fee, mxc: $mxc, ids: $ids)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClaimEarn &&
        other.timestamp == timestamp &&
        other.fee == fee &&
        other.mxc == mxc &&
        listEquals(other.ids, ids);
  }

  @override
  int get hashCode {
    return timestamp.hashCode ^ fee.hashCode ^ mxc.hashCode ^ ids.hashCode;
  }
}
