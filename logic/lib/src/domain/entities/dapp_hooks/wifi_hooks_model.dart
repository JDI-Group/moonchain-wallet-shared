import 'dart:convert';

class WifiHooksModel {
  factory WifiHooksModel.fromJson(String source) =>
      WifiHooksModel.fromMap(json.decode(source));

  factory WifiHooksModel.fromMap(Map<String, dynamic> map) {
    return WifiHooksModel(
      duration: map['duration'] as int? ?? 15,
      enabled: map['enabled'] ?? false,
    );
  }
  WifiHooksModel({
    required this.enabled,
    required this.duration,
  });

  bool enabled;
  // Periodical delay duration in minutes
  int duration;

  WifiHooksModel copyWith({
    bool? enabled,
    int? duration,
  }) {
    return WifiHooksModel(
      enabled: enabled ?? this.enabled,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'enabled': enabled,
      'duration': duration,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'WifiHooksModel(enabled: $enabled, duration: $duration)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WifiHooksModel &&
        other.enabled == enabled &&
        other.duration == duration;
  }

  @override
  int get hashCode => enabled.hashCode ^ duration.hashCode;
}
