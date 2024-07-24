import 'dart:convert';

class PostClaimResponseModel {
  factory PostClaimResponseModel.fromJson(String source) =>
      PostClaimResponseModel.fromMap(json.decode(source));

  factory PostClaimResponseModel.fromMap(Map<String, dynamic> map) {
    return PostClaimResponseModel(
      uid: map['uid'] ?? '',
      signature: map['signature'] ?? '',
      amount: map['amount'] ?? '',
    );
  }
  PostClaimResponseModel({
    required this.uid,
    required this.signature,
    required this.amount,
  });
  String uid;
  String signature;
  String amount;

  PostClaimResponseModel copyWith({
    String? uid,
    String? signature,
    String? amount,
  }) {
    return PostClaimResponseModel(
      uid: uid ?? this.uid,
      signature: signature ?? this.signature,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'signature': signature,
      'amount': amount,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'PostClaimResponseModel(uid: $uid, signature: $signature, amount: $amount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostClaimResponseModel &&
        other.uid == uid &&
        other.signature == signature &&
        other.amount == amount;
  }

  @override
  int get hashCode => uid.hashCode ^ signature.hashCode ^ amount.hashCode;
}
