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
      'https://geneva-explorer-v1.moonchain.com/api/v2/';

  static const String chainsList =
      'https://raw.githubusercontent.com/MXCzkEVM/chains-list/main/chains_list_v2.json';

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

  // MXC support
  static const String mxcZendesk = 'https://mxcfoundation.zendesk.com/hc/en-gb';
  static const String mxcKnowledgeHub = 'https://www.mxc.org/blog#technology';
  static const String mxcDesignDocs = 'https://doc.mxc.com/docs/intro';

  /// Used to retrieve the latest epoch details
  static String mepEpochListTestnet(int page, int pageLimit) =>
      'https://wannsee-mining-api.matchx.io/mep2542/getEpochList?page=$page&limit=$pageLimit';
  static String mepEpochListMainnet(int page, int pageLimit) =>
      'https://mining-api.matchx.io/mep2542/getEpochList?page=$page&limit=$pageLimit';

  static String mepEpochList(int chainId, int page, int pageLimit) {
    if (Config.isMXCMainnet(chainId)) {
      return mepEpochListMainnet(page, pageLimit);
    }
    return mepEpochListTestnet(page, pageLimit);
  }

  static const String axsTermsConditions =
      'https://doc.mxc.com/docs/Resources/tns';
  static const String axsPrivacy = 'assets/pdf/privacy.pdf';

  static const String gateio = 'https://gate.io/';
  static const String okx = 'https://www.okx.com/';
  static const String kucoin = 'https://www.kucoin.com/';
  static const String cryptocom = 'https://crypto.com/';

  static const String mainnetL3Bridge = 'https://erc20.mxc.com/';
  static const String testnetL3Bridge = 'https://wannsee-erc20.mxc.com/';

  static String mainnetMns(String name) =>
      'https://mns.mxc.com/$name.mxc/register';
  static String testnetMns(String name) =>
      'https://geneva-mns.moonchain.com/$name.mxc/register';

  static String txExplorer(String hash) {
    return 'tx/$hash';
  }

  static String addressExplorer(String address) {
    return 'address/$address';
  }

  static String addressMinersByChainId(int chainId, String address) =>
      Config.isMXCMainnet(chainId)
          ? addressMinersMainnet(address)
          : addressMinersTestnet(address);

  static String postMEP2542RewardInfo(int chainId) =>
      Config.isMXCMainnet(chainId)
          ? mep2542RewardInfoMainnet
          : mep2542RewardInfoTestnet;

  static String addressMinersTestnet(String address) =>
      minerDappApiTestnet + addressMiners + address;
  static String addressMinersMainnet(String address) =>
      minerDappApiMainnet + addressMiners + address;

  static const String mep2542RewardInfoTestnet =
      minerDappApiTestnet + mep2542RewardInfo;
  static const String mep2542RewardInfoMainnet =
      minerDappApiMainnet + mep2542RewardInfo;

  static const String addressMiners = 'mep2542/getMEP1004TokenList?owner=';
  static const String mep2542RewardInfo = 'mep2542/getMEP2542RewardInfo';

  static String postVerifyMerkleProof(int chainId) =>
      Config.isMXCMainnet(chainId)
          ? postVerifyMerkleProofMainnet
          : postVerifyMerkleProofTestnet;

  static String postVerifyMerkleProofTestnet =
      minerDappTestnet + verifyMerkleProof;
  static String postVerifyMerkleProofMainnet =
      minerDappMainnet + verifyMerkleProof;

  static const String verifyMerkleProof = 'api/verifier/verifyMerkleProof';

  static const String minerDappApiTestnet =
      'https://wannsee-mining-api.matchx.io/';
  static const String minerDappApiMainnet = 'https://mining-api.matchx.io/';

  static const minerDappTestnet = 'https://wannsee-mining.matchx.io/';
  static const minerDappMainnet = 'https://mining.matchx.io/';

  static String networkL3Bridge(int chainId) =>
      Config.isMXCMainnet(chainId) ? mainnetL3Bridge : testnetL3Bridge;

  static String getMepGraphQlLink(int chainId) =>
      Config.isMXCMainnet(chainId) ? mepGraphQlMainnet : mepGraphQlGNova;

  static String mepGraphQlMainnet =
      'https://mxc-graph.mxc.com/subgraphs/name/mxczkevm/mep1004-graph';
  static String mepGraphQlGNova =
      'https://mxc-graph-node.mxc.com/subgraphs/name/mxczkevm/mep1004-graph';
}
