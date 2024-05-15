import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class MXCFile {
  static List<FileSystemEntity> getFiles(
    String path,
  ) {
    return Directory(path).listSync();
  }

  static File getFile(
    String path,
  ) =>
      File(path);

  static Future<String> getFileContent(
    String path,
  ) {
    final file = getFile(path); 
    return file.readAsString();
  }

  static Future<String> writeFileContent(String path, String content, {bool recursive = false,}) async {
    File file = await getFile(path).create(recursive: recursive,);
    file = await file.writeAsString(content);
    return file.path;
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
