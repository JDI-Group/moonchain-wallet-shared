import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:meta/meta.dart';

void _addAuthHeader(
  Map<String, String> map,
  String value, {
  bool override = false,
}) {
  const headerName = 'Grpc-Metadata-Authorization';
  if (override) {
    map[headerName] = 'Bearer $value';
  } else {
    map[headerName] ??= 'Bearer $value';
  }
}

@immutable
class TokenInterceptor implements RequestInterceptor {
  const TokenInterceptor({
    required this.getToken,
  });

  final String? Function() getToken;

  @override
  Future<Request> onRequest(Request request) async {
    final token = getToken();
    if (token != null) {
      final headers = {...request.headers};
      _addAuthHeader(headers, token);
      return request.copyWith(headers: headers);
    }
    return request;
  }
}
