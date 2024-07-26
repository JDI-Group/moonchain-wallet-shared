import 'dart:convert';

import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/domain/entities/dapp_hooks/blueberry_ring_hooks_model.dart';

import 'wifi_hooks_model.dart';

class DAppHooksModel {
  factory DAppHooksModel.fromJson(String source) =>
      DAppHooksModel.fromMap(json.decode(source));

  factory DAppHooksModel.fromMap(Map<String, dynamic> map) {
    return DAppHooksModel(
      wifiHooks: WifiHooksModel.fromMap(map['wifiHooks']),
      minerHooks: MinerHooksModel.fromMap(map['minerHooks']),
      blueberryRingHooks:
          BlueberryRingHooksModel.fromMap(map['blueberryRingHooks']),
    );
  }

  DAppHooksModel({
    required this.wifiHooks,
    required this.minerHooks,
    required this.blueberryRingHooks,
  });

  factory DAppHooksModel.getDefault() => DAppHooksModel(
        wifiHooks: WifiHooksModel(enabled: false, duration: 15),
        minerHooks: MinerHooksModel(
          enabled: false,
          time: BackgroundExecutionConfig.defaultTimeForMinerDapp,
          selectedMiners: [],
        ),
        blueberryRingHooks: BlueberryRingHooksModel(
          enabled: false,
          time: BackgroundExecutionConfig.defaultTimeForMinerDapp,
          selectedRings: [],
        ),
      );

  WifiHooksModel wifiHooks;
  MinerHooksModel minerHooks;
  BlueberryRingHooksModel blueberryRingHooks;

  DAppHooksModel copyWith({
    WifiHooksModel? wifiHooks,
    MinerHooksModel? minerHooks,
    BlueberryRingHooksModel? blueberryRingHooks,
  }) {
    return DAppHooksModel(
      wifiHooks: wifiHooks ?? this.wifiHooks,
      minerHooks: minerHooks ?? this.minerHooks,
      blueberryRingHooks: blueberryRingHooks ?? this.blueberryRingHooks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'wifiHooks': wifiHooks.toMap(),
      'minerHooks': minerHooks.toMap(),
      'blueberryRingHooks': blueberryRingHooks.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'DAppHooksModel(wifiHooks: $wifiHooks, minerHooks: $minerHooks, blueberryRingHooks: $blueberryRingHooks)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DAppHooksModel &&
        other.wifiHooks == wifiHooks &&
        other.minerHooks == minerHooks &&
        other.blueberryRingHooks == blueberryRingHooks;
  }

  @override
  int get hashCode {
    return wifiHooks.hashCode ^
        minerHooks.hashCode ^
        blueberryRingHooks.hashCode;
  }
}
