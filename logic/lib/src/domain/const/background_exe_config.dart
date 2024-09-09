class BackgroundExecutionConfig {
  /// The frequency in which background process will be
  /// executed, NOTE : It's in minutes.
  static const mxcWalletBackgroundServiceInterval = 15;

  static const String notificationsTask =
      'com.mxc.moonchainWallet.notificationsTask';
  static const String wifiHooksTask = 'com.mxc.moonchainWallet.wifiHooksTask';
  static const String minerAutoClaimTask =
      'com.mxc.moonchainWallet.minerAutoClaimTask';
  static const String blueberryAutoSyncTask =
      'com.mxc.moonchainWallet.blueberryAutoSyncTask';

  static DateTime defaultTimeForMinerDapp = DateTime(2024, 1, 1, 13, 0, 0);

  static String wifiHooksDataV = 'v1';
}
