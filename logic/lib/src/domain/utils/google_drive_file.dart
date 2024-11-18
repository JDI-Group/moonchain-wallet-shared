import 'package:googleapis/drive/v3.dart';
import 'package:mxc_logic/mxc_logic.dart';

class GoogleDriveFileUtils {
  GoogleDriveFileUtils(this.driveApi);

  final DriveApi driveApi;

  Future<File> createNewFolder() async {
    final File folder = File();
    folder.name = Config.googleDriveFolderName;
    folder.mimeType = Config.googleDriveFolderMime;
    return await driveApi.files.create(folder);
  }

  Future<String?> getFolderId() async {
    const folderName = Config.googleDriveFolderName;
    const folderMime = Config.googleDriveFolderMime;

    final found = await driveApi.files.list(
      q: "mimeType = '$folderMime' and name = '$folderName'",
      $fields: 'files(id, name)',
    );
    final files = found.files;

    if (files == null) {
      return null;
    }
    if (files.isEmpty) {
      final newFolder = await createNewFolder();
      return newFolder.id;
    }

    return files.first.id;
  }

  Future<File?> doesFileExist(String fileName) async {
    final folderId = await getFolderId();
    if (folderId == null) {
      return null;
    }

    final query =
        "name = '$fileName' and '$folderId' in parents and trashed = false";
    final driveFileList = await driveApi.files.list(
      q: query,
      spaces: 'drive',
      $fields: 'files(id, name, mimeType, parents)',
    );

    if (driveFileList.files != null && driveFileList.files!.isNotEmpty) {
      return driveFileList.files!.first;
    }

    return null;
  }
}
