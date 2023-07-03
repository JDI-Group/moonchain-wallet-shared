import 'dart:io';

import 'package:http/http.dart';

const BASE_URL = 'Undefined';

class RestClient {
  static final RestClient _singleton = RestClient._internal();

  factory RestClient() {
    return _singleton;
  }
  late Client client;

  RestClient._internal() {
    client = Client();
  }
}
