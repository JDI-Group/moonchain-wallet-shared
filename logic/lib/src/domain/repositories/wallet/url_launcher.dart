import 'package:http/http.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/data/api/client/web3_client.dart';

class LauncherRepository {
  LauncherRepository(
    this._web3Client,
  ) : _restClient = _web3Client.restClient;

  final DatadashClient _web3Client;
  final Client _restClient;

  String? getNftMarketPlaceUrl() =>
      MXCFunctionHelpers.mxcChainsFuncWrapperNullable<String>(
        () {
          return Urls.getMXCNftMarketPlace(_web3Client.network!.chainId);
        },
        _web3Client.network!.chainId,
      );
}
