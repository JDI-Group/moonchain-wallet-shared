import 'dart:async';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:icloud_storage/icloud_storage.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/data/api/client/web3_client.dart';
import 'package:path/path.dart';

class ICloudRepository {
  ICloudRepository(
    this._web3Client,
  ) : _restClient = _web3Client.restClient;

  final DatadashClient _web3Client;
  final Client _restClient;

  Future<void> uploadBackup(String mnemonic) async {
    final localFile = await MXCFileHelpers.writeToTempFile(mnemonic);
    final fileName = basename(localFile.absolute.path);
    StreamSubscription<double>? uploadProgressSub;

    try {
      await ICloudStorage.upload(
        containerId: Config.iCloudContainerId,
        filePath: localFile.path,
        destinationRelativePath: '${Config.iCloudFolderName}/$fileName',
        onProgress: (stream) {
          uploadProgressSub = stream.listen(
            (progress) => print('Upload File Progress: $progress'),
            onDone: () => print('Upload File Done'),
            onError: (err) => print('Upload File Error: $err'),
            cancelOnError: true,
          );
        },
      );

      // Since the upload function doesn't wait for the upload to complete.
      await uploadProgressSub!.asFuture();
    } catch (e) {
      if (e is PlatformException) {
        if (e.code == PlatformExceptionCode.iCloudConnectionOrPermission) {
          throw 'Platform Exception: iCloud container ID is not valid, or user is not signed in for iCloud, or user denied iCloud permission for this app';
        } else if (e.code == PlatformExceptionCode.fileNotFound) {
          throw 'File not found';
        } else {
          throw 'Platform Exception: ${e.message}; Details: ${e.details}';
        }
      } else {
        throw e.toString();
      }
    }
  }

  Future<String> readBackupFile() async {
    final localFile = await MXCFileHelpers.writeToTempFile('');
    final fileName = AssetsPath.tempSeedPhaseFileName;
    StreamSubscription<double>? downloadProgressSub;

    try {
      await ICloudStorage.download(
        containerId: Config.iCloudContainerId,
        relativePath: '${Config.iCloudFolderName}/$fileName',
        destinationFilePath: localFile.path,
        onProgress: (stream) {
          downloadProgressSub = stream.listen(
            (progress) => print('Download File Progress: $progress'),
            onDone: () => print('Download File Done'),
            onError: (err) => print('Download File Error: $err'),
            cancelOnError: true,
          );
        },
      );

      await downloadProgressSub!.asFuture();
    } catch (e) {
      if (e is PlatformException) {
        if (e.code == PlatformExceptionCode.iCloudConnectionOrPermission) {
          throw 'Platform Exception: iCloud container ID is not valid, or user is not signed in for iCloud, or user denied iCloud permission for this app';
        } else if (e.code == PlatformExceptionCode.fileNotFound) {
          throw 'File not found';
        } else {
          throw 'Platform Exception: ${e.message}; Details: ${e.details}';
        }
      } else {
        throw e.toString();
      }
    }

    return localFile.readAsString();
  }
}
