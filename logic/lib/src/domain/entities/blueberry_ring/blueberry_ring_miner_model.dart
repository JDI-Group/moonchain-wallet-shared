import 'dart:convert';

import 'package:flutter/widgets.dart';

class BlueberryRingMiner {
  factory BlueberryRingMiner.fromJson(String source) =>
      BlueberryRingMiner.fromMap(json.decode(source));

  factory BlueberryRingMiner.fromMap(Map<String, dynamic> map) {
    return BlueberryRingMiner(
      token: map['token'] ?? '',
      tokenId: map['tokenId']?.toInt() ?? 0,
      sncode: map['sncode'] ?? '',
      owner: map['owner'] ?? '',
      name: map['name'] ?? '',
      group: map['group']?.toInt(),
      avatar: map['avatar'],
      nickname: map['nickname'],
    );
  }
  BlueberryRingMiner({
    required this.token,
    required this.tokenId,
    required this.sncode,
    required this.owner,
    required this.name,
    this.group,
    this.avatar,
    this.nickname,
  });
  String token;
  int tokenId;
  String sncode;
  String owner;
  String name;
  int? group;
  String? avatar;
  String? nickname;

  BlueberryRingMiner copyWith({
    String? token,
    int? tokenId,
    String? sncode,
    String? owner,
    String? name,
    ValueGetter<int?>? group,
    ValueGetter<String?>? avatar,
    ValueGetter<String?>? nickname,
  }) {
    return BlueberryRingMiner(
      token: token ?? this.token,
      tokenId: tokenId ?? this.tokenId,
      sncode: sncode ?? this.sncode,
      owner: owner ?? this.owner,
      name: name ?? this.name,
      group: group != null ? group() : this.group,
      avatar: avatar != null ? avatar() : this.avatar,
      nickname: nickname != null ? nickname() : this.nickname,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'tokenId': tokenId,
      'sncode': sncode,
      'owner': owner,
      'name': name,
      'group': group,
      'avatar': avatar,
      'nickname': nickname,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'BlueberryRingMiner(token: $token, tokenId: $tokenId, sncode: $sncode, owner: $owner, name: $name, group: $group, avatar: $avatar, nickname: $nickname)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BlueberryRingMiner &&
        other.token == token &&
        other.tokenId == tokenId &&
        other.sncode == sncode &&
        other.owner == owner &&
        other.name == name &&
        other.group == group &&
        other.avatar == avatar &&
        other.nickname == nickname;
  }

  @override
  int get hashCode {
    return token.hashCode ^
        tokenId.hashCode ^
        sncode.hashCode ^
        owner.hashCode ^
        name.hashCode ^
        group.hashCode ^
        avatar.hashCode ^
        nickname.hashCode;
  }
}
