import 'package:mxc_logic/mxc_logic.dart';

class MXCChains {
  static bool isMXCChains(int chainId) {
    return chainId == Config.mxcMainnetChainId ||
        chainId == Config.mchMainnetChainId ||
        chainId == Config.mchTestnetChainId;
  }

  static bool isMXCChainsPlusEthereum(int chainId) {
    return isMXCChains(chainId) || isEthereumMainnet(chainId);
  }

  static bool isMXCMainnet(int chainId) {
    return chainId == Config.mxcMainnetChainId;
  }

  static bool isMCHTestnet(int chainId) {
    return chainId == Config.mchTestnetChainId;
  }

  static bool isMCHMainnet(int chainId) {
    return chainId == Config.mchMainnetChainId;
  }

  static bool isEthereumMainnet(int chainId) {
    return chainId == Config.ethereumMainnetChainId;
  }
}
