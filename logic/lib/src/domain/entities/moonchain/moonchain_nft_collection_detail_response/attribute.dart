import 'dart:convert';

import 'package:equatable/equatable.dart';

class Attribute extends Equatable {

  factory Attribute.fromMap(Map<String, dynamic> data) => Attribute(
        traitType: data['trait_type'] as String?,
        value: data['value'] as String?,
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Attribute].
  factory Attribute.fromJson(String data) {
    return Attribute.fromMap(json.decode(data) as Map<String, dynamic>);
  }
  const Attribute({this.traitType, this.value});

  final String? traitType;
  final String? value;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'trait_type': traitType,
        'value': value,
      };

  /// `dart:convert`
  ///
  /// Converts [Attribute] to a JSON string.
  String toJson() => json.encode(toMap());

  Attribute copyWith({
    String? traitType,
    String? value,
  }) {
    return Attribute(
      traitType: traitType ?? this.traitType,
      value: value ?? this.value,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [traitType, value];
}
