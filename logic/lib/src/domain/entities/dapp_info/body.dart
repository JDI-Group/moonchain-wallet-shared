import 'dart:convert';

import 'package:equatable/equatable.dart';

class Body extends Equatable {

  const Body({this.mnsId});

  factory Body.fromMap(Map<String, dynamic> data) => Body(
        mnsId: data['mnsId'] as String?,
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Body].
  factory Body.fromJson(String data) {
    return Body.fromMap(json.decode(data) as Map<String, dynamic>);
  }
  final String? mnsId;

  Map<String, dynamic> toMap() => {
        'mnsId': mnsId,
      };

  /// `dart:convert`
  ///
  /// Converts [Body] to a JSON string.
  String toJson() => json.encode(toMap());

  Body copyWith({
    String? mnsId,
  }) {
    return Body(
      mnsId: mnsId ?? this.mnsId,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [mnsId];
}
