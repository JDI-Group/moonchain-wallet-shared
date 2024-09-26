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

  Future<bool> checkLatestVersion(String appVersion) async {
    try {
      final res = await _restClient.get(
        Uri.parse(Urls.latestVersionYaml),
        headers: {'accept': 'text/plain'},
      ).timeout(const Duration(seconds: 10));

      if (res.statusCode != 200) {
        throw Exception('Failed to fetch version information. Status code: ${res.statusCode}');
      }

      print('YAML content: ${res.body}'); // Debug log

      final yamlDoc = loadYaml(res.body);
      print('Parsed YAML: $yamlDoc'); // Debug log

      final latestVersion = yamlDoc['version'] as String;
      print('Latest version: $latestVersion'); // Debug log

      return _isNewVersionAvailable(latestVersion, appVersion);
    } catch (e) {
      print('Error checking app version: $e');
      return false;
    }
  }

  bool _isNewVersionAvailable(String latestVersion, String currentVersion) {
    print('Comparing versions - Latest: $latestVersion, Current: $currentVersion'); // Debug log
    final latest = latestVersion.split('.').map(int.parse).toList();
    final current = currentVersion.split('.').map(int.parse).toList();

    for (int i = 0; i < 3; i++) {
      if (latest[i] > current[i]) return true;
      if (latest[i] < current[i]) return false;
    }

    return false;
  }
}
