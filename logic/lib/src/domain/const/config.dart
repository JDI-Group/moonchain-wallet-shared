import 'package:flutter/material.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:web3dart/web3dart.dart';

enum MXCContacts { erc6551AccountImpl, mep2542, erc6551Registry, mep1004Token }

class Config {
  // App related config
  static const String appName = 'AXS';

  static const String testnetRouterAddress =
      '0x96adb4c80F6c934a20303d4b88f935F967299d5e';
  static const String mainnetRouterAddress =
      '0x757e5af94fC9b3d4035C2e6Cb1fD304F43c0A1A4';

  static EnsAddresses testnetEnsAddresses = EnsAddresses(
    ens: '0x9691E2eFb8C7f6d714A7b35da3184b8cB927a415',
    ensFallbackRegistry: '0x9691E2eFb8C7f6d714A7b35da3184b8cB927a415',
    ensResolver: '0xd241E9681B22Ae47e94c523d25CDdC1a4960cDC3',
    ensReverseResolver: '0xd241E9681B22Ae47e94c523d25CDdC1a4960cDC3',
    ensReverseRegistrar: '0xF7Bb70e1a762AB6CCb7Ca23878fA4315656c3090',
  );

  static EnsAddresses mainnetEnsAddresses = EnsAddresses(
    ens: '0xd241E9681B22Ae47e94c523d25CDdC1a4960cDC3',
    ensFallbackRegistry: '0xd241E9681B22Ae47e94c523d25CDdC1a4960cDC3',
    ensResolver: '0x5325640Cc17A06a409d4f4b6af02A0120528c67E',
    ensReverseResolver: '0x5325640Cc17A06a409d4f4b6af02A0120528c67E',
    ensReverseRegistrar: '0x18c02bA5D8391b3CB49586C94454E44102252cFA',
  );

  static EthereumAddress getContractAddress(
    MXCContacts contract,
    int chainId,
  ) =>
      EthereumAddress.fromHex(getContractAddressString(contract, chainId));

  static String getContractAddressString(MXCContacts contract, int chainId) =>
      isMXCMainnet(chainId)
          ? contractsList[mxcMainnetChainId]![contract]!
          : contractsList[mxcTestnetChainId]![contract]!;

  static Map<int, Map<MXCContacts, String>> contractsList = {
    mxcTestnetChainId: {
      MXCContacts.mep2542: mep2542AddressTestnet,
      MXCContacts.erc6551AccountImpl: erc6551AccountImplTestnet,
      MXCContacts.erc6551Registry: erc6551RegistryTestnet,
      MXCContacts.mep1004Token: mep1004TokenTestnet,
    },
    mxcMainnetChainId: {
      MXCContacts.mep2542: mep2542AddressMainnet,
      MXCContacts.erc6551AccountImpl: erc6551AccountImplMainnet,
      MXCContacts.erc6551Registry: erc6551RegistryMainnet,
      MXCContacts.mep1004Token: mep1004TokenMainnet,
    }
  };

  static const int mxcMainnetChainId = 18686;
  static const int mxcTestnetChainId = 5167004;
  static const int ethereumMainnetChainId = 1;
  static const int ethDecimals = 18;
  static const String mxcSymbol = 'MXC';
  static const String mxcLogoUri = 'assets/svg/networks/mxc.svg';
  static const String mxcName = 'MXC Token';
  static const priority = 1.1;
  static EtherAmount maxPriorityFeePerGas = MxcAmount.fromDoubleByGWei(1.5);
  static const dappSectionFeeDivision = 1.5;
  // Used for cancel & speed up
  static double extraGasPercentage = 1.1;
  static double minerClaimTransactionGasMultiply = 1.3;
  // Miner dApp transactions gas limit
  static const double minerDAppGasLimit = 750000;
  static const int h3Resolution = 7;

  static const Duration httpClientTimeOut = Duration(seconds: 30);

  static const String erc20TransferMethodId = 'a9059cbb';

  static const String zeroAddress =
      '0x0000000000000000000000000000000000000000';
  static const String mxcAddressSepolia =
      '0x52f72a3c94a6ffca3f8caf769e14015fd040b0cd';
  static const String mxcAddressEthereum =
      '0x5Ca381bBfb58f0092df149bD3D243b08B9a8386e';

  // Miner related
  static const String mep2542AddressTestnet =
      '0xf01eceed6319423bCC953889CB8F35E7084df1dF';
  static const String mep2542AddressMainnet =
      '0xBF717fCD0FD99238998d90D3fAA8C015530e85F4';
  static const String erc6551AccountImplTestnet =
      '0x6c2660e11F64A404FB5023abe668799DCF899d09';
  static const String erc6551AccountImplMainnet =
      '0xaafd9fF2225c8FEa0c616a219a78eD1d9B4CBeF7';
  static const String erc6551RegistryTestnet =
      '0xEF4c00668a22a3C95f98A5D7468773f98c8C431b';
  static const String erc6551RegistryMainnet =
      '0x4c802AFb54Ef4e27429b6Ab87e6C2Da6991Fd4B9';
  static const String mep1004TokenTestnet =
      '0x0D589F5EeDF70e17F053CBb93760Db7E418603F6';
  static const String mep1004TokenMainnet =
      '0x8Ff08F39B1F4Ad7dc42E6D63fd25AeE47EA801Ce';

  // Numbers fixed decimals
  static int decimalShowFixed = 3;
  static int decimalWriteFixed = 8;

  /// It's in days
  static int transactionsHistoryLimit = 7;

  static bool isMxcChains(int chainId) {
    return chainId == mxcMainnetChainId || chainId == mxcTestnetChainId;
  }

  static bool isMXCMainnet(int chainId) {
    return chainId == mxcMainnetChainId;
  }

  static bool isEthereumMainnet(int chainId) {
    return chainId == ethereumMainnetChainId;
  }

  static double dAppDoubleTapLowerBound = 0;
  static double dAppDoubleTapUpperBound = 200;
}
