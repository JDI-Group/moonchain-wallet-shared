class JSChannelEvents {
  static const String axsReadyEvent = 'axsReady';

  static const String changeCronTransitionEvent = 'changeCronTransition';
  static const String changeCronTransitionStatusEvent =
      'changeCronTransitionStatus';
  static const String getSystemInfoEvent = 'getSystemInfo';
  static const String goToAdvancedSettingsEvent = 'goToAdvancedSettings';

  static const String axsWalletCopyClipboard = 'axs-wallet-copy-clipboard';
  static const String axsWalletScrollDetector = 'axs-wallet-scroll-detector';

  // bluetooth events 
  static const String requestDevice = 'requestDevice';
  
  // bluetooth objects events
  // BluetoothDevice
  static const String bluetoothDeviceWatchAdvertisements = 'BluetoothDevice.watchAdvertisements';
  static const String bluetoothDeviceForget = 'BluetoothDevice.forget';

  // BluetoothRemoteGATTService
  static const String bluetoothRemoteGATTServiceGetCharacteristic = 'BluetoothRemoteGATTService.getCharacteristic';

  // BluetoothRemoteGATTServer
  static const String bluetoothRemoteGATTServerConnect ='BluetoothRemoteGATTServer.connect';
  static const String bluetoothRemoteGATTServerGetPrimaryService = 'BluetoothRemoteGATTServer.getPrimaryService';
  // .disconnect
  // .getPrimaryServices

  // BluetoothRemoteGATTCharacteristic
  static const String bluetoothRemoteGATTCharacteristicStartNotifications = 'BluetoothRemoteGATTCharacteristic.startNotifications';
  static const String bluetoothRemoteGATTCharacteristicStopNotifications = 'BluetoothRemoteGATTCharacteristic.stopNotifications';
}
