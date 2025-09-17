import 'dart:io';

import 'package:mxc_logic/mxc_logic.dart';
import 'package:path_provider/path_provider.dart';

class MXCFileHelpers {
  static Future<String> getDAppStoreJson() async {
    const fileName = AssetsPath.dappStoreJson;
    return await MXCFile.readFileFromAssets(fileName);
  }

  static Future<String> getDAppJson(String appName) async {
    final fileName = AssetsPath.dappStore(appName);
    return await MXCFile.readFileFromAssets(fileName);
  }

  static Future<String> getTokenList(int chainId) =>
      MXCFunctionHelpers.chainsSeparatedFunctions<Future<String>>(
        chainId: chainId,
        mxcMainnetFunc: () => _getMXCMainnetTokenList(),
        mchMainnetFunc: () => _getMCHMainnetTokenList(),
        mchTestnetFunc: () => _getMCHTestnetTokenList(),
        ethereumFunc: () => _getEthereumTokenList(),
      );

  static Future<String> _getMXCMainnetTokenList() async {
    const fileName = AssetsPath.mxcMainnetTokenListPath;
    return await MXCFile.readFileFromAssets(fileName);
  }

  static Future<String> _getMCHMainnetTokenList() async {
    const fileName = AssetsPath.mchMainnetTokenListPath;
    return await MXCFile.readFileFromAssets(fileName);
  }

  static Future<String> _getMCHTestnetTokenList() async {
    const fileName = AssetsPath.mchTestnetTokenListPath;
    return await MXCFile.readFileFromAssets(fileName);
  }

  static Future<String> _getEthereumTokenList() async {
    const fileName = AssetsPath.ethereumTokenListPath;
    return await MXCFile.readFileFromAssets(fileName);
  }

  static Future<String> getIpfsGatewayListJson() async {
    const fileName = AssetsPath.ipfsGatewayListJsonPath;
    return await MXCFile.readFileFromAssets(fileName);
  }

  static Future<String> getTweetsListJson() async {
    const fileName = AssetsPath.tweetsListJsonPath;
    return await MXCFile.readFileFromAssets(fileName);
  }

  static Future<String> writeFileContent(
    String path,
    String content, {
    bool recursive = false,
  }) async =>
      await MXCFile.writeFileContent(path, content, recursive: recursive);

  // Writes to permanent file (Based on the OS) and returns the path
  static Future<String> writeSeedPhase(String content) async {
    String filePath;
    if (Platform.isAndroid) {
      filePath = AssetsPath.seedPhasePathAndroid(0);
      final doesPathExist =
          await MXCDirectory.directoryExists(filePath, hasFileName: true);
      if (doesPathExist) {
        return await writeFileContent(filePath, content);
      } else {
        filePath = AssetsPath.seedPhasePathAndroid(1);
        return await writeFileContent(filePath, content);
      }
    } else {
      // IOS
      filePath = await AssetsPath.seedPhasePathIOS();
      return await writeFileContent(filePath, content, recursive: true);
    }
  }

  // Writes to temp file and returns the file
  static Future<File> writeToTempFile(
    String content,
  ) async {
    final tempDir = await getTemporaryDirectory();
    final fileName = AssetsPath.tempSeedPhaseFileName;

    final fullPath = '${tempDir.path}/$fileName';
    File file = await File(fullPath).create();
    await file.writeAsString(content);
    return file;
  }
}
