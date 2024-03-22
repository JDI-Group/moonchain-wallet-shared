import 'dart:convert';

import 'package:equatable/equatable.dart';

export 'mep1004_token_detail.dart';
import 'mep1004_token_detail.dart';

class MinerListModel extends Equatable {
  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MinerListModel].
  factory MinerListModel.fromJson(String data) {
    return MinerListModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  factory MinerListModel.fromMap(Map<String, dynamic> data) {
    return MinerListModel(
      mep1004TokenDetails: (data['mep1004TokenDetails'] as List<dynamic>?)
          ?.map((e) => Mep1004TokenDetail.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  const MinerListModel({this.mep1004TokenDetails});
  final List<Mep1004TokenDetail>? mep1004TokenDetails;

  Map<String, dynamic> toMap() => {
        'mep1004TokenDetails':
            mep1004TokenDetails?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Converts [MinerListModel] to a JSON string.
  String toJson() => json.encode(toMap());

  MinerListModel copyWith({
    List<Mep1004TokenDetail>? mep1004TokenDetails,
  }) {
    return MinerListModel(
      mep1004TokenDetails: mep1004TokenDetails ?? this.mep1004TokenDetails,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [mep1004TokenDetails];
}
