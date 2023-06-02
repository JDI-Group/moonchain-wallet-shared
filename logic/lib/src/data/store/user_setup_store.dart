import 'dart:async';

import 'package:mxc_logic/internal.dart';
import 'package:mxc_logic/mxc_logic.dart';

class UserSetupStore extends GlobalCacheStore {
  @override
  String get zone => 'wallet-user-setup';

  late final Field<String?> _mnemonic = field('mnemonic');
  late final Field<String?> _privateKey = field('privateKey');

  String? get mnemonic => _mnemonic.value;
  set mnemonic(String? mnemonic) => _mnemonic.value = mnemonic;

  String? get privateKey => _privateKey.value;
  set privateKey(String? value) => _privateKey.value = value;

  Future<void> clean() => cleanFields([
        _mnemonic,
        _privateKey,
      ]);
}
