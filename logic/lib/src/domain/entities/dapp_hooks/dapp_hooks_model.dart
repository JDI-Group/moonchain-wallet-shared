import 'dart:convert';

import 'wifi_hooks_model.dart';

class DAppHooksModel {
  factory DAppHooksModel.fromJson(String source) =>
      DAppHooksModel.fromMap(json.decode(source));

  factory DAppHooksModel.fromMap(Map<String, dynamic> map) {
    return DAppHooksModel(
      enabled: map['enabled'] ?? false,
      duration: map['duration']?.toInt() ?? 0,
      wifiHooks: WifiHooksModel.fromMap(map['wifiHooks']),
    );
  }

  factory DAppHooksModel.getDefault() => DAppHooksModel(
      enabled: false, duration: 15, wifiHooks: WifiHooksModel(enabled: false));

  DAppHooksModel({
    required this.enabled,
    required this.duration,
    required this.wifiHooks,
  });

  bool enabled;
  // Periodical delay duration in minutes
  int duration;
  WifiHooksModel wifiHooks;

  DAppHooksModel copyWith({
    bool? enabled,
    int? duration,
    WifiHooksModel? wifiHooks,
  }) {
    return DAppHooksModel(
      enabled: enabled ?? this.enabled,
      duration: duration ?? this.duration,
      wifiHooks: wifiHooks ?? this.wifiHooks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'enabled': enabled,
      'duration': duration,
      'wifiHooks': wifiHooks.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'DAppHooksModel(enabled: $enabled, duration: $duration, wifiHooks: $wifiHooks)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DAppHooksModel &&
        other.enabled == enabled &&
        other.duration == duration &&
        other.wifiHooks == wifiHooks;
  }

  @override
  int get hashCode => enabled.hashCode ^ duration.hashCode ^ wifiHooks.hashCode;
}
