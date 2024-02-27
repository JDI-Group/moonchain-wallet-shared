enum AXSJSChannelResponseStatus { success, failed }

extension AXSJSChannelResponseStatusExtension on AXSJSChannelResponseStatus {
  static AXSJSChannelResponseStatus fromString(String value) {
    switch (value) {
      case 'success':
        return AXSJSChannelResponseStatus.success;
      case 'failed':
        return AXSJSChannelResponseStatus.failed;
      default:
        throw ArgumentError('Invalid string value for ExampleEnum: $value');
    }
  }
}
