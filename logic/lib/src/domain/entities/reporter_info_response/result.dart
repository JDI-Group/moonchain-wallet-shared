import 'dart:convert';

import 'package:equatable/equatable.dart';

class Result extends Equatable {
  const Result({
    this.name,
    this.version,
    this.hash,
    this.lastReport,
    this.lastReportData,
  });

  final String? name;
  final String? version;
  final String? hash;
  final String? lastReport;
  final String? lastReportData;

  factory Result.fromMap(Map<String, Object?> data) => Result(
        name: data['name'] as String?,
        version: data['version'] as String?,
        hash: data['hash'] as String?,
        lastReport: data['lastReport'] as String?,
        lastReportData: data['lastReportData'] as String?,
      );

  Map<String, Object?> toMap() => {
        'name': name,
        'version': version,
        'hash': hash,
        'lastReport': lastReport,
        'lastReportData': lastReportData,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Result].
  factory Result.fromJson(String data) {
    return Result.fromMap(json.decode(data) as Map<String, Object?>);
  }

  /// `dart:convert`
  ///
  /// Converts [Result] to a JSON string.
  String toJson() => json.encode(toMap());

  Result copyWith({
    String? name,
    String? version,
    String? hash,
    String? lastReport,
    String? lastReportData,
  }) {
    return Result(
      name: name ?? this.name,
      version: version ?? this.version,
      hash: hash ?? this.hash,
      lastReport: lastReport ?? this.lastReport,
      lastReportData: lastReportData ?? this.lastReportData,
    );
  }

  @override
  List<Object?> get props {
    return [
      name,
      version,
      hash,
      lastReport,
      lastReportData,
    ];
  }
}
