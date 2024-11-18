import 'dart:convert';

import 'package:equatable/equatable.dart';

class Total extends Equatable {

  const Total({this.decimals, this.value});

  factory Total.fromMap(Map<String, dynamic> data) => Total(
        decimals: data['decimals'] as String?,
        value: data['value'] as String?,
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Total].
  factory Total.fromJson(String data) {
    return Total.fromMap(json.decode(data) as Map<String, dynamic>);
  }
  final String? decimals;
  final String? value;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'decimals': decimals,
        'value': value,
      };

  /// `dart:convert`
  ///
  /// Converts [Total] to a JSON string.
  String toJson() => json.encode(toMap());

  Total copyWith({
    String? decimals,
    String? value,
  }) {
    return Total(
      decimals: decimals ?? this.decimals,
      value: value ?? this.value,
    );
  }

  @override
  List<Object?> get props => [decimals, value];
}
