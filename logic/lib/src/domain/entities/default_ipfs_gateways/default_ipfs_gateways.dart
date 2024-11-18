import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'version.dart';

class DefaultIpfsGateways extends Equatable {
  const DefaultIpfsGateways({this.name, this.gateways, this.version});

  factory DefaultIpfsGateways.fromMap(Map<String, dynamic> data) {
    return DefaultIpfsGateways(
      name: data['name'] as String?,
      gateways: (data['gateways'] as List<dynamic>?)
          ?.map((dynamic e) => e as String)
          .toList(),
      version: data['version'] == null
          ? null
          : Version.fromMap(data['version'] as Map<String, dynamic>),
    );
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DefaultIpfsGateways].
  factory DefaultIpfsGateways.fromJson(String data) {
    return DefaultIpfsGateways.fromMap(
        json.decode(data) as Map<String, dynamic>,);
  }

  final String? name;
  final List<String>? gateways;
  final Version? version;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'name': name,
        'gateways': gateways,
        'version': version?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Converts [DefaultIpfsGateways] to a JSON string.
  String toJson() => json.encode(toMap());

  DefaultIpfsGateways copyWith({
    String? name,
    List<String>? gateways,
    Version? version,
  }) {
    return DefaultIpfsGateways(
      name: name ?? this.name,
      gateways: gateways ?? this.gateways,
      version: version ?? this.version,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name, gateways, version];
}
