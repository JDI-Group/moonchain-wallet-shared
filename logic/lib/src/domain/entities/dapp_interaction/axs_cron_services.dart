
enum AXSCronServices { miningAutoClaimCron, blueberryRingCron }

extension AXSCronServicesExtension on AXSCronServices {
  static AXSCronServices fromString(String value) {
    switch (value) {
      case 'miningAutoClaimCron':
        return AXSCronServices.miningAutoClaimCron;
      case 'blueberryRingCron':
        return AXSCronServices.blueberryRingCron;        
      default:
        throw 'Unknown service';
    }
  }

  static AXSCronServices getCronServiceFromJson<T>(
    Map<String, dynamic> source,
  ) {
    final cronName = source['cron']['name'];
    if (cronName == null) throw 'Cron service name is empty';
    final axsCronService = AXSCronServicesExtension.fromString(cronName);
    return axsCronService;
  }
}
