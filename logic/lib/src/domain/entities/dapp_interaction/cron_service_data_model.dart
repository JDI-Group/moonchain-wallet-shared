import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:mxc_logic/mxc_logic.dart';

class CronServiceDataModel<T> {

  factory CronServiceDataModel.fromDAppHooksData(
    AXSCronServices cronService,
    DAppHooksModel dappHooksModel,
    T data,
  ) {
    return CronServiceDataModel(
      name: cronService.name,
      data: data,
      enabled: dappHooksModel.minerHooks.enabled,
    );
  }
  factory CronServiceDataModel.fromJson(
    String source,
    T Function(Map<String, dynamic>) dataFromMap,
  ) =>
      CronServiceDataModel.fromMap(json.decode(source), dataFromMap);

  factory CronServiceDataModel.fromMap(
    Map<String, dynamic> map,
    T Function(Map<String, dynamic>) dataFromMap,
  ) {
    return CronServiceDataModel<T>(
      name: map['name'],
      enabled: map['enabled'],
      data: map['data'] != null ? dataFromMap(map['data']) : null,
    );
  }
  CronServiceDataModel({
    this.name,
    this.enabled,
    this.data,
  });

  String? name;
  bool? enabled;
  T? data;

  CronServiceDataModel<T> copyWith({
    ValueGetter<String?>? name,
    ValueGetter<bool?>? enabled,
    ValueGetter<T?>? data,
  }) {
    return CronServiceDataModel<T>(
      name: name != null ? name() : this.name,
      enabled: enabled != null ? enabled() : this.enabled,
      data: data != null ? data() : this.data,
    );
  }

  Map<String, dynamic> toMap(Map<String, dynamic> Function(T?) dataToMap) {
    return {
      'name': name,
      'enabled': enabled,
      'data': dataToMap(data),
    };
  }

  String toJson(Map<String, dynamic> Function(T?) dataToMap) =>
      json.encode(toMap(dataToMap));

  @override
  String toString() =>
      'CronServiceDataModel(name: $name, enabled: $enabled, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CronServiceDataModel<T> &&
        other.name == name &&
        other.enabled == enabled &&
        other.data == data;
  }

  @override
  int get hashCode => name.hashCode ^ enabled.hashCode ^ data.hashCode;

  // @override
  // T fromJson(String source, T Function(Map<String, dynamic>) dataFromMap,) {
  //   // TODO: implement fromJson
  //   throw UnimplementedError();
  // }

  // @override
  // fromMap(Map<String, dynamic> map, T Function(Map<String, dynamic>) dataFromMap,) {
  //   // TODO: implement fromMap
  //   throw UnimplementedError();
  // }
}
