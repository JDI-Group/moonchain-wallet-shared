import '../ai_new_conversation_response/ai_message.dart';

class AiCompletionRequestBody {

  factory AiCompletionRequestBody.fromJson(Map<String, dynamic> json) {
    return AiCompletionRequestBody(
      conversationId: json['conversation_id'] as String?,
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => AIMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      quote: json['quote'] as bool?,
      myname: json['myname'] as String?,
    );
  }

  AiCompletionRequestBody({
    this.conversationId,
    this.messages,
    this.quote,
    this.myname,
  });
  String? conversationId;
  List<AIMessage>? messages;
  bool? quote;
  String? myname;

  Map<String, dynamic> toJson() => {
        'conversation_id': conversationId,
        'messages': messages?.map((e) => e.toJson()).toList(),
        'quote': quote,
        'myname': myname,
      };
}
