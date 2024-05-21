import 'dart:io';
import 'package:path/path.dart' as pathTool;

class MXCDirectory {
  static Future<bool> directoryExists(
    String path, {
    bool hasFileName = false,
  }) async {
    path = hasFileNameHandler(hasFileName, path);
    Directory directory = Directory(path);
    return await directory.exists();
  }

  static Future<Directory> createDirectory(
    String path, {
    bool hasFileName = false,
  }) async {
    path = hasFileNameHandler(hasFileName, path);
    Directory directory = Directory(path);
    return await directory.create();
  }

  static String hasFileNameHandler(bool hasFileName, String path) {
    if (hasFileName) {
      return pathTool.dirname(path);
    } else {
      return path;
    }
  }
}
