import 'dart:convert';
import 'package:mxc_logic/mxc_logic.dart';

class MinerHooksModel {
  factory MinerHooksModel.fromJson(String source) =>
      MinerHooksModel.fromMap(json.decode(source));

  factory MinerHooksModel.fromMap(Map<String, dynamic> map) {
    late DateTime time;
    if (map['time'] != null) {
      final timeString = map['time'];
      time = DateTime.parse(timeString);
    } else {
      time = Config.defaultTimeForMinerDapp;
    }
    return MinerHooksModel(
      enabled: map['enabled'] ?? false,
      time: time,
      selectedMiners: map['selectedMiners'] == null
          ? []
          : List<String>.from(map['selectedMiners']),
    );
  }

  MinerHooksModel({
    required this.enabled,
    required this.time,
    required this.selectedMiners,
  });

  bool enabled;
  DateTime time;
  List<String> selectedMiners;

  MinerHooksModel copyWith({
    bool? enabled,
    DateTime? time,
    List<String>? selectedMiners,
  }) {
    return MinerHooksModel(
      enabled: enabled ?? this.enabled,
      time: time ?? this.time,
      selectedMiners: selectedMiners ?? this.selectedMiners,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'enabled': enabled,
      'time': time.toString(),
      'selectedMiners': selectedMiners,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'MinerHooksModel(enabled: $enabled, time: $time)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MinerHooksModel &&
        other.enabled == enabled &&
        other.time == time;
  }

  @override
  int get hashCode => enabled.hashCode ^ time.hashCode;
}
