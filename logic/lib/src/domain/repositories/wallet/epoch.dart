import 'dart:async';
import 'package:ens_dart/ens_dart.dart' as contracts;
import 'package:mxc_logic/src/data/api/client/rest_client.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/data/api/client/web3_client.dart';
import 'package:web3dart/web3dart.dart';

class EpochRepository {
  EpochRepository(
    this._web3Client,
  ) : _restClient = RestClient();

  final DatadashClient _web3Client;
  final RestClient _restClient;

  Future<List<EpochModel>> getEpochByPage(
    int chainId, {
    int page = 0,
    int pageSize = 1,
  }) async {
    final offset = page * pageSize;
    final List<EpochModel> data = <EpochModel>[];

    final epoch = await getEpochByReleaseTime();
    final mep2542Address = Config.getContractAddress(
      MXCContacts.mep2542,
      _web3Client.network!.chainId,
    );
    final mep2542 = contracts.MEP2542(
      client: _web3Client,
      address: mep2542Address,
    );

    const List<Future<BigInt>> epochReleaseTimeTask = [];
    for (var i = 0; i < pageSize; i++) {
      final epochNumber = epoch.epoch.toInt();
      final number = epochNumber - offset - i;
      if (number <= 0) break;
      final task = mep2542.epochReleaseTime(BigInt.from(number));
      epochReleaseTimeTask.add(task);
    }
    if (epochReleaseTimeTask.isEmpty) return [];
    final epochReleaseTimes = await Future.wait(epochReleaseTimeTask);

    for (var i = 0; i < pageSize; i++) {
      final epochNumber = epoch.epoch.toInt();
      final id = epochNumber - offset - i;
      if (id <= 0) break;
      final epochReleaseTime = epochReleaseTimes[i];
      final expired = DateTime.now().millisecondsSinceEpoch ~/ 1000 -
              epochReleaseTime.toInt() >
          3600 * 24;

      data.add(EpochModel(
        epochReleaseTime: epochReleaseTime,
        id: id,
        epoch: id,
        expired: expired,
      ));
    }

    return data;
  }

  Future<EpochByReleaseTimeModel> getEpochByReleaseTime() async {
    final mep2542Address = Config.getContractAddress(
      MXCContacts.mep2542,
      _web3Client.network!.chainId,
    );
    final mep2542 = contracts.MEP2542(
      client: _web3Client,
      address: mep2542Address,
    );

    final epoch = await mep2542.currentEpoch();
    final epochReleaseTime = await mep2542.epochReleaseTime(epoch);
    return EpochByReleaseTimeModel(
      epoch: epoch,
      epochReleaseTime: epochReleaseTime,
    );
  }
}
