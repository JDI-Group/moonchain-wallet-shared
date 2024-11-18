import 'dart:math';
import 'package:web3dart/web3dart.dart';

class MxcAmount extends EtherAmount {
  MxcAmount.inWei(super.value) : super.inWei();

  static EtherAmount fromDoubleByWei(double value) {
    final wei = value;

    return EtherAmount.inWei(BigInt.from(wei));
  }

  static EtherAmount fromStringByWei(String value) {
    final valueDouble = double.parse(value);
    final wei = valueDouble;

    return EtherAmount.inWei(BigInt.from(wei));
  }

  static EtherAmount fromDoubleByGWei(double value) {
    final wei = BigInt.from(10).pow(9).toDouble() * value;

    return EtherAmount.inWei(BigInt.from(wei));
  }

  static EtherAmount fromDoubleByEther(double value) {
    final wei = BigInt.from(10).pow(18).toDouble() * value;

    return EtherAmount.inWei(BigInt.from(wei));
  }

  static double toDoubleByEther(String value) {
    return double.parse(value) / BigInt.from(10).pow(18).toDouble();
  }

  static double etherAmountToDoubleByWei(EtherAmount value) {
    return value.getInWei.toDouble();
  }

  static EtherAmount etherAmountFromDoubleByWei(double value) {
    return EtherAmount.inWei(BigInt.from(value));
  }

  static double convertWithTokenDecimal(double input, int tokenDecimal) {
    if (input < pow(10, tokenDecimal)) {
      return 0.0;
    }
    double convertedInput = double.parse(
      (input / pow(10, tokenDecimal)).toString(),
    );
    return convertedInput;
  }

  static EtherAmount zero() {
    return EtherAmount.inWei(BigInt.zero);
  }
}
