import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

class FileUtils {
  openExternalFile(String filePath) async {
    //open an external storage file
    if (await Permission.manageExternalStorage.request().isGranted) {
      final result = await OpenFile.open(filePath);
    }
  }

  openAppPrivateFile(String filePath) async {
    //open an app private storage file
    final result = await OpenFile.open(filePath);
  }
}
