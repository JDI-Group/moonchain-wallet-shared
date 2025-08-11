import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'body.dart';
import 'headers.dart';

class ReviewApi extends Equatable {
  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ReviewApi].
  factory ReviewApi.fromJson(String data) {
    return ReviewApi.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  factory ReviewApi.fromMap(Map<String, dynamic> data) => ReviewApi(
        url: data['url'] as String?,
        method: data['method'] as String?,
        headers: data['headers'] == null
            ? null
            : Headers.fromMap(data['headers'] as Map<String, dynamic>),
        body: data['body'] == null
            ? null
            : Body.fromMap(data['body'] as Map<String, dynamic>),
        icon: data['icon'],
        iconV2: data['iconV2'],
        iconV3: data['iconV3'],
      );

  const ReviewApi({
    this.url,
    this.method,
    this.headers,
    this.body,
    this.icon,
    this.iconV2,
    this.iconV3,
  });
  final String? url;
  final String? method;
  final Headers? headers;
  final Body? body;
  final String? icon;
  final String? iconV2;
  final String? iconV3;

  Map<String, dynamic> toMap() => {
        'url': url,
        'method': method,
        'headers': headers?.toMap(),
        'body': body?.toMap(),
        'icon': icon,
        'iconV2': iconV2,
        'iconV3': iconV3,
      };

  /// `dart:convert`
  ///
  /// Converts [ReviewApi] to a JSON string.
  String toJson() => json.encode(toMap());

  ReviewApi copyWith({
    String? url,
    String? method,
    Headers? headers,
    Body? body,
    String? icon,
    String? iconV2,
    String? iconV3,
  }) {
    return ReviewApi(
      url: url ?? this.url,
      method: method ?? this.method,
      headers: headers ?? this.headers,
      body: body ?? this.body,
      icon: icon ?? this.icon,
      iconV2: iconV2 ?? this.iconV2,
      iconV3: iconV3 ?? this.iconV3,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        url,
        method,
        headers,
        body,
        icon,
        iconV2,
        iconV3,
      ];
}
