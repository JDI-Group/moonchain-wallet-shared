import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'attribute.dart';

class Metadata extends Equatable {
  const Metadata({
    this.attributes,
    this.description,
    this.externalLink,
    this.image,
    this.isRealWorldNft,
    this.name,
  });

  final List<Attribute>? attributes;
  final String? description;
  final String? externalLink;
  final String? image;
  final bool? isRealWorldNft;
  final String? name;

  factory Metadata.fromMap(Map<String, dynamic> data) {
    final finalData = Metadata(
      attributes: (data['attributes'] as List<dynamic>?)
    ?.whereType<Map<String, dynamic>>() // Filter to only Map<String, dynamic>
    .map((e) => Attribute.fromMap(e))
    .toList(),
      description: data['description'] as String?,
      externalLink: data['external_link'] as String?,
      image: data['image'] as String?,
      isRealWorldNft: data['isRealWorldNFT'] as bool?,
      name: data['name'] as String?,
    );
    return finalData;
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'attributes': attributes?.map((e) => e.toMap()).toList(),
        'description': description,
        'external_link': externalLink,
        'image': image,
        'isRealWorldNFT': isRealWorldNft,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Metadata].
  factory Metadata.fromJson(String data) {
    return Metadata.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Metadata] to a JSON string.
  String toJson() => json.encode(toMap());

  Metadata copyWith({
    List<Attribute>? attributes,
    String? description,
    String? externalLink,
    String? image,
    bool? isRealWorldNft,
    String? name,
  }) {
    return Metadata(
      attributes: attributes ?? this.attributes,
      description: description ?? this.description,
      externalLink: externalLink ?? this.externalLink,
      image: image ?? this.image,
      isRealWorldNft: isRealWorldNft ?? this.isRealWorldNft,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      attributes,
      description,
      externalLink,
      image,
      isRealWorldNft,
      name,
    ];
  }
}
