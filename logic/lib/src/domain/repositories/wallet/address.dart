import 'dart:typed_data';

import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
// import 'package:convert/convert.dart';
// import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:hex/hex.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:web3dart/credentials.dart';

abstract class IAddressService {
  String generateMnemonic();
  Future<String> getPrivateKey(String mnemonic);
  Future<EthereumAddress> getPublicAddress();
  Future<bool> setupFromMnemonic(String mnemonic);
  Future<bool> setupFromPrivateKey(String privateKey);
  String entropyToMnemonic(String entropyMnemonic);
  bool validateMnemonic(String mnemonic);
  void reset();
}

class AddressService implements IAddressService {
  const AddressService(this._authStorageRepository);

  final AuthenticationStorageRepository _authStorageRepository;

  @override
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  @override
  String entropyToMnemonic(String entropyMnemonic) {
    return bip39.entropyToMnemonic(entropyMnemonic);
  }

  @override
  Future<String> getPrivateKey(String mnemonic) async {
    final seed = bip39.mnemonicToSeedHex(mnemonic);
    final bip32.BIP32 root =
        bip32.BIP32.fromSeed(HEX.decode(seed) as Uint8List);
    final bip32.BIP32 child = root.derivePath("m/44'/60'/0'/0/0");

    final privateKey = HEX.encode(child.privateKey as List<int>);
    return privateKey;
  }

  @override
  Future<EthereumAddress> getPublicAddress() async {
    final key = _authStorageRepository.privateKey;
    if (key != null && key.isNotEmpty) {
      final private = EthPrivateKey.fromHex(key);

      return private.address;
    }

    throw Exception('Private Key is empty.');
  }

  @override
  Future<bool> setupFromMnemonic(String mnemonic) async {
    final cryptMnemonic = bip39.mnemonicToEntropy(mnemonic);
    final privateKey = await getPrivateKey(mnemonic);

    _authStorageRepository.saveMnemonic(cryptMnemonic);
    _authStorageRepository.savePrivateKey(privateKey);
    return true;
  }

  @override
  Future<bool> setupFromPrivateKey(String privateKey) async {
    _authStorageRepository.saveMnemonic(null);
    _authStorageRepository.savePrivateKey(privateKey);
    return true;
  }

  @override
  void reset() {
    _authStorageRepository.saveMnemonic(null);
    _authStorageRepository.savePrivateKey(null);
  }

  @override
  bool validateMnemonic(String mnemonic) => bip39.validateMnemonic(mnemonic);
}
