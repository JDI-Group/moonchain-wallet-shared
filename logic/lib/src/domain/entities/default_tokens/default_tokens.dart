import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mxc_logic/mxc_logic.dart';

import 'token.dart';
import 'version.dart';

class DefaultTokens extends Equatable {
  final String? name;
  final String? logoUri;
  final List<String>? keywords;
  final DateTime? timestamp;
  final List<Token>? tokens;
  final Version? version;

  const DefaultTokens({
    this.name,
    this.logoUri,
    this.keywords,
    this.timestamp,
    this.tokens,
    this.version,
  });

  factory DefaultTokens.fromMap(Map<String, dynamic> data) => DefaultTokens(
        name: data['name'] as String?,
        logoUri: data['logoURI'] as String?,
        keywords: (data['keywords'] as List<dynamic>?)?.cast<String>(),
        timestamp: data['timestamp'] == null
            ? null
            : DateTime.parse(data['timestamp'] as String),
        tokens: (data['tokens'] as List<dynamic>?)
            ?.map((dynamic e) => Token.fromMap(e as Map<String, dynamic>))
            .toList(),
        version: data['version'] == null
            ? null
            : Version.fromMap(data['version'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'name': name,
        'logoURI': logoUri,
        'keywords': keywords,
        'timestamp': timestamp?.toIso8601String(),
        'tokens': tokens?.map((e) => e.toMap()).toList(),
        'version': version?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DefaultTokens].
  factory DefaultTokens.fromJson(String data) {
    return DefaultTokens.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [DefaultTokens] to a JSON string.
  String toJson() => json.encode(toMap());

  DefaultTokens copyWith({
    String? name,
    String? logoUri,
    List<String>? keywords,
    DateTime? timestamp,
    List<Token>? tokens,
    Version? version,
  }) {
    return DefaultTokens(
      name: name ?? this.name,
      logoUri: logoUri ?? this.logoUri,
      keywords: keywords ?? this.keywords,
      timestamp: timestamp ?? this.timestamp,
      tokens: tokens ?? this.tokens,
      version: version ?? this.version,
    );
  }

  DefaultTokens changeAssetsRemoteToLocal() {
    return copyWith(
      logoUri: MXCAssetsHelpers.changeTokensRemoteUrlToLocal(logoUri!),
      tokens: tokens!
          .map(
            (e) => e.copyWith(
              logoUri:
                  MXCAssetsHelpers.changeTokensRemoteUrlToLocal(e.logoUri!),
            ),
          )
          .toList(),
    );
  }

  @override
  List<Object?> get props {
    return [
      name,
      logoUri,
      keywords,
      timestamp,
      tokens,
      version,
    ];
  }
}
