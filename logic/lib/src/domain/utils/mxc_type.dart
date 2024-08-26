import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:web3dart/crypto.dart';
import 'package:convert/convert.dart' show hex;
import 'package:eth_sig_util/util/utils.dart' as utils;

class MXCType {
  static Uint8List hexToUint8List(String value) {
    return hexToBytes(value);
  }

  static String hexToString(String value) {
    final bytes = hexToBytes(value);
    return String.fromCharCodes(bytes);
  }

  static String uint8ListToString(
    Uint8List value, {
    bool include0x = false,
    int? forcePadLength,
    bool padToEvenLength = false,
  }) {
    return bytesToHex(
      value,
      include0x: include0x,
      forcePadLength: forcePadLength,
      padToEvenLength: padToEvenLength,
    );
  }

  static BigInt stringToBigInt(String value) {
    return BigInt.from(double.parse(value));
  }

  static String bigIntToHex(BigInt value) {
    return value.toRadixString(16);
  }

  static Uint8List stringToUint8List(String value) {
    List<int> utf8Bytes = value.codeUnits;
    return Uint8List.fromList(utf8Bytes);
  }

  // Used to change the token id of NFT to hex
  static String hexlify(BigInt dec) {
    return '0x0' + dec.toRadixString(16);
  }
}
