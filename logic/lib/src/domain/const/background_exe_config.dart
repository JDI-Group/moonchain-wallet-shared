class BackgroundExecutionConfig {
  /// The frequency in which background process will be
  /// executed, NOTE : It's in minutes.
  static const mxcWalletBackgroundServiceInterval = 15;

  static const String notificationsTask =
      'com.moonchain.mxc.notificationsTask';
  static const String wifiHooksTask = 'com.moonchain.mxc.wifiHooksTask';
  static const String minerAutoClaimTask =
      'com.moonchain.mxc.minerAutoClaimTask';
  static const String blueberryAutoSyncTask =
      'com.moonchain.mxc.blueberryAutoSyncTask';

  static DateTime defaultTimeForMinerDapp = DateTime(2024, 1, 1, 13, 0, 0);

  static String wifiHooksDataV = 'v1';
}
