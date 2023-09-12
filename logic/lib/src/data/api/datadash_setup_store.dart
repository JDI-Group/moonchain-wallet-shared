import 'dart:async';

import 'package:mxc_logic/internal.dart';
import 'package:mxc_logic/mxc_logic.dart';

class DatadashSetupStore extends GlobalCacheStore {
  @override
  String get zone => 'datadash-setup';

  late final Field<String?> _mnemonic = field('mnemonic');
  late final Field<String?> _privateKey = field('private-key');
  late final Field<String?> _publicAddress = field('public-address');

  late final Field<Network?> _network = field<Network>(
    'network',
    serializer: (e) => {
      'logo': e.logo,
      'web3RpcHttpUrl': e.web3RpcHttpUrl,
      'web3RpcWebsocketUrl': e.web3RpcWebsocketUrl,
      'web3WebSocketUrl': e.web3WebSocketUrl,
      'symbol': e.symbol,
      'explorerUrl': e.explorerUrl,
      'enabled': e.enabled,
      'label': e.label,
      'chainId': e.chainId,
      'isAdded': e.isAdded,
      'networkType': e.networkType.name
    },
    deserializer: (e) => Network(
      logo: e['logo'],
      web3RpcHttpUrl: e['web3RpcHttpUrl'],
      web3RpcWebsocketUrl: e['web3RpcWebsocketUrl'],
      web3WebSocketUrl: e['web3WebSocketUrl'],
      symbol: e['symbol'],
      explorerUrl: e['explorerUrl'],
      enabled: e['enabled'],
      label: e['label'],
      chainId: e['chainId'],
      isAdded: e['isAdded'],
      networkType: NetworkType.values
          .firstWhere((element) => element.name == e['networkType']),
    ),
  );

  String? get mnemonic => _mnemonic.value;
  set mnemonic(String? value) => _mnemonic.value = value;

  String? get privateKey => _privateKey.value;
  set privateKey(String? value) => _privateKey.value = value;

  String? get publicAddress => _publicAddress.value;
  set publicAddress(String? value) => _publicAddress.value = value;

  Network? get getNetwork => _network.value;
  set network(Network value) => _network.value = value;

  Future<void> clean() => cleanFields([
        _mnemonic,
        _privateKey,
        _publicAddress,
      ]);
}
