import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProofsRequestModel {
  factory ProofsRequestModel.fromJson(String source) =>
      ProofsRequestModel.fromMap(json.decode(source));

  factory ProofsRequestModel.fromMap(Map<String, dynamic> map) {
    return ProofsRequestModel(
      proofs: List<String>.from(map['proofs']),
    );
  }
  ProofsRequestModel({
    required this.proofs,
  });
  List<String> proofs;

  ProofsRequestModel copyWith({
    List<String>? proofs,
  }) {
    return ProofsRequestModel(
      proofs: proofs ?? this.proofs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'proofs': proofs,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'ProofsRequestModel(proofs: $proofs)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProofsRequestModel && listEquals(other.proofs, proofs);
  }

  @override
  int get hashCode => proofs.hashCode;
}
