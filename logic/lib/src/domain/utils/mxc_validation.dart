
class MXCValidation {
  static bool isExpoNumber(String input) {
    RegExp regex = RegExp(r'^(\d+\.\d+e[-+]\d+)$');
    return regex.hasMatch(input);
  }

  static bool isDouble(String value) {
    final doubleValue = double.tryParse(value);

    if (doubleValue == null) {
      return false;
    }
    return true;
  }
}
