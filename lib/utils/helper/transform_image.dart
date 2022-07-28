import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:chonburi_mobileapp/constants/api_path.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class TransfromImage {
  static Future<File> convertUrlToFile(String path) async {
    final imageUri = Uri.parse('${APIRoute.hostImage}$path');
    log('$imageUri');
    final http.Response responseData = await http.get(imageUri);
    Uint8List uint8list = responseData.bodyBytes;
    var buffer = uint8list.buffer;
    ByteData byteData = ByteData.view(buffer);
    var tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/$path').writeAsBytes(
      buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      ),
      flush: true,
    );
    return file;
  }

}
