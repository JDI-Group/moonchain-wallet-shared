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

  static const String mainnetTokenListUrl =
      'https://raw.githubusercontent.com/MXCzkEVM/wannseeswap-tokenlist/main/tokenlist-mainnet.json';
  static const String testnetTokenListUrl =
      'https://raw.githubusercontent.com/MXCzkEVM/wannseeswap-tokenlist/main/tokenlist.json';
  static const String ethereumMainnetTokenListUrl =
      'https://raw.githubusercontent.com/MXCzkEVM/wannseeswap-tokenlist/main/tokenlist-ethereum.json';
  static const String defaultTokenList =
      'https://raw.githubusercontent.com/MXCzkEVM/wannseeswap-tokenlist/main/tokenlist.json';
  static const String defaultIpfsGateway =
      'https://raw.githubusercontent.com/MXCzkEVM/ipfs-gateway-list/main/ipfs_gateway_list.json';
  static const String defaultTweets =
      'https://raw.githubusercontent.com/MXCzkEVM/mxc-tweets-list/main/tweets_list_v2.json';

  static const String dappStore =
      'https://raw.githubusercontent.com/MXCzkEVM/MEP-1759-DApp-store/main/dapp-store.json';
  static const String dapp =
      'https://raw.githubusercontent.com/MXCzkEVM/MEP-1759-DApp-store/main/dapp_store';

  static String getLatestVersion(String appSecret, String groupId) =>
      'https://api.appcenter.ms/v0.1/public/sdk/apps/$appSecret/distribution_groups/$groupId/releases/latest';

  static const String mainnetApiBaseUrl = 'https://explorer-v1.mxc.com/api/v2/';
  static const String testnetApiBaseUrl =
      'https://wannsee-explorer-v1.mxc.com/api/v2/';

  static const String chainsList =
      'https://raw.githubusercontent.com/MXCzkEVM/chains-list/main/chains_list.json';

  static const String mxcMainnetNftMarketPlace = 'https://nft.mxc.com/';
  static const String mxcTestnetNftMarketPlace = 'https://wannsee-nft.mxc.com/';
  static const String mxcStatus = 'https://mxc.instatus.com/';

  static const String dappRoot =
      'https://raw.githubusercontent.com/MXCzkEVM/MEP-1759-DApp-store/main';

  static const String iOSUrl =
      'https://apps.apple.com/us/app/axs-decentralized-wallet/id6460891587';

  static const String weChat = 'weixin://';
  static const String telegram = 'tg://';
  static const String emailApp = 'mailto:';
  static const String mxcChatGPT = 'http://t.me/mxcchatgpt_bot';
  static const String axsTermsConditions =
      'https://doc.mxc.com/docs/Resources/tns';
  static const String axsPrivacy = 'https://doc.mxc.com/docs/Resources/Privacy';
  static const String gateio = 'https://gate.io/';
  static const String okx = 'https://www.okx.com/';
  static const String mainnetL3Bridge = 'https://erc20.mxc.com/';
  static const String testnetL3Bridge = 'https://wannsee-erc20.mxc.com/';

  static String mainnetMns(String name) =>
      'https://mns.mxc.com/$name.mxc/register';
  static String testnetMns(String name) =>
      'https://wannsee-mns.mxc.com/$name.mxc/register';

  static String txExplorer(String hash) {
    return 'tx/$hash';
  }

  static String addressExplorer(String address) {
    return 'address/$address';
  }

  static bool isL3Bridge(String url) {
    return url.contains('erc20.mxc.com') ||
        url.contains('wannsee-erc20.mxc.com');
  }

  static String networkL3Bridge(int chainId) =>
      Config.isMXCMainnet(chainId) ? mainnetL3Bridge : testnetL3Bridge;
}
