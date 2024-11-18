import 'dart:convert';

import 'package:equatable/equatable.dart';

class Owner extends Equatable {

  const Owner({this.name, this.displayName});

  factory Owner.fromMap(Map<String, dynamic> data) => Owner(
        name: data['name'] as String?,
        displayName: data['display_name'] as String?,
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Owner].
  factory Owner.fromJson(String data) {
    return Owner.fromMap(json.decode(data) as Map<String, dynamic>);
  }
  final String? name;
  final String? displayName;

  Map<String, dynamic> toMap() => {
        'name': name,
        'display_name': displayName,
      };

  /// `dart:convert`
  ///
  /// Converts [Owner] to a JSON string.
  String toJson() => json.encode(toMap());

  Owner copyWith({
    String? name,
    String? displayName,
  }) {
    return Owner(
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
    );
  }

  @override
  List<Object?> get props => [name, displayName];
}
