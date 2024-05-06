import 'package:mxc_logic/mxc_logic.dart';

class Tokens {
  static Token getXSD(int chainId) =>
      MXCChains.isMXCMainnet(chainId) ? xsdMainnet : xsdTestnet;
  static Token getWMXC(int chainId) =>
      MXCChains.isMXCMainnet(chainId) ? wMXCMainnet : wMXCTestnet;

  static const Token xsdMainnet = Token(
    address: '0x7d2016B09BF46A7CAABD3b45f9e1D6C485A2c729',
    decimals: 18,
    chainId: Config.mxcMainnetChainId,
    name: 'XSD Token',
    symbol: 'XSD',
  );
  static const Token xsdTestnet = Token(
    address: '0xD28fce81516DCc53d2E320fd1C78e8449556c4f0',
    decimals: 18,
    chainId: Config.mxcTestnetChainId,
    name: 'XSD Token',
    symbol: 'XSD',
  );

  static const Token wMXCMainnet = Token(
    address: '0xcBCE60BAD702026d6385E5f449e44099A655d14f',
    decimals: 18,
    chainId: Config.mxcMainnetChainId,
    name: 'Wrapped MXC Token',
    symbol: 'WMXC',
  );
  static const Token wMXCTestnet = Token(
    address: '0xa5C0D0d32b41473c581a979dEab01651d1f5Eff5',
    decimals: 18,
    chainId: Config.mxcTestnetChainId,
    name: 'Wrapped MXC Token',
    symbol: 'WMXC',
  );
}
