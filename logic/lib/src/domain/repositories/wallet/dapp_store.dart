import 'dart:io';

import 'package:http/http.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/data/api/client/web3_client.dart';
import 'package:mxc_logic/src/domain/const/urls.dart';

class DappStoreRepository {
  DappStoreRepository(
    this._web3Client,
  ) : _restClient = _web3Client.restClient;

  final DatadashClient _web3Client;
  final Client _restClient;

  Future<List<DappItem>?> list() async {
    final res = await _restClient.get(
      Uri.parse(
        '${Urls.dappStore}?rad=${DateTime.now().microsecondsSinceEpoch}',
      ),
      headers: {'accept': 'application/json'},
    );

    final dapps =
        DappStore.fromJson(res.body).dapps!.where((e) => e.enabled!).toList();

    return dapps;
  }

  Future<List<Dapp>> getAllDapps() async {
    final list = await this.list();

    List<Dapp> res = [];

    for (int i = 0; i < list!.length; i++) {
      final response = await _restClient.get(
        Uri.parse(
          '${Urls.dapp}/${list[i].dappUrl}?rad=${DateTime.now().microsecondsSinceEpoch}',
        ),
        headers: {'accept': 'application/json'},
      );

      final data = Dapp.fromJson(response.body);
      if (Platform.isAndroid) {
        final supported = data.app!.supportedPlatforms!
            .any((e) => (e as String).toLowerCase() == 'android');
        if (supported) {
          res.add(data);
        }
      } else {
        final supported = data.app!.supportedPlatforms!
            .any((e) => (e as String).toLowerCase() == 'ios');
        if (supported) {
          res.add(data);
        }
      }
    }

    res.sort((a, b) => b.reviewApi!.icons!.islarge
        .toString()
        .compareTo(a.reviewApi!.icons!.islarge.toString()));

    return res;
  }
}
