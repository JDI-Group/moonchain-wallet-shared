import 'dart:convert';

import 'package:mxc_logic/mxc_logic.dart';

import 'wifi_hooks_model.dart';

class DAppHooksModel {
  factory DAppHooksModel.fromJson(String source) =>
      DAppHooksModel.fromMap(json.decode(source));

  factory DAppHooksModel.fromMap(Map<String, dynamic> map) {
    return DAppHooksModel(
      enabled: map['enabled'] ?? false,
      duration: map['duration'] as int? ?? 0,
      wifiHooks: WifiHooksModel.fromMap(map['wifiHooks']),
      minerHooks: MinerHooksModel.fromMap(map['minerHooks']),
    );
  }

  DAppHooksModel({
    required this.enabled,
    required this.duration,
    required this.wifiHooks,
    required this.minerHooks,
  });

  factory DAppHooksModel.getDefault() => DAppHooksModel(
        enabled: false,
        duration: 15,
        wifiHooks: WifiHooksModel(enabled: false),
        minerHooks: MinerHooksModel(
          enabled: false,
          time: Config.defaultTimeForMinerDapp,
          selectedMiners: [],
        ),
      );

  bool enabled;
  // Periodical delay duration in minutes
  int duration;
  WifiHooksModel wifiHooks;
  MinerHooksModel minerHooks;

  DAppHooksModel copyWith({
    bool? enabled,
    int? duration,
    WifiHooksModel? wifiHooks,
    MinerHooksModel? minerHooks,
  }) {
    return DAppHooksModel(
      enabled: enabled ?? this.enabled,
      duration: duration ?? this.duration,
      wifiHooks: wifiHooks ?? this.wifiHooks,
      minerHooks: minerHooks ?? this.minerHooks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'enabled': enabled,
      'duration': duration,
      'wifiHooks': wifiHooks.toMap(),
      'minerHooks': minerHooks.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'DAppHooksModel(enabled: $enabled, duration: $duration, wifiHooks: $wifiHooks, minerHooks: $minerHooks)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DAppHooksModel &&
        other.enabled == enabled &&
        other.duration == duration &&
        other.wifiHooks == wifiHooks &&
        other.minerHooks == minerHooks;
  }

  @override
  int get hashCode {
    return enabled.hashCode ^
        duration.hashCode ^
        wifiHooks.hashCode ^
        minerHooks.hashCode;
  }
}
