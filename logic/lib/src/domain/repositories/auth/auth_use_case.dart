import 'auth_storage_repository.dart';

class LoginUseCase {
  LoginUseCase(
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
}
