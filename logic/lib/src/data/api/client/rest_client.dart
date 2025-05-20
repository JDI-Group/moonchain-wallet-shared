import 'dart:io';
import 'package:http/http.dart';
import 'package:mxc_logic/src/domain/domain.dart';

import 'timeout_client.dart';

const BASE_URL = 'Undefined';

class RestClient {
  factory RestClient() {
    return _singleton;
  }

  RestClient._internal() {
    client = TimeoutClient(Client(), Config.httpClientTimeOut);
  }
  static final RestClient _singleton = RestClient._internal();
  late TimeoutClient client;
}
