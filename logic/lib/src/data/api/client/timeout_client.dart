import 'package:http/http.dart';

class TimeoutClient extends BaseClient {
  TimeoutClient(this._inner, this._timeout);

  final Client _inner;
  final Duration _timeout;

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    return _inner.send(request).timeout(_timeout);
  }
}
