import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:intl/intl.dart';

class RewardDetailsModel {
  factory RewardDetailsModel.fromJson(String source) =>
      RewardDetailsModel.fromMap(json.decode(source));

  factory RewardDetailsModel.fromMap(Map<String, dynamic> map) {
    return RewardDetailsModel(
      mep1004TokenId: int.parse(map['mep1004TokenId'] ?? '0'),
      epochNumber: int.parse(map['epochNumber'] ?? '0'),
      createTime: map['createTime'] ?? '',
      rewardInfoJson: map['rewardInfoJson'] == null
          ? RewardInfoJson(amount: [], token: [])
          : RewardInfoJson.fromJson(map['rewardInfoJson']),
      rewardHash: map['rewardHash'] ?? '',
      userselectedToken: map['userselectedToken'] ?? '',
      proofJson: map['proofJson'] == null
          ? []
          : (jsonDecode(map['proofJson']) as Iterable<dynamic>)
              .map<String>((dynamic item) => item.toString())
              .toList(),
    );
  }

  RewardDetailsModel({
    required this.mep1004TokenId,
    required this.epochNumber,
    required this.createTime,
    required this.rewardInfoJson,
    required this.rewardHash,
    required this.userselectedToken,
    required this.proofJson,
  });
  int mep1004TokenId;
  int epochNumber;
  String createTime;
  RewardInfoJson rewardInfoJson;
  String rewardHash;
  String userselectedToken;
  List<String> proofJson;

  RewardDetailsModel copyWith({
    int? mep1004TokenId,
    int? epochNumber,
    String? createTime,
    RewardInfoJson? rewardInfoJson,
    String? rewardHash,
    String? userselectedToken,
    List<String>? proofJson,
  }) {
    return RewardDetailsModel(
      mep1004TokenId: mep1004TokenId ?? this.mep1004TokenId,
      epochNumber: epochNumber ?? this.epochNumber,
      createTime: createTime ?? this.createTime,
      rewardInfoJson: rewardInfoJson ?? this.rewardInfoJson,
      rewardHash: rewardHash ?? this.rewardHash,
      userselectedToken: userselectedToken ?? this.userselectedToken,
      proofJson: proofJson ?? this.proofJson,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mep1004TokenId': mep1004TokenId,
      'epochNumber': epochNumber,
      'createTime': createTime,
      'rewardInfoJson': rewardInfoJson.toMap(),
      'rewardHash': rewardHash,
      'userselectedToken': userselectedToken,
      'proofJson': proofJson,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'RewardDetailsModel(mep1004TokenId: $mep1004TokenId, epochNumber: $epochNumber, createTime: $createTime, rewardInfoJson: $rewardInfoJson, rewardHash: $rewardHash, userselectedToken: $userselectedToken, proofJson: $proofJson)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RewardDetailsModel &&
        other.mep1004TokenId == mep1004TokenId &&
        other.epochNumber == epochNumber &&
        other.createTime == createTime &&
        other.rewardInfoJson == rewardInfoJson &&
        other.rewardHash == rewardHash &&
        other.userselectedToken == userselectedToken &&
        other.proofJson == proofJson;
  }

  @override
  int get hashCode {
    return mep1004TokenId.hashCode ^
        epochNumber.hashCode ^
        createTime.hashCode ^
        rewardInfoJson.hashCode ^
        rewardHash.hashCode ^
        userselectedToken.hashCode ^
        proofJson.hashCode;
  }
}

class RewardInfoJson {
  factory RewardInfoJson.fromJson(String source) =>
      RewardInfoJson.fromMap(json.decode(source));

  factory RewardInfoJson.fromMap(Map<String, dynamic> map) {
    return RewardInfoJson(
      amount: map['Amount'] == null
          ? []
          : List<BigInt>.from(
              ((map['Amount'] as List<dynamic>))
                  .map((x) => BigInt.parse(x as String)),
            ),
      token: map['Token'] == null ? [] : List<String>.from(map['Token']),
    );
  }
  RewardInfoJson({
    required this.amount,
    required this.token,
  });
  List<BigInt> amount;
  List<String> token;

  RewardInfoJson copyWith({
    List<BigInt>? amount,
    List<String>? token,
  }) {
    return RewardInfoJson(
      amount: amount ?? this.amount,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Amount': amount.map((x) => x.toString()).toList(),
      'Token': token,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'RewardInfoJson(amount: $amount, token: $token)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is RewardInfoJson &&
        listEquals(other.amount, amount) &&
        listEquals(other.token, token);
  }

  @override
  int get hashCode => amount.hashCode ^ token.hashCode;
}
