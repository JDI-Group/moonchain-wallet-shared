import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class AssetsPath {
  static const String mxcLogic = 'mxc_logic';

  static const String dappStorePath =
      'packages/$mxcLogic/assets/cache/MEP-1759-DApp-store/';
  static const String dappStoreJson = '${dappStorePath}dapp-store.json';
  static String dappStore(String dappName) =>
      '${dappStorePath}dapp_store/$dappName';
  static String dappsThumbnail(String image) =>
      '${dappStorePath}mxc_dapps_thumbnails/$image.png';
  static String dappsThumbnailV3(String icon) =>
      '${dappStorePath}mxc_dapps_thumbnails/icons_v3/$icon.svg';

  static const String tokenListPath =
      'packages/$mxcLogic/assets/cache/wannseeswap-tokenlist/';
  static const String tokenListAssetsPath = '${tokenListPath}assets/';
  static const String moonchainTokenListPath =
      '${tokenListPath}tokenlist-mainnet.json';
  static const String genevaTokenListPath = '${tokenListPath}tokenlist.json';
  static const String ethereumTokenListPath =
      '${tokenListPath}tokenlist-ethereum.json';

  static const String ipfsGatewayListPath =
      'packages/$mxcLogic/assets/cache/ipfs-gateway-list/';
  static const String ipfsGatewayListJsonPath =
      '${ipfsGatewayListPath}ipfs_gateway_list.json';

  static const String tweetsListPath =
      'packages/$mxcLogic/assets/cache/mxc-tweets-list/';
  static const String tweetsListJsonPath =
      '${tweetsListPath}tweets_list_v2.json';

  static String get seedPhaseFileName =>
      '${DateFormat('yyyy-MM-dd--HH-mm-ss').format(DateTime.now())}-moonchain-key.txt';
  // The name is const because while loading 
  // we need the exact name to check wether the file exists or not 
  static String get tempSeedPhaseFileName => 'moonchain-key.txt';
  static Future<String> get tempSeedPhraseFilePath async => (await getTemporaryDirectory()).path;

  static String get androidDownloadDir => '/storage/emulated/0/Download';
  static String get androidDownloadsDir => '/storage/emulated/0/Downloads';

  static String _downloadPathAndroid(int attempt) =>
      attempt == 0 ? androidDownloadDir : androidDownloadsDir;

  /// attempt can be 1 or 2 if 1 download - downloads
  static String seedPhasePathAndroid(int attempt) =>
      '${_downloadPathAndroid(attempt)}/$seedPhaseFileName';

  static Future<String> get iosDownloadsDir async =>
      '${(await getApplicationDocumentsDirectory()).path}/Downloads/';
  static Future<String> seedPhasePathIOS() async =>
      '${(await iosDownloadsDir)}$seedPhaseFileName';
}
