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
          map['wifiList']?.map((x) => WifiModel.fromMap(x))),
    );
  }
  WifiHooksDataModel({
    required this.version,
    required this.hexagonId,
    required this.wifiList,
  });
  String version;
  String hexagonId;
  List<WifiModel> wifiList;

  WifiHooksDataModel copyWith({
    String? version,
    String? hexagonId,
    List<WifiModel>? wifiList,
  }) {
    return WifiHooksDataModel(
      version: version ?? this.version,
      hexagonId: hexagonId ?? this.hexagonId,
      wifiList: wifiList ?? this.wifiList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'version': version,
      'hexagonId': hexagonId,
      'wifiList': wifiList.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'WifiHooksDataModel(version: $version, hexagonId: $hexagonId, wifiList: $wifiList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is WifiHooksDataModel &&
        other.version == version &&
        other.hexagonId == hexagonId &&
        listEquals(other.wifiList, wifiList);
  }

  @override
  int get hashCode => version.hashCode ^ hexagonId.hashCode ^ wifiList.hashCode;
}
