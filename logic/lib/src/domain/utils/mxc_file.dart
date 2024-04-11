import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class MXCFile {
  static List<FileSystemEntity> getFiles(
    String path,
  ) {
    return Directory(path).listSync();
  }

  static Future<ByteData> getFileFromAssets(
    String path,
  ) async {
    return await rootBundle.load(path);
  }

  static Future<Uint8List> getFileFromAssetsToUint8list(
    String path,
  ) async {
    final data = await getFileFromAssets(path);
    return data.buffer.asUint8List();
  }

  static Future<String> readFileFromAssets(
    String path,
  ) async {
    return await rootBundle.loadString(path);
  }
}
