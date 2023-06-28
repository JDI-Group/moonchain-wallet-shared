import 'dart:convert';

import 'package:equatable/equatable.dart';

class From extends Equatable {
  final String? hash;
  final dynamic implementationName;
  final bool? isContract;
  final dynamic isVerified;
  final dynamic name;
  final List<dynamic>? privateTags;
  final List<dynamic>? publicTags;
  final List<dynamic>? watchlistNames;

  const From({
    this.hash,
    this.implementationName,
    this.isContract,
    this.isVerified,
    this.name,
    this.privateTags,
    this.publicTags,
    this.watchlistNames,
  });

  factory From.fromMap(Map<String, dynamic> data) => From(
        hash: data['hash'] as String?,
        implementationName: data['implementation_name'] as dynamic,
        isContract: data['is_contract'] as bool?,
        isVerified: data['is_verified'] as dynamic,
        name: data['name'] as dynamic,
        privateTags: data['private_tags'] as List<dynamic>?,
        publicTags: data['public_tags'] as List<dynamic>?,
        watchlistNames: data['watchlist_names'] as List<dynamic>?,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'hash': hash,
        'implementation_name': implementationName,
        'is_contract': isContract,
        'is_verified': isVerified,
        'name': name,
        'private_tags': privateTags,
        'public_tags': publicTags,
        'watchlist_names': watchlistNames,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [From].
  factory From.fromJson(String data) {
    return From.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [From] to a JSON string.
  String toJson() => json.encode(toMap());

  From copyWith({
    String? hash,
    dynamic implementationName,
    bool? isContract,
    dynamic isVerified,
    dynamic name,
    List<dynamic>? privateTags,
    List<dynamic>? publicTags,
    List<dynamic>? watchlistNames,
  }) {
    return From(
      hash: hash ?? this.hash,
      implementationName: implementationName ?? this.implementationName,
      isContract: isContract ?? this.isContract,
      isVerified: isVerified ?? this.isVerified,
      name: name ?? this.name,
      privateTags: privateTags ?? this.privateTags,
      publicTags: publicTags ?? this.publicTags,
      watchlistNames: watchlistNames ?? this.watchlistNames,
    );
  }

  @override
  List<Object?> get props {
    return [
      hash,
      implementationName,
      isContract,
      isVerified,
      name,
      privateTags,
      publicTags,
      watchlistNames,
    ];
  }
}
