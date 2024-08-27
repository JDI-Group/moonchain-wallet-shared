import 'package:mxc_logic/mxc_logic.dart';

enum MXCContacts {
  erc6551AccountImpl,
  mep2542,
  erc6551Registry,
  mep1004Token,
  ensResolver,
  ensFallbackRegistry,
  router,
  doitDevice,
  health,
  hexagonNaming,
  nameWrapper,
}

class ContractAddresses {
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
      MXCChains.isMXCMainnet(chainId)
          ? contractsList[Config.mxcMainnetChainId]![contract]!
          : contractsList[Config.mxcTestnetChainId]![contract]!;

  static Map<int, Map<MXCContacts, String>> contractsList = {
    Config.mxcTestnetChainId: {
      MXCContacts.mep2542: mep2542AddressTestnet,
      MXCContacts.erc6551AccountImpl: erc6551AccountImplTestnet,
      MXCContacts.erc6551Registry: erc6551RegistryTestnet,
      MXCContacts.mep1004Token: mep1004TokenTestnet,
      MXCContacts.router: testnetRouterAddress,
      MXCContacts.ensResolver: testnetEnsAddresses.ensResolver,
      MXCContacts.ensFallbackRegistry: testnetEnsAddresses.ensFallbackRegistry,
      MXCContacts.doitDevice: doitRingDeviceTestnet,
      MXCContacts.health: healthTestnet,
      MXCContacts.hexagonNaming: hexagonNamingTestnet,
      MXCContacts.nameWrapper: nameWrapperTestnet,
    },
    Config.mxcMainnetChainId: {
      MXCContacts.mep2542: mep2542AddressMainnet,
      MXCContacts.erc6551AccountImpl: erc6551AccountImplMainnet,
      MXCContacts.erc6551Registry: erc6551RegistryMainnet,
      MXCContacts.mep1004Token: mep1004TokenMainnet,
      MXCContacts.router: mainnetRouterAddress,
      MXCContacts.ensResolver: mainnetEnsAddresses.ensResolver,
      MXCContacts.ensFallbackRegistry: mainnetEnsAddresses.ensFallbackRegistry,
      MXCContacts.doitDevice: doitRingDeviceMainnet,
      MXCContacts.health: healthMainnet,
      MXCContacts.hexagonNaming: hexagonNamingMainnet,
      MXCContacts.nameWrapper: nameWrapperMainnet,
    }
  };

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

  // Ring

  static const String doitRingDeviceTestnet =
      '0x9502a58f6e7D8d9C47E3745B0cA87b7E6520A371';
  static const String doitRingDeviceMainnet =
      '0x5e22fc878eE4ff25364233ecF3e3833E13542abC';

  static const String healthTestnet =
      '0x32346b84F49C64caDdd5a286beB502CbBacF8063';
  static const String healthMainnet =
      '0xCCf37D21cD46D57D071f3e45Ecbd81c27769e5CB';

  // MEP1002NT
  static const String hexagonNamingTestnet =
      '0xe5f46E29D91BeBa5C58a83f8558d912820FaC267';
  static const String hexagonNamingMainnet =
      '0x7407459464741c17F8341D7EAFED5a4A5d9303b4';

  // This is used to identify the MNS 1155 tokens 
  static const String nameWrapperTestnet = '0xCE5e3c318BFC7c2dee486cF7c62Ba95feFd6d2bD';
  static const String nameWrapperMainnet = '0xD1B70f92b310c3Fa95b83dB436E00a53e1f1f5d5';
}
