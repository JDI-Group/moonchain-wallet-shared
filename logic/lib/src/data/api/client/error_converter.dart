import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';

import 'api_exception.dart';

class ChopperErrorConverter extends ErrorConverter {
  final StreamController<void> _onTokenExpired = StreamController.broadcast();
  Stream<void> get onTokenExpired => _onTokenExpired.stream;

  bool tokenExpired(Response response) =>
      response.statusCode == 401 &&
      (response.bodyString.contains(
            'authentication failed: invalid authorization header',
          ) ||
          response.bodyString
              .contains('authentication failed: token does not exist') ||
          response.bodyString
              .contains('not authenticated: token does not exist'));

  @override
  FutureOr<Response> convertError<BodyType, InnerType>(Response response) {
    Object? error;
    try {
      error = jsonDecode(response.bodyString);
    } on FormatException {
      error = null;
    }

    if (tokenExpired(response)) {
      _onTokenExpired.add(null);
      if (error is Map<String, dynamic>) {
        final tokenExpiredException = TokenExpiredException(
          response.base.request?.url,
          (error['message'] ?? error['error'] ?? 'Unknown error') as String,
          error,
          statusCode: response.statusCode,
        );
        throw tokenExpiredException;
      }
    }
    if (error is Map<String, dynamic>) {
      final exception = ApiException(
        response.base.request?.url,
        (error['message'] ?? error['error'] ?? 'Unknown error') as String,
        error,
        statusCode: response.statusCode,
      );
      throw exception;
    }
    if (response.statusCode == 404) {
      throw ApiException(
        response.base.request?.url,
        'Resource not found.',
        error,
        statusCode: response.statusCode,
      );
    }
    throw ApiException(
      response.base.request?.url,
      'Unknown error. ${response.bodyString}',
      error,
      statusCode: response.statusCode,
    );
  }
}
