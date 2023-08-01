import 'dart:convert';

import 'package:equatable/equatable.dart';

class Version extends Equatable {
  const Version({this.major, this.minor, this.patch});

  factory Version.fromMap(Map<String, dynamic> data) => Version(
        major: data['major'] as int?,
        minor: data['minor'] as int?,
        patch: data['patch'] as int?,
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Version].
  factory Version.fromJson(String data) {
    return Version.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  final int? major;
  final int? minor;
  final int? patch;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'major': major,
        'minor': minor,
        'patch': patch,
      };

  /// `dart:convert`
  ///
  /// Converts [Version] to a JSON string.
  String toJson() => json.encode(toMap());

  Version copyWith({
    int? major,
    int? minor,
    int? patch,
  }) {
    return Version(
      major: major ?? this.major,
      minor: minor ?? this.minor,
      patch: patch ?? this.patch,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [major, minor, patch];
}
