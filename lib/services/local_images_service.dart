import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class LocalImageService {
  static Future<String> getLocalImagePath(String imageUrl) async {
    if (imageUrl == null) return null;

    var directory = await getApplicationDocumentsDirectory();
    var imageName =
        imageUrl.substring(imageUrl.lastIndexOf("/") + 1, imageUrl.length);
    var localImagePath = '${directory.path}/local-$imageName';
    var directoryFiles = directory.listSync();
    var localImageFile = directoryFiles?.firstWhere(
        (element) => element?.path == localImagePath,
        orElse: () => null);
    if (localImageFile == null) {
      var newImageFile = File(localImagePath);
      try {
        var urlImageFile = await http.get(imageUrl);
        newImageFile.writeAsBytesSync(urlImageFile.bodyBytes);
      } catch (e) {
        return imageUrl;
      }
    }
    return localImagePath;
    // final stat = io.FileStat.statSync(element.path);
    // ////print('Accessed: ${stat.accessed}');
    // ////print('Modified: ${stat.modified}');
    // ////print('Changed:  ${stat.changed}');
  }

  static Future<bool> saveImageToPath(
      String networkPath, String localPath) async {
    if (localPath == null || networkPath == null) {
      return Future.value(false);
    }
    ////print(
//        "-------------------------------- CAME TO SAVE LOCAL => $networkPath => $localPath");
    var newImageFile = File(localPath);
    try {
      var urlImageFile = await http.get(networkPath);
      newImageFile.writeAsBytesSync(urlImageFile.bodyBytes);
      return Future.value(true);
    } catch (e) {
      ////print("-------------- e --------------");
      ////print(e);
      ////print("-------------- e --------------");
      return Future.value(false);
    }
  }

  static String transformToLocalPath(String imageUrl, String directory) {
    if (imageUrl == null) return null;
    var imageName =
        imageUrl.substring(imageUrl.lastIndexOf("/") + 1, imageUrl.length);
    var localImagePath = '$directory/local-$imageName';
    return localImagePath;
  }

  static Future<void> clearLocalImageFiles() async {
    var directory = await getApplicationDocumentsDirectory();
    directory.listSync().forEach((element) {
      final fileStat = FileStat.statSync(element.path);
      var date = DateTime.now().subtract(new Duration(days: 7));
      if (date.difference(fileStat.accessed).inHours < 0) {
        element.delete(recursive: true);
      }
    });
  }
}
