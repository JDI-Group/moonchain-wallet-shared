import 'package:uuid/uuid.dart';
import 'package:equatable/equatable.dart';

class AIMessage extends Equatable {
  factory AIMessage.fromJson(Map<String, dynamic> json) => AIMessage(
        content: (json['content'] ?? '') as String,
        role: (json['role'] ?? '') as String,
        createdAt: json['createdAt'] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['createdAt'])
            : DateTime.now(),
        uuid: json['uuid'] ?? const Uuid().v8(),
      );
  AIMessage({
    String? uuid,
    required this.content,
    required this.role,
    DateTime? createdAt,
  })  : uuid = uuid ?? const Uuid().v8(),
        createdAt = createdAt ?? DateTime.now();

  final String content;
  final String role;
  final String uuid;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => {
        'content': content,
        'role': role,
        'uuid': uuid,
        'createdAt': createdAt.millisecondsSinceEpoch,
      };

  @override
  List<Object?> get props => [uuid, content, role, createdAt];
}
