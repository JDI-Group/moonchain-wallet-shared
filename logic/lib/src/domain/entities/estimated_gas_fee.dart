import 'package:web3dart/web3dart.dart';

class TransactionGasEstimation {
  const TransactionGasEstimation({
    required this.gasPrice,
    required this.gas,
    required this.gasFee,
  });

  /// gas price for each unit of gas
  /// We get from dApp or we get we get from web3dart getGasPrice
  final EtherAmount gasPrice;

  /// gas required for tx
  final BigInt gas;

  /// Total gas fee required for tx.
  /// calculation : gasPrice * gas
  final double gasFee;
}

class TransactionPriorityFeeEstimation {
  const TransactionPriorityFeeEstimation(
      {required this.maxFeePerGas, required this.maxPriorityFeePerGas,});

  /// The maximum fee user is willing to spend extra on each unit of gas
  final double maxPriorityFeePerGas;

  /// The maximum fee user willing to spend on each unit of gas
  final double maxFeePerGas;
}
