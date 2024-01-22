import 'dart:convert';

class WifiHooksModel {
  factory WifiHooksModel.fromJson(String source) =>
      WifiHooksModel.fromMap(json.decode(source));

  factory WifiHooksModel.fromMap(Map<String, dynamic> map) {
    return WifiHooksModel(
      enabled: map['enabled'] ?? false,
    );
  }
  WifiHooksModel({
    required this.enabled,
  });
  bool enabled;

  WifiHooksModel copyWith({
    bool? enabled,
  }) {
    return WifiHooksModel(
      enabled: enabled ?? this.enabled,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'enabled': enabled,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'WifiHooksModel(enabled: $enabled)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WifiHooksModel && other.enabled == enabled;
  }

  @override
  int get hashCode => enabled.hashCode;
}
