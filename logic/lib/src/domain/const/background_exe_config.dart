class BackgroundExecutionConfig {
  /// The frequency in which background process will be
  /// executed, NOTE : It's in minutes.
  static const mxcWalletBackgroundServiceInterval = 15;

  static const String notificationsTask =
      'com.transistorsoft.notificationsTask';
  static const String wifiHooksTask = 'com.transistorsoft.wifiHooksTask';
  static const String minerAutoClaimTask =
      'com.transistorsoft.minerAutoClaimTask';
  static const String blueberryAutoSyncTask =
      'com.transistorsoft.blueberryAutoSyncTask';

  static DateTime defaultTimeForMinerDapp = DateTime(2024, 1, 1, 13, 0, 0);

  static String wifiHooksDataV = 'v1';
}
