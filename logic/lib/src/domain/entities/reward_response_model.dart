import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'reward_details_model.dart';

class RewardResponseModel {
  factory RewardResponseModel.fromJson(String source) =>
      RewardResponseModel.fromMap(json.decode(source));

  factory RewardResponseModel.fromMap(Map<String, dynamic> map) {
    return RewardResponseModel(
      rewardInfoDetails: List<RewardDetailsModel>.from(
          map['rewardInfoDetails']?.map((x) => RewardDetailsModel.fromMap(x))),
    );
  }
  RewardResponseModel({
    required this.rewardInfoDetails,
  });
  List<RewardDetailsModel> rewardInfoDetails;

  RewardResponseModel copyWith({
    List<RewardDetailsModel>? rewardInfoDetails,
  }) {
    return RewardResponseModel(
      rewardInfoDetails: rewardInfoDetails ?? this.rewardInfoDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rewardInfoDetails': rewardInfoDetails.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'RewardResponseModel(rewardInfoDetails: $rewardInfoDetails)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RewardResponseModel &&
        listEquals(other.rewardInfoDetails, rewardInfoDetails);
  }

  @override
  int get hashCode => rewardInfoDetails.hashCode;
}
