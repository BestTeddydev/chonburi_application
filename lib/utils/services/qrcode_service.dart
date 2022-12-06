import 'package:chonburi_mobileapp/utils/helper/dio.dart';
import 'package:dio/dio.dart';

class GenerateQRCodeService {
  static Future<String> getQRCodeURL(
      String accountNumber, double amount) async {
    Response<dynamic> resp = await DioService.dioGet(
        '/guest/generateQR?accountNumber=$accountNumber&amount=$amount');
    return resp.data["Result"] ?? "";
  }
}
