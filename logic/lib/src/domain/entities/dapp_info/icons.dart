import 'dart:convert';

import 'package:equatable/equatable.dart';

class Icons extends Equatable {
  final String? iconSmall;
  final String? iconLarge;
  final String? namedhexagon;
  final String? lease;
  final bool? islarge;

  const Icons({
    this.iconSmall,
    this.iconLarge,
    this.namedhexagon,
    this.lease,
    this.islarge,
  });

  factory Icons.fromMap(Map<String, dynamic> data) => Icons(
        iconSmall: data['iconSmall'] as String?,
        iconLarge: data['iconLarge'] as String?,
        namedhexagon: data['namedhexagon'] as String?,
        lease: data['lease'] as String?,
        islarge: data['islarge'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'iconSmall': iconSmall,
        'iconLarge': iconLarge,
        'namedhexagon': namedhexagon,
        'lease': lease,
        'islarge': islarge,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Icons].
  factory Icons.fromJson(String data) {
    return Icons.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Icons] to a JSON string.
  String toJson() => json.encode(toMap());

  Icons copyWith({
    String? iconSmall,
    String? iconLarge,
    String? namedhexagon,
    String? lease,
    bool? islarge,
  }) {
    return Icons(
      iconSmall: iconSmall ?? this.iconSmall,
      iconLarge: iconLarge ?? this.iconLarge,
      namedhexagon: namedhexagon ?? this.namedhexagon,
      lease: lease ?? this.lease,
      islarge: islarge ?? this.islarge,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      iconSmall,
      iconLarge,
      namedhexagon,
      lease,
      islarge,
    ];
  }
}
