import 'package:http/http.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/data/api/client/web3_client.dart';
import 'package:mxc_logic/src/domain/const/urls.dart';

class AppVersionRepository {
  AppVersionRepository(
    this._web3Client,
  ) : _restClient = _web3Client.restClient;

  final DatadashClient _web3Client;
  final Client _restClient;

  Future<bool> checkLatestVersion(
    String appSecret,
    String groupId,
    String appVersion,
  ) async {
    final res = await _restClient.get(
      Uri.parse(
        Urls.getLatestVersion(appSecret, groupId),
      ),
      headers: {'accept': 'application/json'},
    );

    final app = AppVersion.fromJson(res.body);
    final latestVersion = int.parse(app.version!);
    final currentVersion = int.parse(appVersion);

    return latestVersion > currentVersion;
  }
}
