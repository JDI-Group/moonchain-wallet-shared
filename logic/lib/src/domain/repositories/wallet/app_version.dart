import 'package:http/http.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:yaml/yaml.dart';
import 'package:your_package_name/src/domain/const/urls.dart'; // Make sure to import the Urls class

class AppVersionRepository {
  AppVersionRepository(
    this._web3Client,
  ) : _restClient = _web3Client.restClient;

  final DatadashClient _web3Client;
  final Client _restClient;

  Future<bool> checkLatestVersion(String currentVersion) async {
    try {
      final res = await _restClient.get(
        Uri.parse(Urls.latestVersionYaml),
        headers: {'accept': 'text/plain'},
      ).timeout(const Duration(seconds: 10));

      if (res.statusCode != 200) {
        throw Exception('Failed to fetch version information. Status code: ${res.statusCode}');
      }

      final yamlDoc = loadYaml(res.body);
      final latestVersion = yamlDoc['version'] as String;

      print('Comparing versions - Latest: $latestVersion, Current: $currentVersion');

      return _isNewVersionAvailable(latestVersion, currentVersion);
    } catch (e) {
      print('Error checking app version: $e');
      return false;
    }
  }

  bool _isNewVersionAvailable(String latestVersion, String currentVersion) {
    List<int> latest = latestVersion.split('.').map(int.parse).toList();
    List<int> current = currentVersion.split('.').map(int.parse).toList();

    for (int i = 0; i < 3; i++) {
      if (latest[i] > current[i]) return true;
      if (latest[i] < current[i]) return false;
    }

    return false;
  }
}
