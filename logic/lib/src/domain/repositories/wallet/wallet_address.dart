import 'dart:typed_data';

import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:hex/hex.dart';
import 'package:web3dart/credentials.dart';

class WalletAddressRepoistory {
  const WalletAddressRepoistory();

  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  String entropyToMnemonic(String entropyMnemonic) {
    return bip39.entropyToMnemonic(entropyMnemonic);
  }

  String getPrivateKey(String mnemonic, [int index = 0]) {
    final seed = bip39.mnemonicToSeedHex(mnemonic);

    final bip32.BIP32 root =
        bip32.BIP32.fromSeed(HEX.decode(seed) as Uint8List);
    final bip32.BIP32 child = root.derivePath("m/44'/60'/0'/0/$index");

    return HEX.encode(child.privateKey as List<int>);
  }

  String getPublicAddress(String privateKey) {
    return EthPrivateKey.fromHex(privateKey).address.hex;
  }

  String getPublicAddressFromMnemonic(String mnemonic) {
    final privateKey = getPrivateKey(mnemonic);
    return EthPrivateKey.fromHex(privateKey).address.hex;
  }

  bool validateMnemonic(String mnemonic) => bip39.validateMnemonic(mnemonic);
}
