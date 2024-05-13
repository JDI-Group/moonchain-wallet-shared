import 'package:mxc_logic/mxc_logic.dart';

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

  Future<Account> addAccount(String mnemonic, [int index = 0]) async {
    final privateKey = walletAddressRepoistory.getPrivateKey(mnemonic, index);
    final publicAddress = walletAddressRepoistory.getPublicAddress(privateKey);

    authStorageRepository.setMnemonic(mnemonic);
    authStorageRepository.setPrivateKey(privateKey);
    authStorageRepository.setPublicAddress(publicAddress);

    await authCacheRepository?.loadCache();

    return Account(
        name: '${index + 1}',
        privateKey: authStorageRepository.privateKey!,
        address: authStorageRepository.publicAddress!,
        isCustom: false);
  }

  Future<Account> addCustomAccount(String name, String privateKey) async {
    final publicAddress = walletAddressRepoistory.getPublicAddress(privateKey);

    authStorageRepository.setPrivateKey(privateKey);
    authStorageRepository.setPublicAddress(publicAddress);

    await authCacheRepository?.loadCache();

    return Account(
      name: name,
      privateKey: authStorageRepository.privateKey!,
      address: authStorageRepository.publicAddress!,
      isCustom: true,
    );
  }

  void resetNetwork(Network network) async {
    authStorageRepository.setNetwork(network);

    await authCacheRepository?.loadCache();
  }

  void changeAccount(Account account) async {
    authStorageRepository.setPrivateKey(account.privateKey);
    authStorageRepository.setPublicAddress(account.address);

    await authCacheRepository?.loadCache();
  }

  Future<Account> addNewAccount(int index) async {
    final mnemoic = authStorageRepository.mnemonic;

    return addAccount(mnemoic!, index);
  }

  bool get loggedIn => authStorageRepository.loggedIn;

  void resetWallet() {
    authStorageRepository.cleanCache();
    authCacheRepository!.cleanCache();
  }
}
