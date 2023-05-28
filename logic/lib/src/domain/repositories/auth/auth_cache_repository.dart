import 'package:mxc_logic/internal.dart';

class AuthenticationCacheRepository {
  AuthenticationCacheRepository(this._controller);

  final CacheController _controller;

  Future<void> loadCache(String username) async {
    await _controller.load(username);
  }
}
