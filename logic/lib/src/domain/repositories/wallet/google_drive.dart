import 'dart:convert';

import 'package:http/http.dart';
import 'package:mxc_logic/mxc_logic.dart';
import 'package:mxc_logic/src/data/api/client/google_http_client.dart';
import 'package:mxc_logic/src/data/api/client/web3_client.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:path/path.dart';

class GoogleDriveRepository {
  GoogleDriveRepository(
    this._web3Client,
  ) : _restClient = _web3Client.restClient;

  final DatadashClient _web3Client;
  final Client _restClient;

  Map<String, String>? _googleAuthHeaders;
  GoogleHttpClient? get client =>
      _googleAuthHeaders != null ? GoogleHttpClient(_googleAuthHeaders!) : null;
  DriveApi? get driveApi => client != null ? DriveApi(client!) : null;
  GoogleDriveFileUtils get _googleDriveFileUtils =>
      GoogleDriveFileUtils(driveApi!);

  Future<void> initGoogleAuthHeaders(
      Map<String, String>? _googleAuthHeaders) async {
    _googleAuthHeaders = _googleAuthHeaders;
  }

  Future<void> uploadBackup(String mnemonic) async {
    final localFile = await MXCFileHelpers.writeToTempFile(mnemonic);

    final File gDriveFile = File();
    gDriveFile.name = basename(localFile.absolute.path);

    final existingFile =
        await _googleDriveFileUtils.doesFileExist(gDriveFile.name!);

    if (existingFile != null) {
      await driveApi!.files.update(gDriveFile, existingFile.id!,
          uploadMedia: Media(localFile.openRead(), localFile.lengthSync()));
      return;
    }

    final folderId = await _googleDriveFileUtils.getFolderId();
    gDriveFile.parents = [folderId!];
    await driveApi!.files.create(
      gDriveFile,
      uploadMedia: Media(localFile.openRead(), localFile.lengthSync()),
    );
  }

  Future<String> readBackupFile() async {
    // final localFile = await MXCFileHelpers.writeToTempFile();

    // final File gDriveFile = File();
    // gDriveFile.name = basename(localFile.absolute.path);

    final fileName = Assets.tempSeedPhaseFileName;

    final existingFile = await _googleDriveFileUtils.doesFileExist(fileName);

    if (existingFile == null) {
      throw 'Backup file doesn\'t exist';
    }

    Media? downloadedFile;
    downloadedFile = await driveApi!.files.get(
      existingFile.id!,
      downloadOptions: DownloadOptions.fullMedia,
    ) as Media;

    // Read the byte stream from the file
    final stream = downloadedFile.stream;

    // Collect the stream as bytes
    List<int> bytes = [];
    await stream.forEach((chunk) {
      bytes.addAll(chunk);
    });

    // Convert to string (assuming the file is text-based)
    String content = utf8.decode(bytes);

    return content;
  }
}
