import 'package:mxc_logic/mxc_logic.dart';

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

  void createWallet(String mnemonic, [int index = 0]) async {
    final privateKey = walletAddressRepoistory.getPrivateKey(mnemonic, index);
    final publicAddress = walletAddressRepoistory.getPublicAddress(privateKey);

    authStorageRepository.setMnemonic(mnemonic);
    authStorageRepository.setPrivateKey(privateKey);
    authStorageRepository.setPublicAddress(publicAddress);

    await authCacheRepository?.loadCache(mnemonic.split(' ').join());
  }

  Account addNewAccount(int index) {
    final mnemoic = authStorageRepository.mnemonic;

    createWallet(mnemoic!, index);

    return Account(
      name: 'Account ${index + 1}',
      address: authStorageRepository.publicAddress!,
    );
  }

  bool get loggedIn => authStorageRepository.loggedIn;

  void resetWallet() => authStorageRepository.cleanCache();
}
