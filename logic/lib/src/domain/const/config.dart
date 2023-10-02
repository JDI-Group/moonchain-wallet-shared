import 'package:mxc_logic/src/domain/entities/entities.dart';

class Config {
  static const String testnetRouterAddress =
      '0xCaf6FE52B3b2948EFe7EA72C1ffd0B49C5FB030E';
  static const String mainnetRouterAddress =
      '0x757e5af94fC9b3d4035C2e6Cb1fD304F43c0A1A4';
  static EnsAddresses testnetEnsAddresses = EnsAddresses(
    ens: '0x4E7984fF74569a270765EE67792386cBA77D1b01',
    ensFallbackRegistry: '0x4E7984fF74569a270765EE67792386cBA77D1b01',
    ensResolver: '0x438b261bEb8D3C500153DD17588E6feC36535312',
    ensReverseResolver: '0x438b261bEb8D3C500153DD17588E6feC36535312',
    ensReverseRegistrar: '0x3453c56D41A18147dcb4a92b0B08210F90740a87',
  );
  static EnsAddresses mainnetEnsAddresses = EnsAddresses(
    ens: '0xd241E9681B22Ae47e94c523d25CDdC1a4960cDC3',
    ensFallbackRegistry: '0xd241E9681B22Ae47e94c523d25CDdC1a4960cDC3',
    ensResolver: '0x5325640Cc17A06a409d4f4b6af02A0120528c67E',
    ensReverseResolver: '0x5325640Cc17A06a409d4f4b6af02A0120528c67E',
    ensReverseRegistrar: '0x18c02bA5D8391b3CB49586C94454E44102252cFA',
  );

  static const String mxcSymbol = 'MXC';
  static const String mxcName = 'MXC Token';
  static const String mxcLogoUri = 'assets/svg/networks/mxc.svg';
  static const int ethDecimals = 18;

  static const Token xsdMainnet = Token(
      address: '0x7d2016B09BF46A7CAABD3b45f9e1D6C485A2c729',
      decimals: 18,
      chainId: mxcMainnetChainId,
      name: 'XSD Token',
      symbol: 'XSD',);
  static const Token xsdTestnet = Token(
      address: '0xB9506A80429Ee619C74D46a3276c622358795e2B',
      decimals: 18,
      chainId: mxcTestnetChainId,
      name: 'XSD Token',
      symbol: 'XSD',);

  static const Token wMXCMainnet = Token(
      address: '0xcBCE60BAD702026d6385E5f449e44099A655d14f',
      decimals: 18,
      chainId: mxcMainnetChainId,
      name: 'Wrap MXC Token',
      symbol: 'WMXC',);
  static const Token wMXCTestnet = Token(
      address: '0x6807F4B0D75c59Ef89f0dbEF9841Fb23fFDF105D',
      decimals: 18,
      chainId: mxcTestnetChainId,
      name: 'Wrap MXC Token',
      symbol: 'WMXC',);

  static const int mxcMainnetChainId = 18686;
  static const int mxcTestnetChainId = 5167003;
  static const String mainnetTokenListUrl =
      'https://raw.githubusercontent.com/MXCzkEVM/wannseeswap-tokenlist/main/tokenlist-mainnet.json';
  static const String testnetTokenListUrl =
      'https://raw.githubusercontent.com/MXCzkEVM/wannseeswap-tokenlist/main/tokenlist.json';
  static const String ethereumMainnetTokenListUrl =
      'https://raw.githubusercontent.com/MXCzkEVM/wannseeswap-tokenlist/main/tokenlist-ethereum.json';
  static const String mainnetApiBaseUrl = 'https://explorer-v1.mxc.com/api/v2/';
  static const String testnetApiBaseUrl =
      'https://wannsee-explorer-v1.mxc.com/api/v2/';

  static int decimalShowFixed = 3;

  static bool isMxcChains(int chainId) {
    return chainId == mxcMainnetChainId || chainId == mxcTestnetChainId;
  }
}
