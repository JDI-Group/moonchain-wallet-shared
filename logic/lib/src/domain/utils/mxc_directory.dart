import 'dart:io';
import 'package:path/path.dart' as pathTool;

class MXCDirectory {
  static Future<bool> directoryExists(
    String path, {
    bool hasFileName = false,
  }) async {
    if (hasFileName) {
      path = pathTool.dirname(path);
    }
    Directory directory = Directory(path);
    return await directory.exists();
  }
}
