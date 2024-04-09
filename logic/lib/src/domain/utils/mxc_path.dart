import 'dart:io';
import 'package:path_provider/path_provider.dart';

class MXCPath {
  // Application document directory (assets)
  static Future<String> getApplicationDocDirectory() async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  // Gets a file from assets directory
  static Future<File> getAssetsDirectoryFile(String fileName) async {
    final path = await getApplicationDocDirectory();

    return File('$path/$fileName');
  }
}
