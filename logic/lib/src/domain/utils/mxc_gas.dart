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

  static double calculateMaxFeePerGasDouble(double gasPrice) {
    final estimatedGasFeeAsDouble = gasPrice * Config.priority;

    BigInt maxFeePerGas = BigInt.from(estimatedGasFeeAsDouble) +
        Config.maxPriorityFeePerGas.getInWei;

    return maxFeePerGas.toDouble();
  }

  /// This functions adds to the fee by multiplying the gas price by the Config.extraGasPercentage.
  static double addExtraFeeForTxReplacement(double gasPrice) {
    final gasPriceDouble = gasPrice * Config.extraGasPercentage;
    return gasPriceDouble;
  }
}
