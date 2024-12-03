import 'package:flutter/material.dart';

class JSChannelUtils {
  static Future<String> loadJSBluetoothScript(BuildContext context) async {
    return await DefaultAssetBundle.of(context).loadString('assets/js/bluetooth/bluetooth.js');
  }
}
