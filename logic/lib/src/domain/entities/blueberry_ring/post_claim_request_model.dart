import 'dart:convert';

class PostClaimRequestModel {
  factory PostClaimRequestModel.fromJson(String source) =>
      PostClaimRequestModel.fromMap(json.decode(source));

  factory PostClaimRequestModel.fromMap(Map<String, dynamic> map) {
    return PostClaimRequestModel(
      sncode: map['sncode'] ?? '',
      sender: map['sender'] ?? '',
    );
  }
  PostClaimRequestModel({
    required this.sncode,
    required this.sender,
  });
  String sncode;
  String sender;

  PostClaimRequestModel copyWith({
    String? sncode,
    String? sender,
  }) {
    return PostClaimRequestModel(
      sncode: sncode ?? this.sncode,
      sender: sender ?? this.sender,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sncode': sncode,
      'sender': sender,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'PostClaimRequestModel(sncode: $sncode, sender: $sender)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostClaimRequestModel &&
        other.sncode == sncode &&
        other.sender == sender;
  }

  @override
  int get hashCode => sncode.hashCode ^ sender.hashCode;
}
