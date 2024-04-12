import 'dart:typed_data';

import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/domain/const/assets.dart';

class MXCFileHelpers {
  static Future<String> getDAppStoreJson() async {
    const fileName = Assets.dappStoreJson;
    return await MXCFile.readFileFromAssets(fileName);
  }

  static Future<String> getDAppJson(String appName) async {
    final fileName = Assets.dappStore(appName);
    return await MXCFile.readFileFromAssets(fileName);
  }

}
