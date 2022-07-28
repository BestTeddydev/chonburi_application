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
}
