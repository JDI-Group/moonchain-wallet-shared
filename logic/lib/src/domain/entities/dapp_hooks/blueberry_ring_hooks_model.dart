import 'dart:convert';
import 'package:mxc_logic/mxc_logic.dart';

class BlueberryRingHooksModel {
  factory BlueberryRingHooksModel.fromJson(String source) =>
      BlueberryRingHooksModel.fromMap(json.decode(source));

  factory BlueberryRingHooksModel.fromMap(Map<String, dynamic> map) {
    late DateTime time;
    if (map['time'] != null) {
      final timeString = map['time'];
      time = DateTime.parse(timeString);
    } else {
      time = BackgroundExecutionConfig.defaultTimeForMinerDapp;
    }
    return BlueberryRingHooksModel(
      enabled: map['enabled'] ?? false,
      time: time,
      selectedRings: map['selectedRings'] == null
          ? []
          : List<String>.from(map['selectedRings']),
    );
  }

  BlueberryRingHooksModel({
    required this.enabled,
    required this.time,
    required this.selectedRings,
  });

  bool enabled;
  DateTime time;
  List<String> selectedRings;

  BlueberryRingHooksModel copyWith({
    bool? enabled,
    DateTime? time,
    List<String>? selectedRings,
  }) {
    return BlueberryRingHooksModel(
      enabled: enabled ?? this.enabled,
      time: time ?? this.time,
      selectedRings: selectedRings ?? this.selectedRings,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'enabled': enabled,
      'time': time.toString(),
      'selectedRings': selectedRings,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'BlueberryRingHooksModel(enabled: $enabled, time: $time)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BlueberryRingHooksModel &&
        other.enabled == enabled &&
        other.time == time;
  }

  @override
  int get hashCode => enabled.hashCode ^ time.hashCode;
}
