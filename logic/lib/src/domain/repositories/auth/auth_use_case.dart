import 'auth_storage_repository.dart';

class AuthUseCase {
  AuthUseCase(
    this.authStorageRepository,
  );

  final AuthenticationStorageRepository authStorageRepository;

  Future<void> login({
    required String mnemonic,
    required String privateKey,
  }) async {
    authStorageRepository.saveMnemonic(mnemonic);
    authStorageRepository.savePrivateKey(privateKey);
  }

  String? getPublicAddress() => authStorageRepository.publicAddress;

  bool get loggedIn => authStorageRepository.loggedIn;
}
