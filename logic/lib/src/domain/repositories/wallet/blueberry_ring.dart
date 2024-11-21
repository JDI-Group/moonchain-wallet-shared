import 'dart:async';
import 'package:http/http.dart';
import 'package:mxc_logic/src/data/api/client/rest_client.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/data/api/client/web3_client.dart';
import 'package:ens_dart/ens_dart.dart' as contracts;
import 'package:web3dart/crypto.dart';


class BlueberryRingRepository {
  BlueberryRingRepository(
    this._web3Client,
  ) : _restClient = RestClient().client;

  final DatadashClient _web3Client;
  final Client _restClient;

  Future<String> sendSyncTransaction(String privateKey, BlueberryRingMiner ring,
      PostClaimResponseModel postClaimResponse, String memo,) async {
    final cred = EthPrivateKey.fromHex(privateKey);

    final doitDeviceAddress = ContractAddresses.getContractAddress(
      MXCContacts.doitDevice,
      _web3Client.network!.chainId,
    );

    final healthAddress = ContractAddresses.getContractAddress(
      MXCContacts.health,
      _web3Client.network!.chainId,
    );

    final doitDeviceContract = contracts.DoitRINGDevice(
      address: doitDeviceAddress,
      client: _web3Client,
      chainId: _web3Client.network!.chainId,
    );

    final signature = await doitDeviceContract.claimInSender(
      postClaimResponse.uid,
      ring.sncode,
      [
        {
          'token': healthAddress,
          'amount': postClaimResponse.amount,
        }
      ],
      hexToBytes(postClaimResponse.signature),
      memo,
      credentials: cred,
    );

    return signature;
  }

  Future<PostClaimResponseModel> postClaim(
      PostClaimRequestModel requestData,) async {
    print('postClaim:requestData : $requestData');
    final chainId = _web3Client.network!.chainId;
    final response = await _restClient.post(
      Uri.parse(
        Urls.getBlueberryRingDapp(chainId) + Urls.blueberryRingDappClaim,
      ),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: requestData.toJson(),
    );

    print('postClaim:response.body : ${response.body}');
    print('postClaim:response.bodyBytes : ${response.bodyBytes}');
    final responseData = PostClaimResponseModel.fromJson(response.body);
    print('postClaim:responseData : ${responseData.toString}');
    return responseData;
  }
}
