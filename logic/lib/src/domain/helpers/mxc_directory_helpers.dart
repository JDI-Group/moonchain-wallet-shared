import 'dart:io';

import 'package:mxc_logic/mxc_logic.dart';

class MXCDirectoryHelpers {
  static Future<bool> doesIOSDownloadsDirExist() async {
    final path = await AssetsPath.iosDownloadsDir;
    final exists = await MXCDirectory.directoryExists(path);

    return exists;
  }

  static Future<Directory> createIOSDownloadsDir() async {
    final path = await AssetsPath.iosDownloadsDir;
    return MXCDirectory.createDirectory(path);
  }
}
