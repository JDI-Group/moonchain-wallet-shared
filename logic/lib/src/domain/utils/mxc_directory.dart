import 'dart:io';

class MXCDirectory {
  Future<bool> directoryExistsMethod(String path) async {
    Directory directory = Directory(path);
    return await directory.exists();
  }
}
