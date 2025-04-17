import 'package:mxc_logic/mxc_logic.dart';

class MXCCompare {
  static bool isEqualEthereumAddressFromString(String inputA, String inputB) =>
      EthereumAddress.fromHex(inputA) == EthereumAddress.fromHex(inputB);
}
