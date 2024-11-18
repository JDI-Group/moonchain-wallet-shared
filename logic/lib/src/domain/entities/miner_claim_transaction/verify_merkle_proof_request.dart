import 'dart:convert';

class VerifyMerkleProofRequest {

  factory VerifyMerkleProofRequest.fromMap(Map<String, dynamic> map) {
    return VerifyMerkleProofRequest(
      encodeFunctionData: map['encodeFunctionData'] ?? '',
      spender: map['spender'] ?? '',
      to: map['to'] ?? '',
    );
  }

  factory VerifyMerkleProofRequest.fromJson(String source) =>
      VerifyMerkleProofRequest.fromMap(json.decode(source));
  VerifyMerkleProofRequest({
    required this.encodeFunctionData,
    required this.spender,
    required this.to,
  });
  String encodeFunctionData;
  String spender;
  String to;

  VerifyMerkleProofRequest copyWith({
    String? encodeFunctionData,
    String? spender,
    String? to,
  }) {
    return VerifyMerkleProofRequest(
      encodeFunctionData: encodeFunctionData ?? this.encodeFunctionData,
      spender: spender ?? this.spender,
      to: to ?? this.to,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'encodeFunctionData': encodeFunctionData,
      'spender': spender,
      'to': to,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'VerifyMerkleProofRequest(encodeFunctionData: $encodeFunctionData, spender: $spender, to: $to)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VerifyMerkleProofRequest &&
        other.encodeFunctionData == encodeFunctionData &&
        other.spender == spender &&
        other.to == to;
  }

  @override
  int get hashCode =>
      encodeFunctionData.hashCode ^ spender.hashCode ^ to.hashCode;
}
