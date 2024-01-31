import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mxc_logic/mxc_logic.dart';

class MinerHooksModel {
  factory MinerHooksModel.fromJson(String source) =>
      MinerHooksModel.fromMap(json.decode(source));

  factory MinerHooksModel.fromMap(Map<String, dynamic> map) {
    late TimeOfDay time;
    if (map['time'] != null) {
      final timeString = map['time'];
      time = TimeOfDay.fromDateTime(
        DateFormat('h:mm').parse(timeString),
      );
    } else {
      time = Config.defaultTimeForMinerDapp;
    }
    return MinerHooksModel(
      enabled: map['enabled'] ?? false,
      time: time,
    );
  }

  MinerHooksModel({
    required this.enabled,
    required this.time,
  });

  bool enabled;
  TimeOfDay time;

  MinerHooksModel copyWith({
    bool? enabled,
    TimeOfDay? time,
  }) {
    return MinerHooksModel(
      enabled: enabled ?? this.enabled,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'enabled': enabled,
      'time': '${time.hour}:${time.minute}',
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
