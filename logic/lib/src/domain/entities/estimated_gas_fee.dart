import 'package:web3dart/web3dart.dart';

class EstimatedGasFee {
  const EstimatedGasFee({
    required this.gasPrice,
    required this.gas,
    required this.gasFee,
  });

  final EtherAmount gasPrice;
  final BigInt gas;
  final double gasFee;
}
