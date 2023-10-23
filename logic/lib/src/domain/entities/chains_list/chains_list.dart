import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:mxc_logic/mxc_logic.dart';

import 'version.dart';

class ChainsList extends Equatable {
  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ChainsList].
  factory ChainsList.fromJson(String data) {
    return ChainsList.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  factory ChainsList.fromMap(Map<String, dynamic> data) => ChainsList(
        name: data['name'] as String?,
        networks: (data['networks'] as List<dynamic>?)
            ?.map((e) => Network.fromMap(e as Map<String, dynamic>))
            .toList(),
        version: data['version'] == null
            ? null
            : Version.fromMap(data['version'] as Map<String, dynamic>),
      );

  const ChainsList({this.name, this.networks, this.version});
  final String? name;
  final List<Network>? networks;
  final Version? version;

  Map<String, dynamic> toMap() => {
        'name': name,
        'networks': networks?.map((e) => e.toMap()).toList(),
        'version': version?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Converts [ChainsList] to a JSON string.
  String toJson() => json.encode(toMap());

  ChainsList copyWith({
    String? name,
    List<Network>? networks,
    Version? version,
  }) {
    return ChainsList(
      name: name ?? this.name,
      networks: networks ?? this.networks,
      version: version ?? this.version,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name, networks, version];
}
