import 'package:bip39/bip39.dart' as bip39;
import 'package:convert/convert.dart';
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:hex/hex.dart';
import 'package:web3dart/credentials.dart';

abstract class IAddressService {
  String generateMnemonic();
  Future<String> getPrivateKey(String mnemonic);
  Future<EthereumAddress> getPublicAddress(String privateKey);
  String entropyToMnemonic(String entropyMnemonic);
}

class AddressService implements IAddressService {
  const AddressService();

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
    final master = await ED25519_HD_KEY.getMasterKeyFromSeed(hex.decode(seed),
        masterSecret: 'Bitcoin seed');
    final privateKey = HEX.encode(master.key);

    print('private: $privateKey');

    return privateKey;
  }

  @override
  Future<EthereumAddress> getPublicAddress(String privateKey) async {
    final private = EthPrivateKey.fromHex(privateKey);

    print('address: ${private.address}');
    return private.address;
  }

}
