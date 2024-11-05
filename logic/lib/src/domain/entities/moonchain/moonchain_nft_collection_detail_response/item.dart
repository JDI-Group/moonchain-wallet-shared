import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'metadata.dart';
import 'owner.dart';
import 'token.dart';

class Item extends Equatable {
  const Item({
    this.animationUrl,
    this.externalAppUrl,
    this.id,
    this.imageUrl,
    this.isUnique,
    this.metadata,
    this.owner,
    this.token,
  });

  final dynamic animationUrl;
  final dynamic externalAppUrl;
  final String? id;
  final String? imageUrl;
  final bool? isUnique;
  final Metadata? metadata;
  final Owner? owner;
  final Token? token;

  factory Item.fromMap(Map<String, dynamic> data) => Item(
        animationUrl: data['animation_url'] as dynamic,
        externalAppUrl: data['external_app_url'] as dynamic,
        id: data['id'] as String?,
        imageUrl: data['image_url'] as String?,
        isUnique: data['is_unique'] as bool?,
        metadata: data['metadata'] == null
            ? null
            : Metadata.fromMap(data['metadata'] as Map<String, dynamic>),
        owner: data['owner'] == null
            ? null
            : Owner.fromMap(data['owner'] as Map<String, dynamic>),
        token: data['token'] == null
            ? null
            : Token.fromMap(data['token'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'animation_url': animationUrl,
        'external_app_url': externalAppUrl,
        'id': id,
        'image_url': imageUrl,
        'is_unique': isUnique,
        'metadata': metadata?.toMap(),
        'owner': owner?.toMap(),
        'token': token?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Item].
  factory Item.fromJson(String data) {
    return Item.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Item] to a JSON string.
  String toJson() => json.encode(toMap());

  Item copyWith({
    dynamic animationUrl,
    dynamic externalAppUrl,
    String? id,
    String? imageUrl,
    bool? isUnique,
    Metadata? metadata,
    Owner? owner,
    Token? token,
  }) {
    return Item(
      animationUrl: animationUrl ?? this.animationUrl,
      externalAppUrl: externalAppUrl ?? this.externalAppUrl,
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      isUnique: isUnique ?? this.isUnique,
      metadata: metadata ?? this.metadata,
      owner: owner ?? this.owner,
      token: token ?? this.token,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      animationUrl,
      externalAppUrl,
      id,
      imageUrl,
      isUnique,
      metadata,
      owner,
      token,
    ];
  }
}
