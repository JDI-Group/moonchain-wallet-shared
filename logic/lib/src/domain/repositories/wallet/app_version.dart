import 'package:http/http.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:yaml/yaml.dart';
import 'package:mxc_logic/src/data/api/client/web3_client.dart';
import 'package:mxc_logic/src/domain/const/urls.dart';

class AppVersionRepository {
  AppVersionRepository(
    this._web3Client,
  ) : _restClient = _web3Client.restClient;

  final DatadashClient _web3Client;
  final Client _restClient;

  Future<bool> checkLatestVersion(String appVersion) async {
    final res = await _restClient.get(
      Uri.parse(Urls.latestVersionYaml),
      headers: {'accept': 'text/plain'},
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to fetch version information');
    }

    final yamlDoc = loadYaml(res.body);
    final latestVersion = yamlDoc['version'] as String;

    return _isNewVersionAvailable(latestVersion, appVersion);
  }

  bool _isNewVersionAvailable(String latestVersion, String currentVersion) {
    final latest = latestVersion.split('.').map(int.parse).toList();
    final current = currentVersion.split('.').map(int.parse).toList();

    for (int i = 0; i < 3; i++) {
      if (latest[i] > current[i]) return true;
      if (latest[i] < current[i]) return false;
    }

    return false;
  }
}
