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

  /// Returns a copy of this object with the specified fields updated.
  TransactionGasEstimation copyWith({
    EtherAmount? gasPrice,
    BigInt? gas,
    double? gasFee,
  }) {
    return TransactionGasEstimation(
      gasPrice: gasPrice ?? this.gasPrice,
      gas: gas ?? this.gas,
      gasFee: gasFee ?? this.gasFee,
    );
  }
}
