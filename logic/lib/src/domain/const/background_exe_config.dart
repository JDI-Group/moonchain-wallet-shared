class BackgroundExecutionConfig {
  /// The frequency in which background process will be
  /// executed, NOTE : It's in minutes.
  static const axsBackgroundServiceInterval = 15;

  static const String axsPeriodicalTask = 'com.mxc.axswallet.periodicalTasks';
  static const String dappHookTasks = 'com.mxc.axswallet.dappHooksTasks';
  static const String minerAutoClaimTask =
      'com.mxc.axswallet.minerAutoClaimTask';

  static DateTime defaultTimeForMinerDapp = DateTime(2024, 1, 1, 13, 0, 0);

  static String wifiHooksDataV = 'v1';
}
