class BackgroundExecutionConfig {
  /// The frequency in which background process will be
  /// executed, NOTE : It's in minutes.
  static const axsBackgroundServiceInterval = 15;

  static const String notificationsTask = 'com.mxc.axswallet.notificationsTask';
  static const String wifiHooksTask = 'com.mxc.axswallet.wifiHooksTask';
  static const String minerAutoClaimTask =
      'com.mxc.axswallet.minerAutoClaimTask';
  static const String blueberryAutoSyncTask =
      'com.mxc.axswallet.blueberryAutoSyncTask';

  static DateTime defaultTimeForMinerDapp = DateTime(2024, 1, 1, 13, 0, 0);

  static String wifiHooksDataV = 'v1';
}
