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
import 'package:web3dart/web3dart.dart';

class MinerRepository {
  MinerRepository(
    this._web3Client,
    this._epochRepository,
  ) : _restClient = RestClient();

  final DatadashClient _web3Client;
  final RestClient _restClient;
  final EpochRepository _epochRepository;

  Future<bool> claimMinersReward({
    required List<String> selectedMinerListId,
    required Account account,
  }) async {
    bool ableToClaim = false;

    final minerList = await getAddressMiners(account.address);

    if (minerList.mep1004TokenDetails!.isEmpty) {
      throw 'Looks like this wallet doesn\'t own any miners.';
    }

    // TODO: get selected miner or all out of that list

    // List<Mep1004TokenDetail> minersList = minerList.mep1004TokenDetails == null
    //     ? []
    //     : minerList.mep1004TokenDetails!
    //         .where((e) => selectedMinerListId.contains(e.mep1004TokenId))
    //         .toList();
    List<Mep1004TokenDetail> minersList = minerList.mep1004TokenDetails ?? [];

    final mep2542Address = Config.getContractAddress(
      MXCContacts.mep2542,
      _web3Client.network!.chainId,
    );

    final cred = EthPrivateKey.fromHex(account.privateKey);

    for (Mep1004TokenDetail miner in minersList) {
      final erc6551AccountImpl = contracts.Erc6551AccountImpl(
        client: _web3Client,
        address: EthereumAddress.fromHex(miner.erc6551Addr!),
      );

      await ensureERC6551RegistryAccount(miner, account);

      final data = await encodeFunctionByClaimRewards(miner);

      if (data == null) {
        // nothing to claim
        continue;
      }

      final tx = await erc6551AccountImpl.executeCall(
        mep2542Address,
        BigInt.zero,
        data,
        credentials: cred,
      );
      ableToClaim = true;
      print('claimMinersReward : $tx');
    }

    return ableToClaim;
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

      // final rewardInfoData =
      //     jsonDecode(rewardInfo.rewardInfoJson) as Map<String, dynamic>;
      // final proofs = jsonDecode(rewardInfo.proofJson) as List<String>;

      final anyReward = rewardInfo.rewardInfoJson.amount.fold(
        BigInt.zero,
        (previousValue, element) => previousValue + element,
      );
      // final anyReward = rewardInfoData['Amount']
      //     .map((item) => BigInt.parse(item.toString()))
      //     .fold(
      //       BigInt.zero,
      //       (prev, curr) => prev.add(curr),
      //     );

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

    final to = EthereumAddress.fromHex(miner.erc6551Addr!);

    final function = mep2542.self.abi.functions[7];
    assert(checkSignature(function, '89c64b7d'));
    final params = [
      BigInt.parse(miner.mep1004TokenId!),
      to,
      proofsArray,
      epochIds,
      rewardInfoArray,
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
