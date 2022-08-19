import 'package:chonburi_mobileapp/utils/helper/dio.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class UploadService {
  static Future<String> singleFile(String filePath) async {
    try {
      String fileName = basename(filePath);
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          filePath,
          filename: fileName,
          contentType: MediaType(
            'jpg',
            'image',
          ),
        ),
      });
      await DioService.dioPost('/upload/file/single', formData);
      return fileName;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<List<String>> multipleFile(List<String> filePath) async {
    List<String> fileNames = [];
    List<MultipartFile> files = [];
    for (int i = 0; i < filePath.length; i++) {
      fileNames.add(
        basename(filePath[i]),
      );
      MultipartFile file = await MultipartFile.fromFile(
        filePath[i],
        filename: fileNames[i],
        contentType: MediaType(
          'jpg',
          'image',
        ),
      );
      files.add(file);
    }
    FormData formData = FormData.fromMap({"images": files});
    await DioService.dioPost('/upload/file/multiple', formData);
    return fileNames;
  }
}
