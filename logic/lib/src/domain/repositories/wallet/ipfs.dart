import 'package:http/http.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/';

class IPFSRepository {
  IPFSRepository(
    this._web3Client,
  ) : _restClient = _web3Client.restClient;

  final DatadashClient _web3Client;
  final Client _restClient;

  Future<DefaultIpfsGateways?> getDefaultIpfsGateways() {
    
  }

  Future<DefaultIpfsGateways?> getDefaultIpfsGateways() async {
    final response = await _restClient.get(
      Uri.parse(
        Urls.defaultIpfsGateway,
      ),
      headers: {'accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final defaultIpfsGateways = DefaultIpfsGateways.fromJson(response.body);
      return defaultIpfsGateways;
    } else {
      return null;
    }
  }

  Future<bool> checkIpfsGateway(String url) async {
    try {
      final response = await _restClient.get(
        Uri.parse(
          url + Const.hashToTest,
        ),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
