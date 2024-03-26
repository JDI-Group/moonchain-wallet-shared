class MXCArray {
  static String sumUpListItemsValueBigInt(List<dynamic> array) {
    BigInt total = BigInt.from(0);
    for (var element in array) {
      if (element != null) {
        if (element is String && element.isNotEmpty) {
          if (element.contains('.')) {
            element = element.split('.')[0];
          }
          total += BigInt.parse(element);
        } else if (element is num) {
          total += BigInt.from(element);
        }
      }
    }
    return total.toString();
  }
}
