import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'support.dart';

class Developer extends Equatable {
  final String? name;
  final String? contact;
  final Support? support;

  const Developer({this.name, this.contact, this.support});

  factory Developer.fromMap(Map<String, dynamic> data) => Developer(
        name: data['name'] as String?,
        contact: data['contact'] as String?,
        support: data['support'] == null
            ? null
            : Support.fromMap(data['support'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'contact': contact,
        'support': support?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Developer].
  factory Developer.fromJson(String data) {
    return Developer.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Developer] to a JSON string.
  String toJson() => json.encode(toMap());

  Developer copyWith({
    String? name,
    String? contact,
    Support? support,
  }) {
    return Developer(
      name: name ?? this.name,
      contact: contact ?? this.contact,
      support: support ?? this.support,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name, contact, support];
}
