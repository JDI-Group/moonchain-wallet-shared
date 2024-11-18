import 'dart:convert';

import 'package:equatable/equatable.dart';

class En extends Equatable {

  const En({this.name, this.description});

  factory En.fromMap(Map<String, dynamic> data) => En(
        name: data['name'] as String?,
        description: data['description'] as String?,
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [En].
  factory En.fromJson(String data) {
    return En.fromMap(json.decode(data) as Map<String, dynamic>);
  }
  final String? name;
  final String? description;

  Map<String, dynamic> toMap() => {
        'name': name,
        'description': description,
      };

  /// `dart:convert`
  ///
  /// Converts [En] to a JSON string.
  String toJson() => json.encode(toMap());

  En copyWith({
    String? name,
    String? description,
  }) {
    return En(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name, description];
}
