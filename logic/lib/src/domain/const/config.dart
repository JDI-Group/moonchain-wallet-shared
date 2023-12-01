import 'package:mxc_logic/mxc_logic.dart';
import 'package:web3dart/web3dart.dart';

class Config {

  // App related config 
  static const String appName = 'AXS';

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

  static const int mxcMainnetChainId = 18686;
  static const int mxcTestnetChainId = 5167003;
  static const int ethereumMainnetChainId = 1;
  static const int ethDecimals = 18;
  static const String mxcSymbol = 'MXC';
  static const String mxcLogoUri = 'assets/svg/networks/mxc.svg';
  static const String mxcName = 'MXC Token';
  static const priority = 1.1;
  static EtherAmount maxPriorityFeePerGas =
      MxcAmount.fromDoubleByGWei(1.5);
  static const dappSectionFeeDivision = 1.5;

  static const String zeroAddress =
      '0x0000000000000000000000000000000000000000';
  static const String mxcAddressSepolia =
      '0x52f72a3c94a6ffca3f8caf769e14015fd040b0cd';
  static const String mxcAddressEthereum =
      '0x5Ca381bBfb58f0092df149bD3D243b08B9a8386e';

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

  static const Token xsdMainnet = Token(
    address: '0x7d2016B09BF46A7CAABD3b45f9e1D6C485A2c729',
    decimals: 18,
    chainId: mxcMainnetChainId,
    name: 'XSD Token',
    symbol: 'XSD',
  );
  static const Token xsdTestnet = Token(
    address: '0xB9506A80429Ee619C74D46a3276c622358795e2B',
    decimals: 18,
    chainId: mxcTestnetChainId,
    name: 'XSD Token',
    symbol: 'XSD',
  );

  static const Token wMXCMainnet = Token(
    address: '0xcBCE60BAD702026d6385E5f449e44099A655d14f',
    decimals: 18,
    chainId: mxcMainnetChainId,
    name: 'Wrap MXC Token',
    symbol: 'WMXC',
  );
  static const Token wMXCTestnet = Token(
    address: '0x6807F4B0D75c59Ef89f0dbEF9841Fb23fFDF105D',
    decimals: 18,
    chainId: mxcTestnetChainId,
    name: 'Wrap MXC Token',
    symbol: 'WMXC',
  );

  /// If error happens with these messages then we will need to show receive bottom sheet
  static List<String> fundErrors = [
    // User doesn't have enough to pay for native token transfer
    // Zero native token balance or not enough for fee
    'gas required exceeds allowance',
    // Sending more than tokens balance
    'execution reverted: ERC20: transfer amount exceeds balance',
    // Sending more than native token balance
    'insufficient funds for gas * price + value'
  ];
}
