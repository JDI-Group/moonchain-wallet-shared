import 'package:mxc_logic/mxc_logic.dart';

class MXCFormatter {

  static String checkExpoNumber(String value) {
    return MXCValidation.isExpoNumber(value)
        ? '0.000'
        : value;
  }
}