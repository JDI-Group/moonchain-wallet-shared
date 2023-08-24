import 'dart:convert';

import 'package:equatable/equatable.dart';

class Headers extends Equatable {
	final String? authorization;
	final String? contentType;

	const Headers({this.authorization, this.contentType});

	factory Headers.fromMap(Map<String, dynamic> data) => Headers(
				authorization: data['Authorization'] as String?,
				contentType: data['Content-Type'] as String?,
			);

	Map<String, dynamic> toMap() => {
				'Authorization': authorization,
				'Content-Type': contentType,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Headers].
	factory Headers.fromJson(String data) {
		return Headers.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Headers] to a JSON string.
	String toJson() => json.encode(toMap());

	Headers copyWith({
		String? authorization,
		String? contentType,
	}) {
		return Headers(
			authorization: authorization ?? this.authorization,
			contentType: contentType ?? this.contentType,
		);
	}

	@override
	bool get stringify => true;

	@override
	List<Object?> get props => [authorization, contentType];
}
