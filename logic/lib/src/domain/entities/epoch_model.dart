import 'dart:convert';

class EpochModel {
  factory EpochModel.fromJson(String source) =>
      EpochModel.fromMap(json.decode(source));

  factory EpochModel.fromMap(Map<String, dynamic> map) {
    return EpochModel(
      epochReleaseTime: BigInt.parse(map['epochReleaseTime']),
      id: map['id']?.toInt() ?? 0,
      epoch: map['epoch']?.toInt() ?? 0,
      expired: map['expired'] ?? false,
    );
  }
  EpochModel({
    required this.epochReleaseTime,
    required this.id,
    required this.epoch,
    required this.expired,
  });
  BigInt epochReleaseTime;
  int id;
  int epoch;
  bool expired;

  EpochModel copyWith({
    BigInt? epochReleaseTime,
    int? id,
    int? epoch,
    bool? expired,
  }) {
    return EpochModel(
      epochReleaseTime: epochReleaseTime ?? this.epochReleaseTime,
      id: id ?? this.id,
      epoch: epoch ?? this.epoch,
      expired: expired ?? this.expired,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'epochReleaseTime': epochReleaseTime.toString(),
      'id': id,
      'epoch': epoch,
      'expired': expired,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'EpochModel(epochReleaseTime: $epochReleaseTime, id: $id, epoch: $epoch, expired: $expired)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EpochModel &&
        other.epochReleaseTime == epochReleaseTime &&
        other.id == id &&
        other.epoch == epoch &&
        other.expired == expired;
  }

  @override
  int get hashCode {
    return epochReleaseTime.hashCode ^
        id.hashCode ^
        epoch.hashCode ^
        expired.hashCode;
  }
}
