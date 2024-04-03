import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:eth_sig_util/util/utils.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mxc_logic/src/data/api/client/rest_client.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/data/api/client/web3_client.dart';
import 'package:ens_dart/ens_dart.dart' as contracts;

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

  Future<bool> claimMinersReward({
    required List<String> selectedMinerListId,
    required Account account,
    required void Function(String title, String? text) showNotification,
    required String Function(
      String key,
    )
        translate,
  }) async {
    bool ableToClaim = false;

    // handle no mienrs
    final minerList = await getAddressMiners(account.address);

    if (minerList.mep1004TokenDetails!.isEmpty) {
      showNotification(
        translate('no_miners_owned_notification'),
        null,
      );
      return false;
    }

    // TODO: get selected miner or all out of that list

    List<Mep1004TokenDetail> minersList = minerList.mep1004TokenDetails ?? [];

    final selectedMiners = getSelectedMiners(minersList, selectedMinerListId);

    final mep2542Address = ContractAddresses.getContractAddress(
      MXCContacts.mep2542,
      _web3Client.network!.chainId,
    );

    final cred = EthPrivateKey.fromHex(account.privateKey);

    for (Mep1004TokenDetail miner in selectedMiners) {
      try {
        showNotification(
          translate('mining_tokens_from_miner')
              .replaceFirst('{0}', miner.mep1004TokenId!),
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
            translate('no_token_to_claim_miner')
                .replaceFirst('{0}', miner.mep1004TokenId!),
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
            await verifyMerkleProof(verifyMerkleProofRequest, translate);
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
          translate('tokens_mined_successfully_miner')
              .replaceFirst('{0}', miner.mep1004TokenId!),
          null,
        );
      } catch (e) {
        showNotification(
          translate('token_mining_failed')
              .replaceFirst('{0}', miner.mep1004TokenId!),
          e.toString(),
        );
      }
    }

    return ableToClaim;
  }

  Future<VerifyMerkleProofResponse> verifyMerkleProof(
      VerifyMerkleProofRequest verifyMerkleProofRequest,
      String Function(
    String key,
  )
          translate) async {
    final chainId = _web3Client.network!.chainId;
    final uri = Uri.parse(Urls.postVerifyMerkleProof(chainId));
    final headers = {'accept': 'application/json'};

    final response = await _restClient.client.post(
      uri,
      headers: headers,
      body: verifyMerkleProofRequest.toMap(),
    );

    if (response.statusCode != 200) {
      throw translate('merkle_proof_error');
    }

    final verifyMerkleProofResponse =
        VerifyMerkleProofResponse.fromJson(response.body);
    return verifyMerkleProofResponse;
  }

  Future<Uint8List?> encodeFunctionByClaimRewards(
    Mep1004TokenDetail miner,
  ) async {
    final chainId = _web3Client.network!.chainId;
    final mep2542Address = ContractAddresses.getContractAddress(
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
      final erc6551RegistryAddress = ContractAddresses.getContractAddress(
        MXCContacts.erc6551Registry,
        chainId,
      );
      final erc6551Registry = contracts.ERC6551Registry(
        client: _web3Client,
        address: erc6551RegistryAddress,
      );

      final erc6551AccountImplAddress = ContractAddresses.getContractAddress(
        MXCContacts.erc6551AccountImpl,
        chainId,
      );
      final mep1004TokenAddress = ContractAddresses.getContractAddress(
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

  List<Mep1004TokenDetail> getSelectedMiners(
    List<Mep1004TokenDetail> minersList,
    List<String> selectedMiners,
  ) =>
      minersList
          .where((element) => selectedMiners.contains(element.mep1004TokenId))
          .toList();

  Future<List<ClaimEarn>> helperGetClaimRewards(
    GetClaimRewardsQuery query,
  ) async {
    final QueryOptions options = QueryOptions(
      document: gql(
        queryClaimedRewards(
          query.type,
          query.miners?.map((v) => v.mep1004TokenId!).toList() ?? [],
        ),
      ),
    );
    final QueryResult result = await _web3Client.graphQLClient.query(options);

    if (result.data == null) {
      return [];
    }

    final List<ClaimReward> rewards =
        (result.data?['claimedRewards'] as List<dynamic>)
            .map((v) => ClaimReward.fromMap(v))
            .toList();
    rewards.sort(
      (a, b) => int.parse(a.blockTimestamp) - int.parse(b.blockTimestamp),
    );

    if (rewards.isEmpty) {
      return [];
    }

    final fast = DateTime.fromMillisecondsSinceEpoch(
      int.parse(rewards[0].blockTimestamp) * 1000,
    );
    // final dayjs.DayJs fast = dayjs.unix(int.parse(rewards[0].blockTimestamp));

    final last = DateTime.now();
    // final dayjs.DayJs last = dayjs();

    final int days =
        ((last.millisecondsSinceEpoch - fast.millisecondsSinceEpoch) / 86400000)
            .ceil();

    final List<ClaimEarn> stats = [];

    for (int day = 0; day < days; day++) {
      final times = fast.add(Duration(days: fast.day + day));

      final int start = times.copyWith(day: 0, minute: 0, second: 0).unix();
      // final int start = times.hour(0).minute(0).second(0).unix();

      final int ended = times.copyWith(day: 23, minute: 59, second: 59).unix();
      // final int ended = times.hour(23).minute(59).second(59).unix();

      final List<ClaimReward> rewardsByDay = rewards
          .where((r) =>
              int.parse(r.blockTimestamp) > start &&
              int.parse(r.blockTimestamp) < ended)
          .toList();
      final String fee = MXCArray.sumUpListItemsValueBigInt([
        ...rewardsByDay.map((r) => r.feeMXC),
        stats.isNotEmpty ? stats[stats.length - 1].fee : ''
      ]);
      final String mxc = MXCArray.sumUpListItemsValueBigInt([
        ...rewardsByDay.map((r) => r.valueMXC),
        stats.isNotEmpty ? stats[stats.length - 1].mxc : ''
      ]);
      final List<String> ids =
          rewardsByDay.map((r) => r.mep1004TokenId).toList();
      stats.add(ClaimEarn(timestamp: start, fee: fee, ids: ids, mxc: mxc));
    }

    return stats;
  }

  Future<GetTotalClaimResponse> helperGetClaimTotal(
    GetClaimTotalQuery query,
    String address,
    List<String> miners,
  ) async {
    final queryType = query.type ?? 'total';

    final QueryOptions options = QueryOptions(
      document: gql(
        queryClaimTotal(
          queryType,
          miners,
        ),
      ),
    );
    final QueryResult result = await _web3Client.graphQLClient.query(options);

    if (result.data == null) {
      return GetTotalClaimResponse(totalMXC: '0', totalFee: '0');
    }

    final List<ClaimReward> rewards =
        (result.data![mep1004TokenRewardKeys[queryType]] as List<dynamic>)
            .map((e) => ClaimReward.fromMap(e as Map<String, dynamic>))
            .toList();

    final mxc = MXCArray.sumUpListItemsValueBigInt(
        rewards.map((r) => r.valueMXC).toList());
    final fee = MXCArray.sumUpListItemsValueBigInt(
        rewards.map((r) => r.feeMXC).toList());

    return GetTotalClaimResponse(totalMXC: mxc, totalFee: fee);
  }

  void getExpirationDurationForEpoch() async {
    final chainId = _web3Client.network!.chainId;
    final mep2542Address = ContractAddresses.getContractAddress(
      MXCContacts.mep2542,
      chainId,
    );

    final mep2542 = contracts.MEP2542(
      client: _web3Client,
      address: mep2542Address,
    );

    final currentEpoch = await mep2542.currentEpoch();
    final epochReleaseTimeBigInt = await mep2542.epochReleaseTime(currentEpoch);
    final epochReleaseTime =
        DateTimeExtension.fromUnixBigInt(epochReleaseTimeBigInt);
    final epochExpirationTime = epochReleaseTime.add(const Duration(hours: 4));
    final now = DateTime.now();
    final nextEpochDuration = epochExpirationTime.difference(now);
    if (nextEpochDuration.isNegative) {
      // time past
    } else {
      // time left
      // return nextEpochDuration;
    }
  }
}
