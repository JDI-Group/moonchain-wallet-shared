class JSChannelEvents {
  static const String axsReadyEvent = 'axsReady';

  static const String changeCronTransitionEvent = 'changeCronTransition';
  static const String changeCronTransitionStatusEvent =
      'changeCronTransitionStatus';
  static const String getSystemInfoEvent = 'getSystemInfo';
  static const String goToAdvancedSettingsEvent = 'goToAdvancedSettings';

  static const String mxcWalletCopyClipboard = 'mxc-wallet-copy-clipboard';
  static const String mxcWalletScrollDetector = 'mxc-wallet-scroll-detector';

  // bluetooth events
  static const String requestDevice = 'requestDevice';

  // Bluetooth objects events

  // BluetoothDevice
  static const String bluetoothDeviceWatchAdvertisements =
      'BluetoothDevice.watchAdvertisements';
  static const String bluetoothDeviceForget = 'BluetoothDevice.forget';

  // BluetoothRemoteGATTService
  static const String bluetoothRemoteGATTServiceGetCharacteristic =
      'BluetoothRemoteGATTService.getCharacteristic';
  static const String bluetoothRemoteGATTServiceGetCharacteristics =
      'BluetoothRemoteGATTService.getCharacteristics';
  static const String bluetoothRemoteGATTServiceGetIncludedService =
      'BluetoothRemoteGATTService.getIncludedService';
  static const String bluetoothRemoteGATTServiceGetIncludedServices =
      'BluetoothRemoteGATTService.getIncludedServices';

  // BluetoothRemoteGATTServer
  static const String bluetoothRemoteGATTServerConnect =
      'BluetoothRemoteGATTServer.connect';
  static const String bluetoothRemoteGATTServerDisconnect =
      'BluetoothRemoteGATTServer.disconnect';
  static const String bluetoothRemoteGATTServerGetPrimaryService =
      'BluetoothRemoteGATTServer.getPrimaryService';
  static const String bluetoothRemoteGATTServerGetPrimaryServices =
      'BluetoothRemoteGATTServer.getPrimaryServices';

  // BluetoothRemoteGATTCharacteristic
  static const String bluetoothRemoteGATTCharacteristicStartNotifications =
      'BluetoothRemoteGATTCharacteristic.startNotifications';
  static const String bluetoothRemoteGATTCharacteristicStopNotifications =
      'BluetoothRemoteGATTCharacteristic.stopNotifications';
  static const String bluetoothRemoteGATTCharacteristicGetDescriptor =
      'BluetoothRemoteGATTCharacteristic.getDescriptor';
  static const String bluetoothRemoteGATTCharacteristicGetDescriptors =
      'BluetoothRemoteGATTCharacteristic.getDescriptors';
  static const String bluetoothRemoteGATTCharacteristicReadValue =
      'BluetoothRemoteGATTCharacteristic.readValue';
  static const String bluetoothRemoteGATTCharacteristicWriteValue =
      'BluetoothRemoteGATTCharacteristic.writeValue';
  static const String bluetoothRemoteGATTCharacteristicWriteValueWithResponse =
      'BluetoothRemoteGATTCharacteristic.writeValueWithResponse';
  static const String
      bluetoothRemoteGATTCharacteristicWriteValueWithoutResponse =
      'BluetoothRemoteGATTCharacteristic.writeValueWithoutResponse';
}
