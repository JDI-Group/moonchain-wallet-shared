import 'auth_cache_repository.dart';
import 'auth_storage_repository.dart';

import '../wallet/wallet_address.dart';

class AuthUseCase {
  AuthUseCase(
    this.walletAddressRepoistory,
    this.authStorageRepository,
    this.authCacheRepository,
  );

  final WalletAddressRepoistory walletAddressRepoistory;
  final AuthenticationStorageRepository authStorageRepository;
  final AuthenticationCacheRepository? authCacheRepository;

  String generateMnemonic() => walletAddressRepoistory.generateMnemonic();

  bool validateMnemonic(String mnemonic) =>
      walletAddressRepoistory.validateMnemonic(mnemonic);

  void createWallet(String mnemonic) async {
    final privateKey = walletAddressRepoistory.getPrivateKey(mnemonic);
    final publicKey = walletAddressRepoistory.getPublicAddress(privateKey);

    authStorageRepository.setPrivateKey(privateKey);
    authStorageRepository.setPublicAddress(publicKey);

    await authCacheRepository?.loadCache(publicKey);
  }

  bool get loggedIn => authStorageRepository.loggedIn;

  void resetWallet() {
    authStorageRepository.setPrivateKey(null);
    authStorageRepository.setPublicAddress(null);
  }
}
