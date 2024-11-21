import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'attribute.dart';

class MoonchainTokenMetaDataResponse extends Equatable {

  factory MoonchainTokenMetaDataResponse.fromMap(Map<String, dynamic> data) {
    return MoonchainTokenMetaDataResponse(
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

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MoonchainTokenMetaDataResponse].
  factory MoonchainTokenMetaDataResponse.fromJson(String data) {
    return MoonchainTokenMetaDataResponse.fromMap(
        json.decode(data) as Map<String, dynamic>,);
  }
  const MoonchainTokenMetaDataResponse({
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
  /// Converts [MoonchainTokenMetaDataResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  MoonchainTokenMetaDataResponse copyWith({
    String? image,
    String? name,
    String? externalLink,
    String? description,
    List<Attribute>? attributes,
    bool? isRealWorldNft,
  }) {
    return MoonchainTokenMetaDataResponse(
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
