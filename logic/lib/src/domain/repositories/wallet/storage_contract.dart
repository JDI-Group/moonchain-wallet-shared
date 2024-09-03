import 'dart:async';

import 'package:ens_dart/ens_dart.dart' as contracts;
import 'package:mxc_logic/src/data/api/client/rest_client.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/data/api/client/web3_client.dart';


class StorageContractRepository {
  StorageContractRepository(
    this._web3Client,
  ) : _restClient = RestClient();

  final DatadashClient _web3Client;
  final RestClient _restClient;

  EthPrivateKey getCredentials(String privateKey) =>
      EthPrivateKey.fromHex(privateKey);

  Future<String> getMinerAvatar(int tokenId) async {
    final chainId = _web3Client.network!.chainId;
    final storageAddress = ContractAddresses.getContractAddress(
      MXCContacts.storage,
      chainId,
    );

    final storageContract =
        contracts.Storage(client: _web3Client, address: storageAddress);
    final avatar = await storageContract.getItem('mep1004_$tokenId', 'avatar');

    return avatar;
  }

  Future<void> dispose() async {
    await _web3Client.dispose();
  }
}
