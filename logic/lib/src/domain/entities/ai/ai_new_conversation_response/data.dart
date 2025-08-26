import 'ai_message.dart';

class Data {
  String? dialogId;
  String? id;
  List<AIMessage>? message;
  String? userId;

  Data({this.dialogId, this.id, this.message, this.userId});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        dialogId: json['dialog_id'] as String?,
        id: json['id'] as String?,
        message: (json['message'] as List<dynamic>?)
            ?.map((e) => AIMessage.fromJson(e as Map<String, dynamic>))
            .toList(),
        userId: json['user_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'dialog_id': dialogId,
        'id': id,
        'message': message?.map((e) => e.toJson()).toList(),
        'user_id': userId,
      };
}
