import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'body.dart';
import 'headers.dart';
import 'icons.dart';

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
        icons: data['icons'] == null
            ? null
            : Icons.fromMap(data['icons'] as Map<String, dynamic>),
        icon: data['icon'],
      );

  const ReviewApi(
      {this.url,
      this.method,
      this.headers,
      this.body,
      this.icons,
      this.icon});
  final String? url;
  final String? method;
  final Headers? headers;
  final Body? body;
  final Icons? icons;
  final String? icon;

  Map<String, dynamic> toMap() => {
        'url': url,
        'method': method,
        'headers': headers?.toMap(),
        'body': body?.toMap(),
        'icons': icons?.toMap(),
        'icon': icon
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
    Icons? icons,
    String? icon,
  }) {
    return ReviewApi(
      url: url ?? this.url,
      method: method ?? this.method,
      headers: headers ?? this.headers,
      body: body ?? this.body,
      icons: icons ?? this.icons,
      icon: icon ?? this.icon
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [url, method, headers, body, icons, icon];
}
