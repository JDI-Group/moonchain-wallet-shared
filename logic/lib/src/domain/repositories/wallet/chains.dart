import 'dart:async';
import 'package:http/http.dart';
import 'package:mxc_logic/src/data/api/client/rest_client.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/domain/const/const.dart';
import 'package:mxc_logic/src/domain/entities/chains_rpc_list/chains_rpc_list.dart';
import 'package:web3dart/web3dart.dart';

class ChainsRepository {
  ChainsRepository(
    this._web3Client,
  ) : _restClient = RestClient();

  final Web3Client _web3Client;
  final RestClient _restClient;

  Future<ChainsRpcList> getChainsRpcUrls() async {
    final response = await _restClient.client.get(
      Uri.parse(
        Urls.chainsRpcList,
      ),
      headers: {'accept': 'application/json'},
    );

    final chainsRpcUrls = ChainsRpcList.fromJson(response.body);
    return chainsRpcUrls;
  }

  /// This is used for checking If the http rpc urls is working or not
  // Future<int> getBlockNumber(String url) async {
  //   Web3Client(
  //     url,
  //     Client(),
  //   );
  //   return await _web3Client.getBlockNumber();
  // }
}
