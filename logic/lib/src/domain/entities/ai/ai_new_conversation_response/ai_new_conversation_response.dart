import 'dart:convert';

import 'data.dart';

class AiNewConversationResponse {

  factory AiNewConversationResponse.fromJson(String data) {
    return AiNewConversationResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  factory AiNewConversationResponse.fromMap(Map<String, dynamic> json) {
    return AiNewConversationResponse(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      retcode: json['retcode'] as int?,
      retmsg: json['retmsg'] as String?,
    );
  }

  AiNewConversationResponse({this.data, this.retcode, this.retmsg});
  Data? data;
  int? retcode;
  String? retmsg;

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'retcode': retcode,
        'retmsg': retmsg,
      };
}
