import 'dart:io';

import 'package:mxc_logic/mxc_logic.dart';

class DirectoryUseCase {
  DirectoryUseCase();

  Future<void> checkDownloadsDirectoryDirectory() async {
    if (Platform.isIOS) {
      final exists = await MXCDirectoryHelpers.doesIOSDownloadsDirExist();
      if (!exists) {
        await MXCDirectoryHelpers.createIOSDownloadsDir();
      }
    }
  }
}
