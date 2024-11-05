import 'dart:convert';

import 'package:equatable/equatable.dart';

class Fee extends Equatable {
  final String? type;
  final String? value;

  const Fee({this.type, this.value});

  factory Fee.fromMap(Map<String, dynamic> data) => Fee(
        type: data['type'] as String?,
        value: data['value'] as String?,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'type': type,
        'value': value,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Fee].
  factory Fee.fromJson(String data) {
    return Fee.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Fee] to a JSON string.
  String toJson() => json.encode(toMap());

  Fee copyWith({
    String? type,
    String? value,
  }) {
    return Fee(
      type: type ?? this.type,
      value: value ?? this.value,
    );
  }

  @override
  List<Object?> get props => [type, value];
}
