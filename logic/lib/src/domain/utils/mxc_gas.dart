import 'dart:math';

import 'package:mxc_logic/mxc_logic.dart';
import 'package:web3dart/web3dart.dart';

class MXCGas {
  // estimated gas fee = from blockchain with getGasPrice method on web3dart
  // max priority fee per gas = 1.5 Gwei
  // max fee per gas = gasPrice * priority + 1.5 Gwei (This is to prevent max fee per gas being smallet than max priority fee per gas )
  static EtherAmount calculateMaxFeePerGas(EtherAmount gasPrice) {
    final estimatedGasFeeAsDouble =
        gasPrice.getValueInUnitBI(EtherUnit.wei).toDouble() * Config.priority;
    EtherAmount maxFeePerGas = EtherAmount.fromBigInt(
      EtherUnit.wei,
      BigInt.from(estimatedGasFeeAsDouble) +
          Config.maxPriorityFeePerGas.getInWei,
    );
    return maxFeePerGas;
  }

  ///  The returned value is in Wei.
  static double calculateMaxFeePerGasDouble(double gasPrice) {
    final estimatedGasFeeAsDouble = gasPrice * Config.priority;

    BigInt maxFeePerGas = BigInt.from(estimatedGasFeeAsDouble) +
        Config.maxPriorityFeePerGas.getInWei;

    return maxFeePerGas.toDouble();
  }

  /// calculates total base fee based on base gas price & gas limit,
  ///  The returned value is in Eth.
  static double calculateTotalFee(double gasPrice, int gasLimit) {
    double gasFee = gasPrice * gasLimit;
    gasFee = gasFee / pow(10, 18);
    return gasFee;
  }

  /// calculates total max fee based on base gas price & gas limit,
  /// The returned value is in Eth
  static double calculateTotalMaxFee(double gasPrice, int gasLimit) {
    final estimatedGasFeeAsDouble = gasPrice * gasLimit * Config.priority;

    BigInt maxFeeBigInt = BigInt.from(estimatedGasFeeAsDouble) +
        Config.maxPriorityFeePerGas.getInWei;

    double maxFee = maxFeeBigInt.toDouble();
    maxFee = maxFee / pow(10, 18);

    return maxFee;
  }

  /// This functions adds to the fee by multiplying the gas price by the Config.extraGasPercentage.
  static double addExtraFeeForTxReplacement(double gasPrice) {
    final gasPriceDouble = gasPrice * Config.extraGasPercentage;
    return gasPriceDouble;
  }
}
