import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'attribute.dart';

class WannseeTokenMetaData extends Equatable {
  const WannseeTokenMetaData({
    this.image,
    this.name,
    this.externalLink,
    this.description,
    this.attributes,
    this.isRealWorldNft,
  });

  final String? image;
  final String? name;
  final String? externalLink;
  final String? description;
  final List<Attribute>? attributes;
  final bool? isRealWorldNft;

  factory WannseeTokenMetaData.fromMap(Map<String, dynamic> data) {
    return WannseeTokenMetaData(
      image: data['image'] as String?,
      name: data['name'] as String?,
      externalLink: data['external_link'] as String?,
      description: data['description'] as String?,
      attributes: (data['attributes'] as List<dynamic>?)
          ?.map((dynamic e) => Attribute.fromMap(e as Map<String, dynamic>))
          .toList(),
      isRealWorldNft: data['isRealWorldNFT'] as bool?,
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'image': image,
        'name': name,
        'external_link': externalLink,
        'description': description,
        'attributes': attributes?.map((e) => e.toMap()).toList(),
        'isRealWorldNFT': isRealWorldNft,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [WannseeTokenMetaData].
  factory WannseeTokenMetaData.fromJson(String data) {
    return WannseeTokenMetaData.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [WannseeTokenMetaData] to a JSON string.
  String toJson() => json.encode(toMap());

  WannseeTokenMetaData copyWith({
    String? image,
    String? name,
    String? externalLink,
    String? description,
    List<Attribute>? attributes,
    bool? isRealWorldNft,
  }) {
    return WannseeTokenMetaData(
      image: image ?? this.image,
      name: name ?? this.name,
      externalLink: externalLink ?? this.externalLink,
      description: description ?? this.description,
      attributes: attributes ?? this.attributes,
      isRealWorldNft: isRealWorldNft ?? this.isRealWorldNft,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      image,
      name,
      externalLink,
      description,
      attributes,
      isRealWorldNft,
    ];
  }
}
