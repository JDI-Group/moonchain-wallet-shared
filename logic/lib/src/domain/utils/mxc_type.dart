import 'dart:typed_data';

class MXCType {
  static Uint8List stringToUint8List(String value) {
    List<int> list = value.codeUnits;
    return Uint8List.fromList(list);
  }

  static String uint8ListToString(Uint8List value) {
    return String.fromCharCodes(value);
  }

  static BigInt stringToBigInt(String value) {
    return BigInt.from(double.parse(value));
  }
}
