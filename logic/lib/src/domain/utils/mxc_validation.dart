class MXCValidation{ 
    static bool isExpoNumber(String input) {
    RegExp regex = RegExp(r'^(\d+\.\d+e[-+]\d+)$');
    return regex.hasMatch(input);
  }
}