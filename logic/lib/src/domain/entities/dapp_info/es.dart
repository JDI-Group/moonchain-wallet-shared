import 'dart:convert';

import 'package:equatable/equatable.dart';

class Es extends Equatable {

  const Es({this.name, this.description});

  factory Es.fromMap(Map<String, dynamic> data) => Es(
        name: data['name'] as String?,
        description: data['description'] as String?,
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Es].
  factory Es.fromJson(String data) {
    return Es.fromMap(json.decode(data) as Map<String, dynamic>);
  }
  final String? name;
  final String? description;

  Map<String, dynamic> toMap() => {
        'name': name,
        'description': description,
      };

  /// `dart:convert`
  ///
  /// Converts [Es] to a JSON string.
  String toJson() => json.encode(toMap());

  Es copyWith({
    String? name,
    String? description,
  }) {
    return Es(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name, description];
}
