import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'result.dart';

class ReporterInfoResponse extends Equatable {

  factory ReporterInfoResponse.fromMap(Map<String, Object?> data) {
    return ReporterInfoResponse(
      ret: data['ret'] as int?,
      message: data['message'] as String?,
      result: data['result'] == null
          ? null
          : Result.fromMap(data['result']! as Map<String, Object?>),
    );
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ReporterInfoResponse].
  factory ReporterInfoResponse.fromJson(String data) {
    return ReporterInfoResponse.fromMap(
        json.decode(data) as Map<String, Object?>);
  }
  const ReporterInfoResponse({this.ret, this.message, this.result});

  final int? ret;
  final String? message;
  final Result? result;

  Map<String, Object?> toMap() => {
        'ret': ret,
        'message': message,
        'result': result?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Converts [ReporterInfoResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  ReporterInfoResponse copyWith({
    int? ret,
    String? message,
    Result? result,
  }) {
    return ReporterInfoResponse(
      ret: ret ?? this.ret,
      message: message ?? this.message,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [ret, message, result];
}
