import 'package:mxc_logic/src/data/data.dart';

class AuthenticationStorageRepository {
  AuthenticationStorageRepository(this._datadashSetupStore);

  final DatadashSetupStore _datadashSetupStore;

  String? get mnemonic => _datadashSetupStore.mnemonic;
  void saveMnemonic(String? value) => _datadashSetupStore.mnemonic = value;

  String? get privateKey => _datadashSetupStore.privateKey;
  void savePrivateKey(String? value) => _datadashSetupStore.privateKey = value;

  String? get publicAddress => _datadashSetupStore.publicAddress;
  void savePublicAddress(String? value) =>
      _datadashSetupStore.publicAddress = value;

  bool get loggedIn =>
      _datadashSetupStore.mnemonic != null &&
      _datadashSetupStore.privateKey != null;
}
