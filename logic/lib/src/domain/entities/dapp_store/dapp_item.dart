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
			);

	const DappItem({this.dappUrl, this.enabled});
	final String? dappUrl;
	final bool? enabled;

	Map<String, dynamic> toMap() => {
				'dappUrl': dappUrl,
				'enabled': enabled,
			};
  /// `dart:convert`
  ///
  /// Converts [DappItem] to a JSON string.
	String toJson() => json.encode(toMap());

	DappItem copyWith({
		String? dappUrl,
		bool? enabled,
	}) {
		return DappItem(
			dappUrl: dappUrl ?? this.dappUrl,
			enabled: enabled ?? this.enabled,
		);
	}

	@override
	List<Object?> get props => [dappUrl, enabled];
}
