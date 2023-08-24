import 'dart:convert';

import 'package:equatable/equatable.dart';

class Store extends Equatable {
	final String? mnsid;
	final String? category;
	final String? chainid;

	const Store({this.mnsid, this.category, this.chainid});

	factory Store.fromMap(Map<String, dynamic> data) => Store(
				mnsid: data['mnsid'] as String?,
				category: data['category'] as String?,
				chainid: data['chainid'] as String?,
			);

	Map<String, dynamic> toMap() => {
				'mnsid': mnsid,
				'category': category,
				'chainid': chainid,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Store].
	factory Store.fromJson(String data) {
		return Store.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Store] to a JSON string.
	String toJson() => json.encode(toMap());

	Store copyWith({
		String? mnsid,
		String? category,
		String? chainid,
	}) {
		return Store(
			mnsid: mnsid ?? this.mnsid,
			category: category ?? this.category,
			chainid: chainid ?? this.chainid,
		);
	}

	@override
	bool get stringify => true;

	@override
	List<Object?> get props => [mnsid, category, chainid];
}
