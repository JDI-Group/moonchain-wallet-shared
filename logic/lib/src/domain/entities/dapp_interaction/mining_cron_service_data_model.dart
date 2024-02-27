import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:mxc_logic/mxc_logic.dart';

class MiningCronServiceDataModel {
  factory MiningCronServiceDataModel.fromDAppHooksData(
      DAppHooksModel dappHooksModel) {
    return MiningCronServiceDataModel(
      minersList: dappHooksModel.minerHooks.selectedMiners,
      time: dappHooksModel.minerHooks.time,
    );
  }
  factory MiningCronServiceDataModel.fromJson(String source) =>
      MiningCronServiceDataModel.fromMap(json.decode(source));

  factory MiningCronServiceDataModel.fromMap(Map<String, dynamic> map) {
    return MiningCronServiceDataModel(
      minersList: List<String>.from(map['minersList']),
      time: map['time'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['time'])
          : null,
    );
  }
  MiningCronServiceDataModel({
    this.minersList,
    this.time,
  });
  List<String>? minersList;
  DateTime? time;
  MiningCronServiceDataModel copyWith({
    ValueGetter<List<String>?>? minersList,
    ValueGetter<DateTime?>? time,
  }) {
    return MiningCronServiceDataModel(
      minersList: minersList != null ? minersList() : this.minersList,
      time: time != null ? time() : this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'minersList': minersList,
      'time': time?.millisecondsSinceEpoch,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'MiningCronServiceDataModel(minersList: $minersList, time: $time)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is MiningCronServiceDataModel &&
        listEquals(other.minersList, minersList) &&
        other.time == time;
  }

  @override
  int get hashCode => minersList.hashCode ^ time.hashCode;
}
