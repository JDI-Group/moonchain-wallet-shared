import 'dart:convert';

import 'package:equatable/equatable.dart';

class To extends Equatable {
  final String? hash;
  final dynamic implementationName;
  final bool? isContract;
  final bool? isVerified;
  final dynamic name;
  final List<dynamic>? privateTags;
  final List<dynamic>? publicTags;
  final List<dynamic>? watchlistNames;

  const To({
    this.hash,
    this.implementationName,
    this.isContract,
    this.isVerified,
    this.name,
    this.privateTags,
    this.publicTags,
    this.watchlistNames,
  });

  factory To.fromMap(Map<String, dynamic> data) => To(
        hash: data['hash'] as String?,
        implementationName: data['implementation_name'] as dynamic,
        isContract: data['is_contract'] as bool?,
        isVerified: data['is_verified'] as bool?,
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
  /// Parses the string and returns the resulting Json object as [To].
  factory To.fromJson(String data) {
    return To.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [To] to a JSON string.
  String toJson() => json.encode(toMap());

  To copyWith({
    String? hash,
    dynamic implementationName,
    bool? isContract,
    bool? isVerified,
    dynamic name,
    List<dynamic>? privateTags,
    List<dynamic>? publicTags,
    List<dynamic>? watchlistNames,
  }) {
    return To(
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
