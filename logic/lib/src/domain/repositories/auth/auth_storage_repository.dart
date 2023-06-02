import 'package:mxc_logic/src/data/data.dart';

class AuthenticationStorageRepository {
  AuthenticationStorageRepository(this._userSetupStore);

  final UserSetupStore _userSetupStore;

  String? get mnemonic => _userSetupStore.mnemonic;
  void saveMnemonic(String? value) => _userSetupStore.mnemonic = value;

  String? get privateKey => _userSetupStore.privateKey;
  void savePrivateKey(String? value) => _userSetupStore.privateKey = value;

  bool get loggedIn =>
      _userSetupStore.mnemonic != null && _userSetupStore.privateKey != null;
}
