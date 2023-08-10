import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'version.dart';

class DefaultTweets extends Equatable {
  const DefaultTweets({this.name, this.account, this.tweets, this.version});

  factory DefaultTweets.fromMap(Map<String, dynamic> data) => DefaultTweets(
        name: data['name'] as String?,
        account: data['account'] as String?,
        tweets: (data['tweets'] as List<dynamic>?)
            ?.map((dynamic e) => e as String)
            .toList(),
        version: data['version'] == null
            ? null
            : Version.fromMap(data['version'] as Map<String, dynamic>),
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DefaultTweets].
  factory DefaultTweets.fromJson(String data) {
    return DefaultTweets.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  final String? name;
  final String? account;
  final List<String>? tweets;
  final Version? version;

  Map<String, dynamic> toMap() => {
        'name': name,
        'account': account,
        'tweets': tweets,
        'version': version?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Converts [DefaultTweets] to a JSON string.
  String toJson() => json.encode(toMap());

  DefaultTweets copyWith({
    String? name,
    String? account,
    List<String>? tweets,
    Version? version,
  }) {
    return DefaultTweets(
      name: name ?? this.name,
      account: account ?? this.account,
      tweets: tweets ?? this.tweets,
      version: version ?? this.version,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name, account, tweets, version];
}
