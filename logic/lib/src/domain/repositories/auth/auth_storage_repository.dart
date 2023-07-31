import 'package:mxc_logic/src/data/data.dart';

class AuthenticationStorageRepository {
  AuthenticationStorageRepository(this._datadashSetupStore);

  final DatadashSetupStore _datadashSetupStore;

  String? get mnemonic => _datadashSetupStore.mnemonic;
  void setMnemonic(String? value) => _datadashSetupStore.mnemonic = value;

  String? get privateKey => _datadashSetupStore.privateKey;
  void setPrivateKey(String? value) => _datadashSetupStore.privateKey = value;

  String? get publicAddress => _datadashSetupStore.publicAddress;
  void setPublicAddress(String? value) =>
      _datadashSetupStore.publicAddress = value;

  bool get loggedIn =>
      _datadashSetupStore.publicAddress != null &&
      _datadashSetupStore.privateKey != null;

  void cleanCache() => _datadashSetupStore.clean();
}
