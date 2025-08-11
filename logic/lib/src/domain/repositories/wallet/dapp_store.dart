import 'package:http/http.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/data/api/client/web3_client.dart';

class DappStoreRepository {
  DappStoreRepository(
    this._web3Client,
  ) : _restClient = _web3Client.restClient;

  final DatadashClient _web3Client;
  final Client _restClient;

  Future<List<DappItem>> list() async {
    final dapps = await MXCFunctionHelpers.apiDataHandler<List<DappItem>>(
      apiCall: () => _restClient.get(
        Uri.parse(
          '${Urls.dappStore}?rad=${DateTime.now().microsecondsSinceEpoch}',
        ),
        headers: {'accept': 'application/json'},
      ),
      dataParseFunction: (data) =>
          DappStore.fromJson(data).dapps!.where((e) => e.enabled!).toList(),
      handleFailure: () async {
        final storeJson = await MXCFileHelpers.getDAppStoreJson();

        return DappStore.fromJson(storeJson)
            .dapps!
            .where((e) => e.enabled!)
            .toList();
      },
    );
    return dapps;
  }

  getAllDappsFromLocal() async {
    final storeJson = await MXCFileHelpers.getDAppStoreJson();

    final list =
        DappStore.fromJson(storeJson).dapps!.where((e) => e.enabled!).toList();

    List<Dapp> res = [];

    for (int i = 0; i < list.length; i++) {
      final data = await MXCFileHelpers.getDAppJson(list[i].dappUrl!);
      final dapp = Dapp.fromJson(data);
      final finalDApp = dapp.appendPrefixToIcons(Assets.dappStorePath);
      res.add(finalDApp);
    }


    return res;
  }

  Future<List<Dapp>> getAllDapps() async {
    final list = await this.list();

    List<Dapp> res = [];

    for (int i = 0; i < list.length; i++) {
      final data = await MXCFunctionHelpers.apiDataHandler<Dapp>(
        apiCall: () => _restClient.get(
          Uri.parse(
            '${Urls.dapp}/${list[i].dappUrl}?rad=${DateTime.now().microsecondsSinceEpoch}',
          ),
          headers: {'accept': 'application/json'},
        ),
        dataParseFunction: (data) {
          final dapp = Dapp.fromJson(data);
          return dapp.appendPrefixToIcons(Urls.dappRoot);
        },
        handleFailure: () async {
          final dappJson = await MXCFileHelpers.getDAppJson(list[i].dappUrl!);
          final dapp = Dapp.fromJson(dappJson);
          return dapp.appendPrefixToIcons(Assets.dappStorePath);
        },
      );

      res.add(data);
    }

    return res;
  }
}
