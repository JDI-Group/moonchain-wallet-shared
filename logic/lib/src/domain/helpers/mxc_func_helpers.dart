import 'package:http/http.dart';

class MXCFunctionHelpers {
  /// This function will have a return data for sure. If the api call doesn't succeed, handleFailure will return data.
  static Future<T> apiDataHandler<T>({
    required Future<Response> Function() apiCall,
    required T Function(String data) dataParseFunction,
    required Future<T> Function() handleFailure,
  }) async {
    final res = await apiCall();

    if (res.statusCode == 200) {
      return dataParseFunction(res.body);
    }
    return handleFailure();
  }
}
