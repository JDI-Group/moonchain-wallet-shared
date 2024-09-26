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
    // Convert the semantic version to a comparable integer
    int latestCode = _versionToCode(latestVersion);
    int currentCode = int.parse(currentVersion);

    return latestCode > currentCode;
  }

  int _versionToCode(String version) {
    List<int> parts = version.split('.').map(int.parse).toList();
    return parts[0] * 10000 + parts[1] * 100 + parts[2];
  }
}
