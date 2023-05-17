import 'package:http/http.dart';
import 'package:http/io_client.dart';

import 'cert.dart';

Client buildClient() {
  return IOClient(createHttpClientWithCert(isrgx1));
}
