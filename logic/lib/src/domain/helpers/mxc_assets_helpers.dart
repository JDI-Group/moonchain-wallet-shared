import 'package:mxc_logic/mxc_logic.dart';

class MXCAssetsHelpers {
  static String changeTokensRemoteUrlToLocal(String cPath) {
    return '${Assets.tokenListAssetsPath}${cPath.split('/').last}';
  }
}
