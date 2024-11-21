import 'dart:math';

import 'package:mxc_logic/mxc_logic.dart';

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
  static double maxFeePerGasByEthByWei(double gasPrice) {
    final estimatedGasFeeAsDouble = gasPrice * Config.priority;

    double maxFeePerGas = estimatedGasFeeAsDouble +
        Config.maxPriorityFeePerGas.getInWei.toDouble();

    return maxFeePerGas.toDouble();
  }

  ///  The returned value is in Wei.
  static double maxFeePerGasByEth(double gasPrice) {
    final estimatedGasFeeAsDouble = gasPrice * Config.priority;

    double maxFeePerGas = estimatedGasFeeAsDouble +
        Config.maxPriorityFeePerGas.getInEther.toDouble();

    return maxFeePerGas;
  }

  /// calculates total base fee based on base gas price & gas limit,
  ///  The returned value is in Eth.
  static double calculateTotalFee(double gasPrice, int gasLimit) {
    double gasFee = gasPrice * gasLimit;
    gasFee = gasFee / pow(10, 18);
    return gasFee;
  }

  static String getTotalFeeInString(double gasPrice, int gasLimit) {
    final totalFeeDouble = calculateTotalFee(gasPrice, gasLimit);
    String totalFee = totalFeeDouble.toString();
    totalFee = MXCFormatter.checkExpoNumber(totalFee);
    return totalFee;
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
  static double addExtraFee(double value) {
    final newValue = value * Config.extraGasPercentage;
    return newValue;
  }

  /// This functions adds to the fee by multiplying the gas price by the Config.extraGasPercentage.
  static EtherAmount addExtraFeeEtherAmount(EtherAmount value) {
    final newValue =
        MxcAmount.etherAmountToDoubleByWei(value) * Config.extraGasPercentage;
    return MxcAmount.etherAmountFromDoubleByWei(newValue);
  }

  /// This function will get current transaction max fee per gas & max priority fee per gas and will add extraGasPercentage to these properties.
  static TransactionPriorityFeeEstimation addExtraFeeToPriorityFees({
    required double feePerGas,
    required double priorityFeePerGas,
  }) {
    double maxFeePerGas = MXCGas.addExtraFee(
      feePerGas,
    );

    double maxPriorityFeePerGas = MXCGas.addExtraFee(
      priorityFeePerGas,
    );
    return TransactionPriorityFeeEstimation(
      maxFeePerGas: maxFeePerGas,
      maxPriorityFeePerGas: maxPriorityFeePerGas,
    );
  }

  /// This function will get current transaction max fee per gas & max priority fee per gas and will add extraGasPercentage to these properties.
  static TransactionPriorityFeeEstimation
      addExtraFeeToPriorityFeesByEtherAmount({
    required EtherAmount feePerGas,
    required double priorityFeePerGas,
  }) {
    double maxFeePerGas = MXCGas.addExtraFee(
      feePerGas.getInWei.toDouble(),
    );

    double maxPriorityFeePerGas = MXCGas.addExtraFee(
      priorityFeePerGas,
    );
    return TransactionPriorityFeeEstimation(
      maxFeePerGas: maxFeePerGas,
      maxPriorityFeePerGas: maxPriorityFeePerGas,
    );
  }

  /// This function will return max fee per gas based on the given gas price & current max fee per gas.
  static double getReplacementMaxFeePerGas(
    double gasPrice,
    double maxFeePerGas,
  ) {
    if (maxFeePerGas < gasPrice) {
      // Base fee is higher than the max fee so we should raise max fee to be more than the base fee
      return maxFeePerGasByEthByWei(gasPrice);
    } else {
      return maxFeePerGas;
    }
  }
}
