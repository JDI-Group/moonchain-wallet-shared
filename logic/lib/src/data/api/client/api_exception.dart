class ApiException implements Exception {
  ApiException(
    this.url,
    this.message,
    this.source, {
    this.statusCode,
  });

  final Uri? url;
  final String message;
  final Object? source;
  final int? statusCode;

  @override
  String toString() => '$message for $url';
}

class TokenExpiredException extends ApiException {
  TokenExpiredException(
    Uri? url,
    String message,
    Object? source, {
    int? statusCode,
  }) : super(url, message, source, statusCode: statusCode);
}
