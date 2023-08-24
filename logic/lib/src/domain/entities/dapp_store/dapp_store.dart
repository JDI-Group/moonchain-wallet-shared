import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'dapp_item.dart';

class DappStore extends Equatable {

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DappStore].
	factory DappStore.fromJson(String data) {
		return DappStore.fromMap(json.decode(data) as Map<String, dynamic>);
	}

	factory DappStore.fromMap(Map<String, dynamic> data) => DappStore(
				name: data['name'] as String?,
				dapps: (data['dapps'] as List<dynamic>?)
						?.map((e) => DappItem.fromMap(e as Map<String, dynamic>))
						.toList(),
			);

	const DappStore({this.name, this.dapps});
	final String? name;
	final List<DappItem>? dapps;

	Map<String, dynamic> toMap() => {
				'name': name,
				'dapps': dapps?.map((e) => e.toMap()).toList(),
			};
  /// `dart:convert`
  ///
  /// Converts [DappStore] to a JSON string.
	String toJson() => json.encode(toMap());

	DappStore copyWith({
		String? name,
		List<DappItem>? dapps,
	}) {
		return DappStore(
			name: name ?? this.name,
			dapps: dapps ?? this.dapps,
		);
	}

	@override
	List<Object?> get props => [name, dapps];
}
