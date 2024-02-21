import 'dart:convert';

class VerifyMerkleProofResponse {
  VerifyMerkleProofResponse({
    required this.signature,
    required this.claimEncodeFunctionData,
  });
  String signature;
  String claimEncodeFunctionData;

  VerifyMerkleProofResponse copyWith({
    String? signature,
    String? claimEncodeFunctionData,
  }) {
    return VerifyMerkleProofResponse(
      signature: signature ?? this.signature,
      claimEncodeFunctionData:
          claimEncodeFunctionData ?? this.claimEncodeFunctionData,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'signature': signature,
      'claimEncodeFunctionData': claimEncodeFunctionData,
    };
  }

  factory VerifyMerkleProofResponse.fromMap(Map<String, dynamic> map) {
    return VerifyMerkleProofResponse(
      signature: map['signature'] ?? '',
      claimEncodeFunctionData: map['claimEncodeFunctionData'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VerifyMerkleProofResponse.fromJson(String source) =>
      VerifyMerkleProofResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'VerifyMerkleProofResponse(signature: $signature, claimEncodeFunctionData: $claimEncodeFunctionData)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VerifyMerkleProofResponse &&
        other.signature == signature &&
        other.claimEncodeFunctionData == claimEncodeFunctionData;
  }

  @override
  int get hashCode => signature.hashCode ^ claimEncodeFunctionData.hashCode;
}
