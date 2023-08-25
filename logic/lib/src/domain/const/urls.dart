import 'package:mxc_logic/mxc_logic.dart';

class Urls {
  static String tokenInstances(String baseUrl, String hash, TokenType type) =>
      '${baseUrl}tokens/$hash/instances';
  static String tokens(String baseUrl, String hash, TokenType type) =>
      '${baseUrl}addresses/$hash/tokens?type=${type.toStringValue()}';
  static String transactions(String baseUrl, String hash) =>
      '${baseUrl}addresses/$hash/transactions';
  static String tokenTransfers(String baseUrl, String hash, TokenType type) =>
      '${baseUrl}addresses/$hash/token-transfers?type=${type.toStringValue()}';
  static String transaction(String baseUrl, String hash) =>
      '${baseUrl}transactions/$hash';
  static const String defaultTokenList =
      'https://raw.githubusercontent.com/MXCzkEVM/wannseeswap-tokenlist/main/tokenlist.json';
  static const String defaultIpfsGateway =
      'https://raw.githubusercontent.com/MXCzkEVM/ipfs-gateway-list/main/ipfs_gateway_list.json';
  static const String defaultTweets =
      'https://raw.githubusercontent.com/MXCzkEVM/mxc-tweets-list/main/tweets_list.json';

  static const String dappStore =
      'https://raw.githubusercontent.com/MXCzkEVM/MEP-1759-DApp-store/main/dapp-store.json';
  static const String dapp =
      'https://raw.githubusercontent.com/MXCzkEVM/MEP-1759-DApp-store/main/dapp_store';

  static String getLatestVersion(String appSecret, String groupId) =>
      'https://api.appcenter.ms/v0.1/public/sdk/apps/$appSecret/distribution_groups/$groupId/releases/latest';
}
