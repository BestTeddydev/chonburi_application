import 'package:chonburi_mobileapp/modules/auth/models/user_model.dart';
import 'package:chonburi_mobileapp/modules/register/models/user_register_model.dart';
import 'package:chonburi_mobileapp/utils/helper/dio.dart';
import 'package:dio/dio.dart';

class UserService {
  static Future<UserModel> login(String username, String password) async {
    Response<dynamic> response = await DioService.dioPost(
      '/user/login',
      {"username": username, "password": password},
    );
    UserModel userModel = UserModel.fromMap(response.data);
    return userModel;
  }

  static Future<void> registerUser(UserRegisterModel user) async {
    await DioService.dioPost('/user/register', user.toMap());
  }

  static Future<void> updateTokenDevice(
      String tokenDevice, String userId, String token) async {
    await DioService.dioPut(
      '/user/device/token/$userId',
      token,
      {"tokenDevice": tokenDevice},
    );
  }

  static Future<void> deleteAccount(String userId, String token) async {
    await DioService.dioPut(
      "/user/delete/account/$userId",
      token,
      {"userId": userId},
    ); // data ไม่ได้ใช้ เขียนไปงั้นๆ
  }

  static Future<void> changeProfile(
    String userId,
    String token,
    String username,
    String firstName,
    String lastName,
    String? password,
  ) async {
    await DioService.dioPut("/user/change/account/$userId", token, {
      "username": username,
      "firstName": firstName,
      "lastName": lastName,
      "password": password,
    });
  }
}
