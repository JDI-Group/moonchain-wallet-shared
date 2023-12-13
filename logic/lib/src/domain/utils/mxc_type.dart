import 'dart:typed_data';

import 'package:web3dart/crypto.dart';

class MXCType {
  static Uint8List hexToUint8List(String value) {
    return hexToBytes(value);
  }

  static String uint8ListToString(Uint8List value) {
    return bytesToHex(value);
  }

  static BigInt stringToBigInt(String value) {
    return BigInt.from(double.parse(value));
  }
}
