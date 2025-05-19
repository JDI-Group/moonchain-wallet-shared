
import 'dart:io';
import 'package:http/http.dart';

const BASE_URL = 'Undefined';

class RestClient {

  factory RestClient() {
    return _singleton;
  }

  RestClient._internal() {
    client = HttpClient();
    client.connectionTimeout = const Duration(seconds: 30);
  }
  static final RestClient _singleton = RestClient._internal();
  late HttpClient client;
}
