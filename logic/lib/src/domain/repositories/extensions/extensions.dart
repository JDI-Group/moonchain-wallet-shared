import 'package:web3dart/web3dart.dart';

class MxcAmount extends EtherAmount {
  MxcAmount.inWei(super.value) : super.inWei();

  static EtherAmount fromDoubleByEther(double value) {
    final wei = BigInt.from(10).pow(18).toDouble() * value;

    return EtherAmount.inWei(BigInt.from(wei));
  }

  static double toDoubleByEther(String value) {
    return double.parse(value) / BigInt.from(10).pow(18).toDouble();
  }
}
