class MEPEpochDetails {
  MEPEpochDetails.fromJson(Map<String, dynamic> json) {
    if (json['epochDetails'] != null) {
      epochDetails = <EpochDetails>[];
      json['epochDetails'].forEach((v) {
        epochDetails!.add(EpochDetails.fromJson(v));
      });
    }
    total = json['total'];
  }

  MEPEpochDetails({this.epochDetails, this.total});
  List<EpochDetails>? epochDetails;
  String? total;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (epochDetails != null) {
      data['epochDetails'] = epochDetails!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }
}

class EpochDetails {
  EpochDetails.fromJson(Map<String, dynamic> json) {
    epochNumber = json['epochNumber'];
    createBlockNumber = json['createBlockNumber'];
    createTime = json['createTime'];
    memberCount = json['memberCount'];
    rewardMerkleRoot = json['rewardMerkleRoot'];
    onlineStatusBytes = json['onlineStatusBytes'];
    publicBlockNumber = json['publicBlockNumber'];
  }

  EpochDetails(
      {this.epochNumber,
      this.createBlockNumber,
      this.createTime,
      this.memberCount,
      this.rewardMerkleRoot,
      this.onlineStatusBytes,
      this.publicBlockNumber});
  String? epochNumber;
  String? createBlockNumber;
  String? createTime;
  String? memberCount;
  String? rewardMerkleRoot;
  String? onlineStatusBytes;
  String? publicBlockNumber;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['epochNumber'] = epochNumber;
    data['createBlockNumber'] = createBlockNumber;
    data['createTime'] = createTime;
    data['memberCount'] = memberCount;
    data['rewardMerkleRoot'] = rewardMerkleRoot;
    data['onlineStatusBytes'] = onlineStatusBytes;
    data['publicBlockNumber'] = publicBlockNumber;
    return data;
  }
}
