import 'package:mxc_logic/internal.dart';
import 'package:mxc_logic/mxc_logic.dart';

class AuthenticationCacheRepository {
  AuthenticationCacheRepository(
    this._controller,
    this._authStorageRepository,
  );

  final CacheController _controller;
  final AuthenticationStorageRepository _authStorageRepository;

  Future<void> loadCache() async {
    final currentNetwork = _authStorageRepository.network ??
        Network.fixedNetworks().where((item) => item.enabled).first;

    final username =
        '${currentNetwork.label?.split(' ').join()}_${_authStorageRepository.publicAddress}';
    await _controller.load(username);
  }

  void cleanCache(){
    _controller.unload();
  }
}
