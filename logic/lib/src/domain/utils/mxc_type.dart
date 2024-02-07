import 'dart:typed_data';

import 'package:flutter/material.dart';
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

  static String bigIntToHex(BigInt value) {
    return value.toRadixString(16);
  }

  static Uint8List stringToUint8List(String value) {
    List<int> utf8Bytes = value.codeUnits;
    return Uint8List.fromList(utf8Bytes);
  }

  static int timeOfDayInMinutes(TimeOfDay time) {
    return time.hour * 60 + time.minute;
  }
}
