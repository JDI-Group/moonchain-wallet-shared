import 'dart:convert';

import 'package:flutter/widgets.dart';

class GetClaimTotalQuery {
  factory GetClaimTotalQuery.fromJson(String source) =>
      GetClaimTotalQuery.fromMap(json.decode(source));

  factory GetClaimTotalQuery.fromMap(Map<String, dynamic> map) {
    return GetClaimTotalQuery(
      owner: map['owner'] ?? '',
      type: map['type'],
    );
  }
  GetClaimTotalQuery({
    required this.owner,
    this.type,
  });
  final String owner;
  final String? type;

  GetClaimTotalQuery copyWith({
    String? owner,
    ValueGetter<String?>? type,
  }) {
    return GetClaimTotalQuery(
      owner: owner ?? this.owner,
      type: type != null ? type() : this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'owner': owner,
      'type': type,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'GetClaimTotalQuery(owner: $owner, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetClaimTotalQuery &&
        other.owner == owner &&
        other.type == type;
  }

  @override
  int get hashCode => owner.hashCode ^ type.hashCode;
}
