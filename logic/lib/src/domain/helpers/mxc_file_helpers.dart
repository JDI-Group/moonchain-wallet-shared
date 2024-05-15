import 'dart:io';

import 'package:mxc_logic/mxc_logic.dart';

class MXCFileHelpers {
  static Future<String> getDAppStoreJson() async {
    const fileName = Assets.dappStoreJson;
    return await MXCFile.readFileFromAssets(fileName);
  }

  static Future<String> getDAppJson(String appName) async {
    final fileName = Assets.dappStore(appName);
    return await MXCFile.readFileFromAssets(fileName);
  }

  static Future<String> getTokenList(int chainId) =>
      MXCFunctionHelpers.chainsSeparatedFunctions<Future<String>>(
        chainId: chainId,
        moonChainFunc: () => _getMoonchainTokenList(),
        genevaFunc: () => _getGenevaTokenList(),
        ethereumFunc: () => _getEthereumTokenList(),
      );

  static Future<String> _getMoonchainTokenList() async {
    const fileName = Assets.moonchainTokenListPath;
    return await MXCFile.readFileFromAssets(fileName);
  }

  static Future<String> _getGenevaTokenList() async {
    const fileName = Assets.genevaTokenListPath;
    return await MXCFile.readFileFromAssets(fileName);
  }

  static Future<String> _getEthereumTokenList() async {
    const fileName = Assets.ethereumTokenListPath;
    return await MXCFile.readFileFromAssets(fileName);
  }

  static Future<String> getIpfsGatewayListJson() async {
    const fileName = Assets.ipfsGatewayListJsonPath;
    return await MXCFile.readFileFromAssets(fileName);
  }

  static Future<String> getTweetsListJson() async {
    const fileName = Assets.tweetsListJsonPath;
    return await MXCFile.readFileFromAssets(fileName);
  }

  static getFileContent(String path) async =>
      await MXCFile.getFileContent(path);

  static Future<String> writeFileContent(
    String path,
    String content, {
    bool recursive = false,
  }) async =>
      await MXCFile.writeFileContent(path, content, recursive: recursive);

  static Future<String> getSeedPhase() async {
    String filePath;
    if (Platform.isAndroid) {
      try {
        filePath = Assets.seedPhasePathAndroid(0);
        return getFileContent(filePath);
      } catch (e) {
        filePath = Assets.seedPhasePathAndroid(1);
        return getFileContent(filePath);
      }
    } else {
      // IOS
      filePath = await Assets.seedPhasePathIOS();
      return getFileContent(filePath);
    }
  }

  static Future<String> writeSeedPhase(String content) async {
    String filePath;
    if (Platform.isAndroid) {
      try {
        filePath = Assets.seedPhasePathAndroid(0);
        return writeFileContent(filePath, content);
      } catch (e) {
        filePath = Assets.seedPhasePathAndroid(1);
        return writeFileContent(filePath, content);
      }
    } else {
      // IOS
      filePath = await Assets.seedPhasePathIOS();
      return writeFileContent(filePath, content, recursive: true);
    }
  }
}
