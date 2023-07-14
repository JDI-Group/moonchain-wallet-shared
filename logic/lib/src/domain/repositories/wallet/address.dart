import 'dart:typed_data';

import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:hex/hex.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:web3dart/credentials.dart';

class AddressService {
  const AddressService(this._authStorageRepository);

  final AuthenticationStorageRepository _authStorageRepository;

  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  String entropyToMnemonic(String entropyMnemonic) {
    return bip39.entropyToMnemonic(entropyMnemonic);
  }

  Future<String> getPrivateKey(String mnemonic) async {
    final seed = bip39.mnemonicToSeedHex(mnemonic);

    final bip32.BIP32 root =
        bip32.BIP32.fromSeed(HEX.decode(seed) as Uint8List);
    final bip32.BIP32 child = root.derivePath("m/44'/60'/0'/0/0");

    final privateKey = HEX.encode(child.privateKey as List<int>);
    return privateKey;
  }

  Future<EthereumAddress> getPublicAddress(String privateKey) async {
    final key = EthPrivateKey.fromHex(privateKey);
    return key.address;
  }

  Future<bool> setupFromMnemonic(String mnemonic) async {
    final cryptMnemonic = bip39.mnemonicToEntropy(mnemonic);
    final privateKey = await getPrivateKey(mnemonic);
    final publicAddress = EthPrivateKey.fromHex(privateKey).address;

    _authStorageRepository.saveMnemonic(cryptMnemonic);
    _authStorageRepository.savePrivateKey(privateKey);
    _authStorageRepository.savePublicAddress(publicAddress.hex);
    return true;
  }

  void reset() {
    _authStorageRepository.saveMnemonic(null);
    _authStorageRepository.savePrivateKey(null);
    _authStorageRepository.savePublicAddress(null);
  }

  bool validateMnemonic(String mnemonic) => bip39.validateMnemonic(mnemonic);

  String? getLocalstoragePrivateKey() => _authStorageRepository.privateKey;

  EthereumAddress? getLocalstoragePublicAddress() =>
      EthereumAddress.fromHex(_authStorageRepository.publicAddress!);
}
