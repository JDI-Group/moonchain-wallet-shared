import 'package:mxc_logic/mxc_logic.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

  static String getTokenListUrl(int chainId) =>
      MXCFunctionHelpers.chainsSeparatedFunctions<String>(
        chainId: chainId,
        mxcMainnetFunc: () => mxcMainnetTokenListUrl,
        mchMainnetFunc: () => mchMainnetTokenListUrl,
        mchTestnetFunc: () => mchTestnetTokenListUrl,
        ethereumFunc: () => ethereumMainnetTokenListUrl,
      );

  static String getTokenListRepoUrl(int chainId) =>
      MXCFunctionHelpers.chainsSeparatedFunctions<String>(
        chainId: chainId,
        mxcMainnetFunc: () => mxcMainnetTokenListRepoUrl,
        mchMainnetFunc: () => mchMainnetTokenListRepoUrl,
        mchTestnetFunc: () => mchTestnetTokenListRepoUrl,
        ethereumFunc: () => ethereumMainnetTokenListRepoUrl,
      );

  static const String mxcMainnetTokenListRepoUrl =
      'https://github.com/JDI-Group/moonchain-tokens/blob/main/tokenlist-mxc-mainnet.json';
  static const String mchMainnetTokenListRepoUrl =
      'https://github.com/JDI-Group/moonchain-tokens/blob/main/tokenlist-mch-mainnet.json';
  static const String mchTestnetTokenListRepoUrl =
      'https://github.com/JDI-Group/moonchain-tokens/blob/main/tokenlist-mch-testnet.json';
  static const String ethereumMainnetTokenListRepoUrl =
      'https://github.com/JDI-Group/moonchain-tokens/blob/main/tokenlist-ethereum-mainnet.json';

  static const String mxcMainnetTokenListUrl =
      'https://raw.githubusercontent.com/JDI-Group/moonchain-tokens/main/tokenlist-mxc-mainnet.json';
  static const String mchMainnetTokenListUrl =
      'https://raw.githubusercontent.com/JDI-Group/moonchain-tokens/main/tokenlist-mch-mainnet.json';
  static const String mchTestnetTokenListUrl =
      'https://raw.githubusercontent.com/JDI-Group/moonchain-tokens/main/tokenlist-mch-testnet.json';
  static const String ethereumMainnetTokenListUrl =
      'https://raw.githubusercontent.com/JDI-Group/moonchain-tokens/main/tokenlist-ethereum-mainnet.json';

  static const String defaultIpfsGateway =
      'https://raw.githubusercontent.com/JDI-Group/ipfs-list/refs/heads/main/ipfs_gateway_list.json';
  static const String defaultTweets =
      'https://raw.githubusercontent.com/JDI-Group/moonchain-tweets/refs/heads/main/tweets_list_v2.json';

  static const String dappStore =
      'https://raw.githubusercontent.com/JDI-Group/moonchain-dapp-store/main/dapp-store.json';
  static const String dapp =
      'https://raw.githubusercontent.com/JDI-Group/moonchain-dapp-store/main/dapp_store';

  // Remove the following method:
  // static String getLatestVersion(String appSecret, String groupId) =>
  //     'https://api.appcenter.ms/v0.1/public/sdk/apps/$appSecret/distribution_groups/$groupId/releases/latest';

  // Add this new static constant:
  static const String latestVersionYaml =
      'https://raw.githubusercontent.com/MXCzkEVM/moonchain-wallet/refs/heads/main/pubspec.yaml';

  static String getApiBaseUrl(int chainId) =>
      MXCFunctionHelpers.mxcChainsSeparatedFunctions(
        chainId: chainId,
        mainnetFunc: () => mainnetApiBaseUrl,
        testnetFunc: () => testnetApiBaseUrl,
      );

  static const String mxcMainnetApiBaseUrl =
      'https://explorer-v1.moonchain.com/api/v2/';
  static const String mchMainnetApiBaseUrl =
      'https://explorer-v1.mchain.ai/api/v2/';
  static const String mchTestnetApiBaseUrl =
      'https://hudson-explorer-v1.mchain.ai/api/v2/';

  static const String chainsList =
      'https://raw.githubusercontent.com/MXCzkEVM/chains-list/main/chains_list_v2.json';
  // static const String chainsList =
  //     'https://raw.githubusercontent.com/JDI-Group/chains-list/main/chains_list_v2.json';

  static getMXCNftMarketPlace(int chainId) =>
      MXCFunctionHelpers.mxcChainsSeparatedFunctions<String>(
        chainId: chainId,
        mainnetFunc: () => mxcMainnetNftMarketPlace,
        testnetFunc: () => mxcTestnetNftMarketPlace,
      );

  static const String mxcMainnetNftMarketPlace = 'https://nft.moonchain.com/';
  static const String mxcTestnetNftMarketPlace =
      'https://geneva-nft.moonchain.com/';
  static const String mxcStatus = 'https://mchain.instatus.com/';

  static const String dappRoot =
      'https://raw.githubusercontent.com/JDI-Group/moonchain-dapp-store/main/';

  static const String iOSUrl =
      'https://apps.apple.com/us/app/moonbase-the-mining-hub/id6736371768';

  static const String weChat = 'weixin://';
  static const String telegram = 'tg://';
  static const String emailApp = 'mailto:';

  // MXC support
  static const String moonchainSupportBot = 'https://t.me/MoonchainSupport_bot';
  static const String moonchainWebsite = 'https://moonchain.com/';
  static const String moonchainDesignDocs =
      'https://doc.moonchain.com/docs/intro/';

  /// Used to retrieve the latest epoch details
  static String mepEpochListTestnet(int page, int pageLimit) =>
      'https://geneva-mining-api.matchx.io/mep2542/getEpochList?page=$page&limit=$pageLimit';
  static String mepEpochListMainnet(int page, int pageLimit) =>
      'https://mining-api.matchx.io/mep2542/getEpochList?page=$page&limit=$pageLimit';

  static String mepEpochList(int chainId, int page, int pageLimit) {
    if (MXCChains.isMXCMainnet(chainId)) {
      return mepEpochListMainnet(page, pageLimit);
    }
    return mepEpochListTestnet(page, pageLimit);
  }

  static const String mxcWalletTermsConditions =
      'https://doc.moonchain.com/docs/Resources/tns/';
  static const String mxcWalletPrivacy = 'assets/pdf/privacy.pdf';

  static const String gateio = 'https://gate.io/';
  static const String okx = 'https://www.okx.com/';
  static const String kucoin = 'https://www.kucoin.com/';
  static const String cryptocom = 'https://crypto.com/';
  static const String bitget = 'https://bitget.com/';
  static const String bitmart = 'https://www.bitmart.com/en-US/';
  static const String htx = 'https://www.htx.com/';

  static const String mainnetJannowitz = 'https://jannowitz.moonchain.com/';
  static const String testnetJannowitz = 'https://geneva-bridge.moonchain.com/';

  static String mainnetMns(String name) =>
      'https://mns.moonchain.com/$name.mxc/register';
  static String testnetMns(String name) =>
      'https://geneva-mns.moonchain.com/$name.mxc/register';

  static String txExplorer(String hash) {
    return 'tx/$hash';
  }

  static String addressExplorer(String address) {
    return 'address/$address';
  }

  static String addressMinersByChainId(int chainId, String address) =>
      MXCChains.isMXCMainnet(chainId)
          ? addressMinersMainnet(address)
          : addressMinersTestnet(address);

  static String postMEP2542RewardInfo(int chainId) =>
      MXCChains.isMXCMainnet(chainId)
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
      MXCChains.isMXCMainnet(chainId)
          ? postVerifyMerkleProofMainnet
          : postVerifyMerkleProofTestnet;

  static String postVerifyMerkleProofTestnet =
      minerDappTestnet + verifyMerkleProof;
  static String postVerifyMerkleProofMainnet =
      minerDappMainnet + verifyMerkleProof;

  static const String verifyMerkleProof = 'api/verifier/verifyMerkleProof';

  static const String minerDappApiTestnet =
      'https://geneva-mining-api.matchx.io/';
  static const String minerDappApiMainnet = 'https://mining-api.matchx.io/';

  static const minerDappTestnet = 'https://geneva-mining.matchx.io/';
  static const minerDappMainnet = 'https://mining.matchx.io/';

  static String networkJannowitz(int chainId) =>
      MXCChains.isMXCMainnet(chainId) ? mainnetJannowitz : testnetJannowitz;

  static String getMepGraphQlLink(int chainId) =>
      MXCChains.isMXCMainnet(chainId) ? mepGraphQlMainnet : mepGraphQlGeneva;

  static String mepGraphQlMainnet =
      'https://mxc-graph.mxc.com/subgraphs/name/mxczkevm/mep1004-graph';
  static String mepGraphQlGeneva =
      'https://mxc-graph-node.mxc.com/subgraphs/name/mxczkevm/mep1004-graph';

  static String getBlueberryRingDapp(int chainId) =>
      MXCFunctionHelpers.mxcChainsSeparatedFunctions(
        chainId: chainId,
        mainnetFunc: () => mainnetBlueberryRingDapp,
        testnetFunc: () => testnetBlueberryRingDapp,
      );

  // Ring dapp urls
  static List<String> getRingDappUrls() =>
      [mainnetBlueberryRingDapp, testnetBlueberryRingDapp];

  // Ring
  static const String mainnetBlueberryRingDapp =
      'https://app.blueberryring.com/';
  static const String testnetBlueberryRingDapp =
      'https://testnet.blueberryring.com/';

  static const blueberryRingDappClaim = 'api/claim';

  static String getMNSSubGraphsUrl(int chainId) =>
      getMXCGraphNodeUrl(chainId) + mnsSubGraphs;

  static String getMXCGraphNodeUrl(int chainId) =>
      MXCFunctionHelpers.mxcChainsSeparatedFunctions(
        chainId: chainId,
        mainnetFunc: () => mainnetMXCGraphNode,
        testnetFunc: () => testnetMXCGraphNode,
      );

  static const String mainnetMXCGraphNode = 'https://mxc-graph.mxc.com/';
  static const String testnetMXCGraphNode =
      'https://geneva-graph-node.moonchain.com/';

  static const String mnsSubGraphs = 'subgraphs/name/mnsdomains/mns';

  static Uri getUri(String url) => Uri.parse(url);

  // AI
  static const String aiBaseEndpoint =
      'https://moonbaseservice.mchain.ai/v1/api/';
  static final Map<String, String> aiHeader = {
    'Authorization': 'Bearer ${dotenv.env['AI_API_KEY']!}',
    'Content-Type': 'application/json',
    'accept': 'application/json',
  };
  static Map<String, String> aiHeaderWithStream() {
    final aiHeaderUpdated = aiHeader;
    aiHeaderUpdated.addAll({'responseType': 'stream'});
    return aiHeaderUpdated;
  }

  static String newConversation(String userId) => '${aiBaseEndpoint}new_conversation?user_id=$userId';
  static const String completion = '${aiBaseEndpoint}completion';

  static const String reporterEndpoint = 'https://reporter.mchain.ai/';
  static const String reporterInfo = '${reporterEndpoint}info';
}
