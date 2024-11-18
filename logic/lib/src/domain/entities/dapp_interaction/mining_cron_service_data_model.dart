import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mxc_logic/mxc_logic.dart';

class MiningCronServiceDataModel {
  factory MiningCronServiceDataModel.fromDAppHooksData(
    DAppHooksModel dappHooksModel,
  ) {
    return MiningCronServiceDataModel(
      minersList: dappHooksModel.minerHooks.selectedMiners,
      time: dappHooksModel.minerHooks.time,
    );
  }
  factory MiningCronServiceDataModel.fromJson(String source) =>
      MiningCronServiceDataModel.fromMap(json.decode(source));

  factory MiningCronServiceDataModel.fromMap(Map<String, dynamic> map) {
    return MiningCronServiceDataModel(
      minersList: map['minersList'] != null
          ? List<String>.from(map['minersList'])
          : null,
      time: map['time'] != null ? DateFormat('HH:mm').parse(map['time']) : null,
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

  Map<String, dynamic> toMapWrapper(
      MiningCronServiceDataModel? miningCronServiceDataModel,) {
    return miningCronServiceDataModel!.toMap();
  }

  Map<String, dynamic> toMap() {
    return {
      'minersList': minersList,
      'time': DateFormat('HH:mm').format(time!),
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
