import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:eth_sig_util/util/utils.dart';
import 'package:mxc_logic/src/data/api/client/rest_client.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/data/api/client/web3_client.dart';
import 'package:ens_dart/ens_dart.dart' as contracts;
import 'package:mxc_logic/src/domain/entities/miner_list_model/mep1004_token_detail.dart';
import 'package:mxc_logic/src/domain/entities/miner_list_model/miner_list_model.dart';
import 'package:mxc_logic/src/domain/repositories/wallet/epoch.dart';
import 'package:mxc_logic/src/domain/repositories/wallet/token_contract.dart';
import 'package:web3dart/web3dart.dart';

class MinerRepository {
  MinerRepository(
      this._web3Client, this._epochRepository, this._tokenContractRepository)
      : _restClient = RestClient();

  final DatadashClient _web3Client;
  final RestClient _restClient;
  final EpochRepository _epochRepository;
  final TokenContractRepository _tokenContractRepository;

  Future<bool> claimMinersReward(
      {required List<String> selectedMinerListId,
      required Account account,
      required void Function(String title, String? text)
          showNotification}) async {
    bool ableToClaim = false;

    final minerList = await getAddressMiners(account.address);

    if (minerList.mep1004TokenDetails!.isEmpty) {
      throw 'Looks like this wallet doesn\'t own any miners.';
    }

    // TODO: get selected miner or all out of that list

    List<Mep1004TokenDetail> minersList = minerList.mep1004TokenDetails ?? [];

    final mep2542Address = Config.getContractAddress(
      MXCContacts.mep2542,
      _web3Client.network!.chainId,
    );

    final cred = EthPrivateKey.fromHex(account.privateKey);

    for (Mep1004TokenDetail miner in minersList) {
      try {
        showNotification(
          'Mining tokens from Miner #${miner.mep1004TokenId}. ⛏️',
          null,
        );
        final erc6551AccountImpl = contracts.Erc6551AccountImpl(
          client: _web3Client,
          address: EthereumAddress.fromHex(miner.erc6551Addr!),
        );

        await ensureERC6551RegistryAccount(miner, account);

        final data = await encodeFunctionByClaimRewards(miner);

        if (data == null) {
          // nothing to claim
          showNotification(
            'Miner #${miner.mep1004TokenId}: No tokens to claim. ℹ️',
            null,
          );
          continue;
        }

        final verifyMerkleProofRequest = VerifyMerkleProofRequest(
          encodeFunctionData: MXCType.uint8ListToString(
            data,
            include0x: true,
          ),
          spender: miner.erc6551Addr!,
          to: miner.erc6551Addr!,
        );

        final verifierSignatureResp =
            await verifyMerkleProof(verifyMerkleProofRequest);
        final merkleProofData = MXCType.hexToUint8List(
          verifierSignatureResp.claimEncodeFunctionData,
        );

        final params = [
          mep2542Address,
          BigInt.zero,
          merkleProofData,
        ];
        final function = _tokenContractRepository.getContractFunction(
          erc6551AccountImpl.self,
          0,
          '9e5d4c49',
        );

        final gasEstimation =
            await _tokenContractRepository.estimateGasFeeForContractCall(
          from: cred.address.hex,
          to: miner.erc6551Addr!,
          data: function.encodeCall(params),
        );
        final maxFeePerGas =
            MXCGas.addExtraFeeEtherAmount(gasEstimation.gasPrice);
        final maxGasDouble = gasEstimation.gas.toDouble() *
            Config.minerClaimTransactionGasMultiply;
        final maxGas = maxGasDouble.toInt();

        final transaction = Transaction.callContract(
          contract: erc6551AccountImpl.self,
          function: function,
          parameters: params,
          maxFeePerGas: maxFeePerGas,
          maxGas: maxGas,
          maxPriorityFeePerGas: Config.maxPriorityFeePerGas,
        );

        final tx = await _web3Client.sendTransaction(
          cred,
          transaction,
          chainId: _web3Client.network!.chainId,
        );

        ableToClaim = true;
        print('claimMinersReward : $tx');
        showNotification(
          'Miner #${miner.mep1004TokenId}: Tokens mined successfully. ✅',
          null,
        );
      } catch (e) {
        showNotification(
          'Miner #${miner.mep1004TokenId}: Token mine failed. ❌',
          e.toString(),
        );
      }
    }

    return ableToClaim;
  }

  Future<VerifyMerkleProofResponse> verifyMerkleProof(
    VerifyMerkleProofRequest verifyMerkleProofRequest,
  ) async {
    final chainId = _web3Client.network!.chainId;
    final uri = Uri.parse(Urls.postVerifyMerkleProof(chainId));
    final headers = {'accept': 'application/json'};

    final response = await _restClient.client.post(
      uri,
      headers: headers,
      body: verifyMerkleProofRequest.toMap(),
    );

    if (response.statusCode != 200) {
      throw 'Error while trying to verify Merkle proof';
    }

    final verifyMerkleProofResponse =
        VerifyMerkleProofResponse.fromJson(response.body);
    return verifyMerkleProofResponse;
  }

