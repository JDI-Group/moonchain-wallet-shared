import 'package:mxc_logic/mxc_logic.dart';

class Config {
  // App related config
  static const int mxcMainnetChainId = 18686;
  static const int mxcTestnetChainId = 5167004;
  static const int mchTestnetChainId = 177888;
  static const int mchMainnetChainId = 999888;
  static const int ethereumMainnetChainId = 1;
  static const int bnbMainnetChainId = 56;
  static const int ethDecimals = 18;

  static String getLogoUri(int chainId)  =>
      MXCFunctionHelpers.mxcChainsSeparatedFunctions<String>(
        chainId: chainId,
        mxcMainnetFunc: () => mxcLogoUri,
        mchMainnetFunc: () => mchLogoUri,
        mchTestnetFunc: () => mchLogoUri,
      );

  static const String mxcLogoUri = 'assets/svg/networks/mxc.svg';
  static const String mchLogoUri = 'assets/svg/networks/mch.svg';
  static const priority = 1.1;
  static EtherAmount maxPriorityFeePerGas = MxcAmount.fromDoubleByGWei(1.5);
  static const dappSectionFeeDivision = 1.5;
  // Used for cancel & speed up
  static double extraGasPercentage = 1.1;
  static double minerClaimTransactionGasMultiply = 1.3;
  // Miner dApp transactions gas limit
  static const double minerDAppGasLimit = 750000;
  static const int h3Resolution = 7;

  static const Duration httpClientTimeOut = Duration(seconds: 30);
  static const Duration weakInternetConnectionCheckDuration = Duration(minutes: 2);

  // Numbers fixed decimals
  static int decimalShowFixed = 3;
  static int decimalWriteFixed = 8;

  /// It's in days
  static int transactionsHistoryLimit = 7;

  static double dAppDoubleTapLowerBound = 0;
  static double dAppDoubleTapUpperBound = 200;

  static int edgeScrollingSensitivity = 40;
  static Duration dragScrollingDuration = const Duration(seconds: 1);

  static const breakingHyphen = '-';
  static const nonBreakingHyphen = '\u2011';

  // Google drive config 
  static const googleDriveFolderName = 'MoonBase';
  static const googleDriveFolderMime = 'application/vnd.google-apps.folder';

  // ICloud config 
  static const iCloudContainerId = 'iCloud.moonchain.mxc';
  static const iCloudFolderName = 'MoonBase';

  // AI agent name 
  static const aiAgentName = 'MoonChain AI';
}
