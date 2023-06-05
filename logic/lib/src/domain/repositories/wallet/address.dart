import 'package:bip39/bip39.dart' as bip39;
import 'package:convert/convert.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:hex/hex.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:web3dart/credentials.dart';

abstract class IAddressService {
  String generateMnemonic();
  Future<String> getPrivateKey(String mnemonic);
  Future<EthereumAddress> getPublicAddress(String privateKey);
  Future<bool> setupFromMnemonic(String mnemonic);
  Future<bool> setupFromPrivateKey(String privateKey);
  String entropyToMnemonic(String entropyMnemonic);
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
    final master = await ED25519_HD_KEY.getMasterKeyFromSeed(
      hex.decode(seed),
      masterSecret: 'mxc_seed',
    );
    final privateKey = HEX.encode(master.key);
    return privateKey;
  }

  @override
  Future<EthereumAddress> getPublicAddress(String privateKey) async {
    final private = EthPrivateKey.fromHex(privateKey);

    return private.address;
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
}