  Future<Uint8List?> encodeFunctionByClaimRewards(
    Mep1004TokenDetail miner,
  ) async {
    final chainId = _web3Client.network!.chainId;
    final mep2542Address = Config.getContractAddress(
      MXCContacts.mep2542,
      _web3Client.network!.chainId,
    );
    final mep2542 = contracts.MEP2542(
      client: _web3Client,
      address: mep2542Address,
    );
    final epochs =
        await _epochRepository.getEpochByPage(chainId, page: 0, pageSize: 6);

    final List<BigInt> epochIds = [];
    final List<ProofsRequestModel> proofsArray = [];
    final List<RewardsRequestModel> rewardInfoArray = [];

    final queryClaimedEpochIds = await mep2542.getMinerClaimedEpochs(
      BigInt.parse(miner.mep1004TokenId!),
      epochs.map((e) => BigInt.from(e.epoch)).toList(),
    );

    final rewardInfos = await helperGetReward(
      RewardQueryModel(
        mep1004TokenId: int.parse(miner.mep1004TokenId!),
        epochNumbers: epochs.map((item) => item.epoch).toList(),
      ),
    );

    for (var idx = 0; idx < epochs.length; idx++) {
      final epoch = epochs[idx];
      if (!rewardInfos.any((item) => item.epochNumber == epoch.epoch)) continue;

      final rewardInfo = rewardInfos[idx];
      final claimed = queryClaimedEpochIds[idx];

      if (claimed || epoch.expired) continue;

      final anyReward = rewardInfo.rewardInfoJson.amount.fold(
        BigInt.zero,
        (previousValue, element) => previousValue + element,
      );

      if (anyReward == BigInt.zero) continue;

      epochIds.insert(0, BigInt.parse(epoch.epoch.toString()));
      proofsArray.insert(0, ProofsRequestModel(proofs: rewardInfo.proofJson));
      rewardInfoArray.insert(
        0,
        RewardsRequestModel(
          amount: rewardInfo.rewardInfoJson.amount,
          token: rewardInfo.rewardInfoJson.token
              .map((e) => EthereumAddress.fromHex(e))
              .toList(),
        ),
      );
    }

    if (epochIds.isEmpty) {
      return null;
    }

    // final to = EthereumAddress.fromHex(miner.erc6551Addr!);
    // final res = await mep2542.getRewardTokenInfo();

    final function = mep2542.self.abi.functions[37];
    assert(checkSignature(function, '6a3780c4'));
    final params = [
      BigInt.parse(miner.mep1004TokenId!),
      proofsArray
          .map(
            (e) => [e.proofs.map((e) => MXCType.hexToUint8List(e)).toList()],
          )
          .toList(),
      epochIds,
      rewardInfoArray.map((e) => [e.token, e.amount]).toList(),
    ];
    return function.encodeCall(params);
  }

  bool checkSignature(ContractFunction function, String expected) {
    return bytesToHex(function.selector) == expected;
  }

  Future<List<RewardDetailsModel>> helperGetReward(
    RewardQueryModel data,
  ) async {
    final chainId = _web3Client.network!.chainId;
    final uri = Uri.parse(Urls.postMEP2542RewardInfo(chainId));
    final headers = {'accept': 'application/json'};

    final response = await _restClient.client
        .post(uri, headers: headers, body: jsonEncode(data.toMap()));

    final reward = RewardResponseModel.fromJson(response.body);
    return reward.rewardInfoDetails;
  }

  Future<void> ensureERC6551RegistryAccount(
    Mep1004TokenDetail miner,
    Account account, {
    BigInt? salt,
  }) async {
    salt = salt ?? BigInt.zero;
    final minerAddress = EthereumAddress.fromHex(miner.erc6551Addr!);
    final code = await _web3Client.getCode(minerAddress);
    final hex = MXCType.uint8ListToString(code);

    if (hex == '0x') {
      final chainId = _web3Client.network!.chainId;
      final erc6551RegistryAddress = Config.getContractAddress(
        MXCContacts.erc6551Registry,
        chainId,
      );
      final erc6551Registry = contracts.ERC6551Registry(
        client: _web3Client,
        address: erc6551RegistryAddress,
      );

      final erc6551AccountImplAddress = Config.getContractAddress(
        MXCContacts.erc6551AccountImpl,
        chainId,
      );
      final mep1004TokenAddress = Config.getContractAddress(
        MXCContacts.mep1004Token,
        chainId,
      );
      final data = MXCType.stringToUint8List('0x');
      final cred = EthPrivateKey.fromHex(account.privateKey);

      final transaction = await erc6551Registry.createAccount(
        erc6551AccountImplAddress,
        BigInt.from(chainId),
        mep1004TokenAddress,
        BigInt.parse(miner.mep1004TokenId!),
        salt,
        data,
        credentials: cred,
      );

      print('ensureERC6551RegistryAccount : $transaction');
    }
  }

  Future<MinerListModel> getAddressMiners(String address) async {
    final response = await _restClient.client.get(
      Uri.parse(
        Urls.addressMinersByChainId(_web3Client.network!.chainId, address),
      ),
      headers: {'accept': 'application/json'},
    );

    final miners = MinerListModel.fromJson(response.body);
    return miners;
  }

  Future<void> dispose() async {
    await _web3Client.dispose();
  }
}
