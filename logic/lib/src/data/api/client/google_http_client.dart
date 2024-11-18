import 'package:http/http.dart' as http;

class GoogleHttpClient extends http.BaseClient {

  GoogleHttpClient(this.headers);
  final Map<String, String> headers;

  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _inner.send(request..headers.addAll(headers));
  }

  @override
  void close() {
    _inner.close();
  }
}