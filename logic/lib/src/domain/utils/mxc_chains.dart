import 'package:mxc_logic/mxc_logic.dart';

class MXCChains {
  static bool isMXCChains(int chainId) {
    return chainId == Config.mxcMainnetChainId ||
        chainId == Config.mxcTestnetChainId;
  }

  static bool isMXCMainnet(int chainId) {
    return chainId == Config.mxcMainnetChainId;
  }

  static bool isMXCTestnet(int chainId) {
    return chainId == Config.mxcTestnetChainId;
  }

  static bool isEthereumMainnet(int chainId) {
    return chainId == Config.ethereumMainnetChainId;
  }
}
