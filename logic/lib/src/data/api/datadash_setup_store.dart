import 'dart:async';

import 'package:mxc_logic/internal.dart';
import 'package:mxc_logic/mxc_logic.dart';

class DatadashSetupStore extends GlobalCacheStore {
  @override
  String get zone => 'datadash-setup';

  late final Field<String?> _mnemonic = field('mnemonic');
  late final Field<String?> _privateKey = field('private-key');
  late final Field<String?> _publicAddress = field('public-address');

  late final Field<String?> _web3RpcHttpUrl = field('web3-rpc-http-urlb');
  late final Field<String?> _web3RpcWebsocketUrl =
      field('web3-rpc-websocket-url');

  String? get mnemonic => _mnemonic.value;
  set mnemonic(String? value) => _mnemonic.value = value;

  String? get privateKey => _privateKey.value;
  set privateKey(String? value) => _privateKey.value = value;

  String? get publicAddress => _publicAddress.value;
  set publicAddress(String? value) => _publicAddress.value = value;

  String? get web3RpcHttpUrl => _web3RpcHttpUrl.value;
  set web3RpcHttpUrl(String? value) => _web3RpcHttpUrl.value = value;

  String? get web3RpcWebsocketUrl => _web3RpcWebsocketUrl.value;
  set web3RpcWebsocketUrl(String? value) => _web3RpcWebsocketUrl.value = value;

  Future<void> clean() => cleanFields([
        _mnemonic,
        _privateKey,
        _publicAddress,
      ]);
}
