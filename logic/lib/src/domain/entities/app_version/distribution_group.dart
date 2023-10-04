import 'dart:convert';

import 'package:equatable/equatable.dart';

class DistributionGroup extends Equatable {
  final String? id;
  final String? name;
  final String? origin;
  final String? displayName;
  final bool? isPublic;

  const DistributionGroup({
    this.id,
    this.name,
    this.origin,
    this.displayName,
    this.isPublic,
  });

  factory DistributionGroup.fromMap(Map<String, dynamic> data) {
    return DistributionGroup(
      id: data['id'] as String?,
      name: data['name'] as String?,
      origin: data['origin'] as String?,
      displayName: data['display_name'] as String?,
      isPublic: data['is_public'] as bool?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'origin': origin,
        'display_name': displayName,
        'is_public': isPublic,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DistributionGroup].
  factory DistributionGroup.fromJson(String data) {
    return DistributionGroup.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [DistributionGroup] to a JSON string.
  String toJson() => json.encode(toMap());

  DistributionGroup copyWith({
    String? id,
    String? name,
    String? origin,
    String? displayName,
    bool? isPublic,
  }) {
    return DistributionGroup(
      id: id ?? this.id,
      name: name ?? this.name,
      origin: origin ?? this.origin,
      displayName: displayName ?? this.displayName,
      isPublic: isPublic ?? this.isPublic,
    );
  }

  @override
  List<Object?> get props => [id, name, origin, displayName, isPublic];
}
