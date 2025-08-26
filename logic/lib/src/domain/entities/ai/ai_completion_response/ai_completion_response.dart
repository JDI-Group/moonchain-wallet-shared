import 'dart:convert';

import 'data.dart';

class AiCompletionResponse {
  AiCompletionResponse({this.retcode, this.retmsg, this.data});

  factory AiCompletionResponse.fromJson(String data) {
    return AiCompletionResponse.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  factory AiCompletionResponse.fromMap(Map<String, dynamic> json) {
    return AiCompletionResponse(
      retcode: json['retcode'] as int?,
      retmsg: json['retmsg'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  int? retcode;
  String? retmsg;
  Data? data;

  Map<String, dynamic> toJson() => {
        'retcode': retcode,
        'retmsg': retmsg,
        'data': data?.toJson(),
      };
}
