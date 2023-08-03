import 'package:mxc_logic/mxc_logic.dart';
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

  String? get web3RpcHttpUrl => _datadashSetupStore.web3RpcHttpUrl;
  void setWeb3RpcHttpUrl(String? value) =>
      _datadashSetupStore.web3RpcHttpUrl = value;

  String? get web3RpcWebsocketUrl => _datadashSetupStore.web3RpcWebsocketUrl;
  void setWeb3RpcWebsocketUrl(String? value) =>
      _datadashSetupStore.web3RpcWebsocketUrl = value;

  bool get loggedIn =>
      _datadashSetupStore.publicAddress != null &&
      _datadashSetupStore.privateKey != null;

  void cleanCache() => _datadashSetupStore.clean();
}
