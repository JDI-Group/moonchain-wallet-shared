class PhoenixException implements Exception {
  PhoenixException(
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

class PhoenixSocketNotInitialized extends PhoenixException {
  PhoenixSocketNotInitialized(
    Uri? url,
    Object? source, {
    int? statusCode,
  }) : super(
            url,
            'Phoenix socket not initialized, Try initializing with connect method.',
            source,
            statusCode: statusCode);
}

class PhoenixSocketNotConnected extends PhoenixException {
  PhoenixSocketNotConnected(
    Uri? url,
    Object? source, {
    int? statusCode,
  }) : super(url, 'Phoenix socket not connected', source,
            statusCode: statusCode);
}

class PhoenixSocketConnectionError extends PhoenixException {
  PhoenixSocketConnectionError(
    Uri? url,
    String message,
    Object? source, {
    int? statusCode,
  }) : super(url, message, source, statusCode: statusCode);
}
