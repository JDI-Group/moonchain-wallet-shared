import 'dart:convert';

class WifiModel {
  factory WifiModel.fromJson(String source) =>
      WifiModel.fromMap(json.decode(source));

  factory WifiModel.fromMap(Map<String, dynamic> map) {
    return WifiModel(
      wifiName: map['wifiName'] ?? '',
      wifiBSSID: map['wifiBSSID'] ?? '',
    );
  }
  WifiModel({
    required this.wifiName,
    required this.wifiBSSID,
  });

  String wifiName;
  String wifiBSSID;

  WifiModel copyWith({
    String? wifiName,
    String? wifiBSSID,
  }) {
    return WifiModel(
      wifiName: wifiName ?? this.wifiName,
      wifiBSSID: wifiBSSID ?? this.wifiBSSID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'wifiName': wifiName,
      'wifiBSSID': wifiBSSID,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'WifiModel(wifiName: $wifiName, wifiBSSID: $wifiBSSID)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WifiModel &&
        other.wifiName == wifiName &&
        other.wifiBSSID == wifiBSSID;
  }

  @override
  int get hashCode => wifiName.hashCode ^ wifiBSSID.hashCode;
}
