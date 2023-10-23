import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'chain_list.dart';
import 'version.dart';

export 'chain_list.dart';

class ChainsRpcList extends Equatable {
  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ChainsRpcList].
  factory ChainsRpcList.fromJson(String data) {
    return ChainsRpcList.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  factory ChainsRpcList.fromMap(Map<String, dynamic> data) => ChainsRpcList(
        name: data['name'] as String?,
        chainList: (data['chain_list'] as List<dynamic>?)
            ?.map((e) => ChainRpcUrl.fromMap(e as Map<String, dynamic>))
            .toList(),
        version: data['version'] == null
            ? null
            : Version.fromMap(data['version'] as Map<String, dynamic>),
      );

  const ChainsRpcList({this.name, this.chainList, this.version});
  final String? name;
  final List<ChainRpcUrl>? chainList;
  final Version? version;

  Map<String, dynamic> toMap() => {
        'name': name,
        'chain_list': chainList?.map((e) => e.toMap()).toList(),
        'version': version?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Converts [ChainsRpcList] to a JSON string.
  String toJson() => json.encode(toMap());

  ChainsRpcList copyWith({
    String? name,
    List<ChainRpcUrl>? chainList,
    Version? version,
  }) {
    return ChainsRpcList(
      name: name ?? this.name,
      chainList: chainList ?? this.chainList,
      version: version ?? this.version,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name, chainList, version];
}
