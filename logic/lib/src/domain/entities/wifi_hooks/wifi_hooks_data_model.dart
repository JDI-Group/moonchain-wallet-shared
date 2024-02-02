import 'dart:convert';

import 'package:collection/collection.dart';

import 'wifi_model.dart';

class WifiHooksDataModel {
  factory WifiHooksDataModel.fromJson(String source) =>
      WifiHooksDataModel.fromMap(json.decode(source));

  factory WifiHooksDataModel.fromMap(Map<String, dynamic> map) {
    return WifiHooksDataModel(
      version: map['version'] ?? '',
      hexagonId: map['hexagonId'] ?? '',
      wifiList: List<WifiModel>.from(
        map['BSSIDList']?.map((x) => WifiModel.fromMap(x)),
      ),
      os: map['OS'] ?? '',
    );
  }

  WifiHooksDataModel(
      {required this.version,
      required this.hexagonId,
      required this.wifiList,
      required this.os});
  String version;
  String hexagonId;
  String os;
  List<WifiModel> wifiList;

  WifiHooksDataModel copyWith({
    String? version,
    String? os,
    String? hexagonId,
    List<WifiModel>? wifiList,
  }) {
    return WifiHooksDataModel(
      version: version ?? this.version,
      hexagonId: hexagonId ?? this.hexagonId,
      wifiList: wifiList ?? this.wifiList,
      os: os ?? this.os,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'version': version,
      'hexagonId': hexagonId,
      'BSSIDList': wifiList.map((x) => x.toMap()).toList(),
      'OS': os,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'WifiHooksDataModel(version: $version, hexagonId: $hexagonId, wifiList: $wifiList, OS: $os)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is WifiHooksDataModel &&
        other.version == version &&
        other.hexagonId == hexagonId &&
        listEquals(other.wifiList, wifiList) &&
        other.os == os;
  }

  @override
  int get hashCode =>
      version.hashCode ^ hexagonId.hashCode ^ wifiList.hashCode ^ os.hashCode;
}
