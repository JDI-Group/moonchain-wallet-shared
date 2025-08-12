import 'package:mxc_logic/mxc_logic.dart';

class MXCAssetsHelpers {
  static String changeTokensRemoteUrlToLocal(String cPath) {
    return '${AssetsPath.tokenListAssetsPath}${cPath.split('/').last}';
  }
}
