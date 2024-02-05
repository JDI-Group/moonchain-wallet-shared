import 'dart:convert';

import 'package:equatable/equatable.dart';

class Mep1004TokenDetail extends Equatable {
  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Mep1004TokenDetail].
  factory Mep1004TokenDetail.fromJson(String data) {
    return Mep1004TokenDetail.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  factory Mep1004TokenDetail.fromMap(Map<String, dynamic> data) {
    return Mep1004TokenDetail(
      mep1004TokenId: data['mep1004TokenId'] as String?,
      createBlockHeight: data['createBlockHeight'] as String?,
      tokenName: data['tokenName'] as String?,
      sncode: data['sncode'] as String?,
      regionId: data['regionId'] as String?,
      mep1002TokenId: data['mep1002TokenID'] as String?,
      mep1002SlotIndex: data['mep1002SlotIndex'] as String?,
      fuelTankSize: data['fuelTankSize'] as String?,
      sensorFuelTankSize: data['sensorFuelTankSize'] as String?,
      erc6551Addr: data['erc6551Addr'] as String?,
      fuelInfos: data['fuelInfos'] as List<dynamic>?,
      imageIndex: data['imageIndex'] as String?,
      online: data['online'] as bool?,
    );
  }

  const Mep1004TokenDetail({
    this.mep1004TokenId,
    this.createBlockHeight,
    this.tokenName,
    this.sncode,
    this.regionId,
    this.mep1002TokenId,
    this.mep1002SlotIndex,
    this.fuelTankSize,
    this.sensorFuelTankSize,
    this.erc6551Addr,
    this.fuelInfos,
    this.imageIndex,
    this.online,
  });
  final String? mep1004TokenId;
  final String? createBlockHeight;
  final String? tokenName;
  final String? sncode;
  final String? regionId;
  final String? mep1002TokenId;
  final String? mep1002SlotIndex;
  final String? fuelTankSize;
  final String? sensorFuelTankSize;
  final String? erc6551Addr;
  final List<dynamic>? fuelInfos;
  final String? imageIndex;
  final bool? online;

  Map<String, dynamic> toMap() => {
        'mep1004TokenId': mep1004TokenId,
        'createBlockHeight': createBlockHeight,
        'tokenName': tokenName,
        'sncode': sncode,
        'regionId': regionId,
        'mep1002TokenID': mep1002TokenId,
        'mep1002SlotIndex': mep1002SlotIndex,
        'fuelTankSize': fuelTankSize,
        'sensorFuelTankSize': sensorFuelTankSize,
        'erc6551Addr': erc6551Addr,
        'fuelInfos': fuelInfos,
        'imageIndex': imageIndex,
        'online': online,
      };

  /// `dart:convert`
  ///
  /// Converts [Mep1004TokenDetail] to a JSON string.
  String toJson() => json.encode(toMap());

  Mep1004TokenDetail copyWith({
    String? mep1004TokenId,
    String? createBlockHeight,
    String? tokenName,
    String? sncode,
    String? regionId,
    String? mep1002TokenId,
    String? mep1002SlotIndex,
    String? fuelTankSize,
    String? sensorFuelTankSize,
    String? erc6551Addr,
    List<dynamic>? fuelInfos,
    String? imageIndex,
    bool? online,
  }) {
    return Mep1004TokenDetail(
      mep1004TokenId: mep1004TokenId ?? this.mep1004TokenId,
      createBlockHeight: createBlockHeight ?? this.createBlockHeight,
      tokenName: tokenName ?? this.tokenName,
      sncode: sncode ?? this.sncode,
      regionId: regionId ?? this.regionId,
      mep1002TokenId: mep1002TokenId ?? this.mep1002TokenId,
      mep1002SlotIndex: mep1002SlotIndex ?? this.mep1002SlotIndex,
      fuelTankSize: fuelTankSize ?? this.fuelTankSize,
      sensorFuelTankSize: sensorFuelTankSize ?? this.sensorFuelTankSize,
      erc6551Addr: erc6551Addr ?? this.erc6551Addr,
      fuelInfos: fuelInfos ?? this.fuelInfos,
      imageIndex: imageIndex ?? this.imageIndex,
      online: online ?? this.online,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      mep1004TokenId,
      createBlockHeight,
      tokenName,
      sncode,
      regionId,
      mep1002TokenId,
      mep1002SlotIndex,
      fuelTankSize,
      sensorFuelTankSize,
      erc6551Addr,
      fuelInfos,
      imageIndex,
      online,
    ];
  }
}
