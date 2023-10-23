import 'dart:convert';

import 'package:equatable/equatable.dart';

class Support extends Equatable {
  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Support].
  factory Support.fromJson(String data) {
    return Support.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  factory Support.fromMap(Map<String, dynamic> data) => Support(
        email: data['email'] as String?,
        website: data['website'] as String?,
      );

  const Support({this.email, this.website});
  final String? email;
  final String? website;

  Map<String, dynamic> toMap() => {
        'email': email,
        'website': website,
      };

  /// `dart:convert`
  ///
  /// Converts [Support] to a JSON string.
  String toJson() => json.encode(toMap());

  Support copyWith({
    String? email,
    String? website,
  }) {
    return Support(
      email: email ?? this.email,
      website: website ?? this.website,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [email, website];
}
