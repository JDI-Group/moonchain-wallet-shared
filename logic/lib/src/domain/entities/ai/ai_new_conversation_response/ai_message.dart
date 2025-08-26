class AIMessage {
  AIMessage({this.content, this.role});
  String? content;
  String? role;

  factory AIMessage.fromJson(Map<String, dynamic> json) => AIMessage(
        content: json['content'] as String?,
        role: json['role'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'content': content,
        'role': role,
      };

  @override
  List<Object?> get props => [content, role];
}
