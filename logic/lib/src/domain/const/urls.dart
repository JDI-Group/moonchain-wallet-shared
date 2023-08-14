import 'package:mxc_logic/mxc_logic.dart';

class Urls {
  static String tokenInstances(String hash, TokenType type) =>
      'https://wannsee-explorer-v1.mxc.com/api/v2/tokens/$hash/instances';
  static String tokens(String hash, TokenType type) =>
      'https://wannsee-explorer-v1.mxc.com/api/v2/addresses/$hash/tokens?type=${type.toStringValue()}';
  static String transactions(String hash) =>
      'https://wannsee-explorer-v1.mxc.com/api/v2/addresses/$hash/transactions';
  static String tokenTransfers(String hash, TokenType type) =>
      'https://wannsee-explorer-v1.mxc.com/api/v2/addresses/$hash/token-transfers?type=${type.toStringValue()}';
  static String transaction(String hash) =>
      'https://wannsee-explorer-v1.mxc.com/api/v2/transactions/$hash';
  static const String defaultTokenList =
      'https://raw.githubusercontent.com/MXCzkEVM/wannseeswap-tokenlist/main/tokenlist.json';
  static const String defaultIpfsGateway =
      'https://raw.githubusercontent.com/MXCzkEVM/ipfs-gateway-list/main/ipfs_gateway_list.json';
  static const String defaultTweets =
      'https://raw.githubusercontent.com/MXCzkEVM/mxc-tweets-list/main/tweets_list.json';
}
