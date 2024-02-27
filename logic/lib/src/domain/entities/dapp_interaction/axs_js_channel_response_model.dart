import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:mxc_logic/src/domain/entities/dapp_interaction/cron_service_data_model.dart';

import 'axs_cron_data_model.dart';
import 'axs_js_channel_response_status.dart';

class AXSJSChannelResponseModel<T> {
  factory AXSJSChannelResponseModel.fromJson(
    String source,
    T Function(Map<String, dynamic>) dataFromMap,
  ) =>
      AXSJSChannelResponseModel.fromMap(json.decode(source), dataFromMap);

  factory AXSJSChannelResponseModel.fromMap(
    Map<String, dynamic> map,
    T Function(Map<String, dynamic>) dataFromMap,
  ) {
    return AXSJSChannelResponseModel<T>(
      status: AXSJSChannelResponseStatusExtension.fromString(
          map['status'] as String),
      message: map['message'],
      data: map['data'] != null
          ? CronServiceDataModel<T>.fromMap(map['data'], dataFromMap)
          : null,
    );
  }
  AXSJSChannelResponseModel({
    required this.status,
    this.message,
    this.data,
  });
  AXSJSChannelResponseStatus status;
  String? message;
  CronServiceDataModel<T>? data;

  AXSJSChannelResponseModel<T> copyWith({
    AXSJSChannelResponseStatus? status,
    ValueGetter<String?>? message,
    ValueGetter<CronServiceDataModel<T>?>? data,
  }) {
    return AXSJSChannelResponseModel<T>(
      status: status ?? this.status,
      message: message != null ? message() : this.message,
      data: data != null ? data() : this.data,
    );
  }

  Map<String, dynamic> toMap(Map<String, dynamic> Function(T?) dataToMap) {
    return {
      'status': status.name,
      'message': message,
      'data': data?.toMap(dataToMap),
    };
  }

  String toJson(Map<String, dynamic> Function(T?) dataToMap) =>
      json.encode(toMap(dataToMap));

  @override
  String toString() =>
      'AXSJSChannelResponseModel(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AXSJSChannelResponseModel<T> &&
        other.status == status &&
        other.message == message &&
        other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
