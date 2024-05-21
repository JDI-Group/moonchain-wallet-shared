import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class Assets {
  static const String mxcLogic = 'mxc_logic';

  static const String dappStorePath =
      'packages/$mxcLogic/assets/cache/MEP-1759-DApp-store/';
  static const String dappStoreJson = '${dappStorePath}dapp-store.json';
  static String dappStore(String dappName) =>
      '${dappStorePath}dapp_store/$dappName';
  static String dappsThumbnail(String image) =>
      '${dappStorePath}mxc_dapps_thumbnails/$image.png';

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
      '${DateFormat('yyyy-MM-dd--HH-mm-ss').format(DateTime.now())}-axs-key.txt';
  static String get download => '/storage/emulated/0/Download';
  static String get downloads => '/storage/emulated/0/Downloads';

  static String downloadPathAndroid(int attempt) =>
      attempt == 0 ? download : downloads;

  /// attempt can be 1 or 2 if 1 download - downloads
  static String seedPhasePathAndroid(int attempt) =>
      '${downloadPathAndroid(attempt)}/$seedPhaseFileName';
  static Future<String> seedPhasePathIOS() async =>
      '${(await getApplicationDocumentsDirectory()).path}/Downloads/$seedPhaseFileName';
}
