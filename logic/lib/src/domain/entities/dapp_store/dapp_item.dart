import 'dart:convert';

import 'package:equatable/equatable.dart';

class DappItem extends Equatable {
  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DappItem].
  factory DappItem.fromJson(String data) {
    return DappItem.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  factory DappItem.fromMap(Map<String, dynamic> data) => DappItem(
        dappUrl: data['dappUrl'] as String?,
        enabled: data['enabled'] as bool?,
        mostUsed: data['mostUsed'] ?? false,
      );

  const DappItem({this.dappUrl, this.enabled, this.mostUsed});
  final String? dappUrl;
  final bool? enabled;
  final bool? mostUsed;

  Map<String, dynamic> toMap() => {
        'dappUrl': dappUrl,
        'enabled': enabled,
        'mostUsed': mostUsed,
      };

  /// `dart:convert`
  ///
  /// Converts [DappItem] to a JSON string.
  String toJson() => json.encode(toMap());

  DappItem copyWith({
    String? dappUrl,
    bool? enabled,
    bool? mostUsed,
  }) {
    return DappItem(
      dappUrl: dappUrl ?? this.dappUrl,
      enabled: enabled ?? this.enabled,
      mostUsed: mostUsed ?? this.mostUsed,
    );
  }

  @override
  List<Object?> get props => [dappUrl, enabled, mostUsed];
}
