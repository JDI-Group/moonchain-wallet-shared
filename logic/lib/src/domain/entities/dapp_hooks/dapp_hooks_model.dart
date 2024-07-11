import 'dart:convert';

import 'package:mxc_logic/mxc_logic.dart';

import 'wifi_hooks_model.dart';

class DAppHooksModel {
  factory DAppHooksModel.fromJson(String source) =>
      DAppHooksModel.fromMap(json.decode(source));

  factory DAppHooksModel.fromMap(Map<String, dynamic> map) {
    return DAppHooksModel(
      wifiHooks: WifiHooksModel.fromMap(map['wifiHooks']),
      minerHooks: MinerHooksModel.fromMap(map['minerHooks']),
    );
  }

  DAppHooksModel({
    required this.wifiHooks,
    required this.minerHooks,
  });

  factory DAppHooksModel.getDefault() => DAppHooksModel(
        wifiHooks: WifiHooksModel(enabled: false, duration: 15),
        minerHooks: MinerHooksModel(
          enabled: false,
          time: BackgroundExecutionConfig.defaultTimeForMinerDapp,
          selectedMiners: [],
        ),
      );

  WifiHooksModel wifiHooks;
  MinerHooksModel minerHooks;

  DAppHooksModel copyWith({
    WifiHooksModel? wifiHooks,
    MinerHooksModel? minerHooks,
  }) {
    return DAppHooksModel(
      wifiHooks: wifiHooks ?? this.wifiHooks,
      minerHooks: minerHooks ?? this.minerHooks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'wifiHooks': wifiHooks.toMap(),
      'minerHooks': minerHooks.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'DAppHooksModel(wifiHooks: $wifiHooks, minerHooks: $minerHooks)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DAppHooksModel &&
        other.wifiHooks == wifiHooks &&
        other.minerHooks == minerHooks;
  }

  @override
  int get hashCode {
    return wifiHooks.hashCode ^ minerHooks.hashCode;
  }
}
