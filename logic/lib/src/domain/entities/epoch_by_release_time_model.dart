import 'dart:convert';

class EpochByReleaseTimeModel {
  factory EpochByReleaseTimeModel.fromJson(String source) =>
      EpochByReleaseTimeModel.fromMap(json.decode(source));

  factory EpochByReleaseTimeModel.fromMap(Map<String, dynamic> map) {
    return EpochByReleaseTimeModel(
      epoch: BigInt.parse(map['epoch']),
      epochReleaseTime: BigInt.parse(map['epochReleaseTime']),
    );
  }

  EpochByReleaseTimeModel({
    required this.epoch,
    required this.epochReleaseTime,
  });

  BigInt epoch;
  BigInt epochReleaseTime;

  EpochByReleaseTimeModel copyWith({
    BigInt? epoch,
    BigInt? epochReleaseTime,
  }) {
    return EpochByReleaseTimeModel(
      epoch: epoch ?? this.epoch,
      epochReleaseTime: epochReleaseTime ?? this.epochReleaseTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'epoch': epoch.toString(),
      'epochReleaseTime': epochReleaseTime.toString(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'EpochByReleaseTimeModel(epoch: $epoch, epochReleaseTime: $epochReleaseTime)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EpochByReleaseTimeModel &&
        other.epoch == epoch &&
        other.epochReleaseTime == epochReleaseTime;
  }

  @override
  int get hashCode => epoch.hashCode ^ epochReleaseTime.hashCode;
}
