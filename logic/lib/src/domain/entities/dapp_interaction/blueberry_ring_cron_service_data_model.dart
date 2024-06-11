import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mxc_logic/mxc_logic.dart';

class BlueberryRingCronServiceDataModel {
  factory BlueberryRingCronServiceDataModel.fromBlueberryRingHooksData(
    DAppHooksModel dappHooksModel,
  ) {
    return BlueberryRingCronServiceDataModel(
      devicesList: dappHooksModel.minerHooks.selectedMiners,
      time: dappHooksModel.minerHooks.time,
    );
  }
  factory BlueberryRingCronServiceDataModel.fromJson(String source) =>
      BlueberryRingCronServiceDataModel.fromMap(json.decode(source));

  factory BlueberryRingCronServiceDataModel.fromMap(Map<String, dynamic> map) {
    return BlueberryRingCronServiceDataModel(
      devicesList: map['devicesList'] != null
          ? List<String>.from(map['devicesList'])
          : null,
      time: map['time'] != null ? DateFormat('HH:mm').parse(map['time']) : null,
    );
  }
  BlueberryRingCronServiceDataModel({
    this.devicesList,
    this.time,
  });
  List<String>? devicesList;
  DateTime? time;
  BlueberryRingCronServiceDataModel copyWith({
    ValueGetter<List<String>?>? devicesList,
    ValueGetter<DateTime?>? time,
  }) {
    return BlueberryRingCronServiceDataModel(
      devicesList: devicesList != null ? devicesList() : this.devicesList,
      time: time != null ? time() : this.time,
    );
  }

  Map<String, dynamic> toMapWrapper(
      BlueberryRingCronServiceDataModel? miningCronServiceDataModel) {
    return miningCronServiceDataModel!.toMap();
  }

  Map<String, dynamic> toMap() {
    return {
      'devicesList': devicesList,
      'time': DateFormat('HH:mm').format(time!),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'BlueberryRingCronServiceDataModel(devicesList: $devicesList, time: $time)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is BlueberryRingCronServiceDataModel &&
        listEquals(other.devicesList, devicesList) &&
        other.time == time;
  }

  @override
  int get hashCode => devicesList.hashCode ^ time.hashCode;
}
