class Data {
  String? answer;
  // Map<String, dynamic>? reference;
  String? prompt;
  String? id;

  Data({this.answer,  this.prompt, this.id});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        answer: json['answer'] as String?,
        // reference: json['reference'] as Map<String, dynamic>?,
        prompt: json['prompt'] as String?,
        id: json['id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'answer': answer,
        // 'reference': reference,
        'prompt': prompt,
        'id': id,
      };
}
