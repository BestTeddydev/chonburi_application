import 'package:chonburi_mobileapp/modules/food/models/food_model.dart';
import 'package:chonburi_mobileapp/utils/helper/dio.dart';
import 'package:dio/dio.dart';

class FoodService {
  static Future<List<FoodModel>> fetchsFood(String businessId) async {
    List<FoodModel> foods = [];
    Response response = await DioService.dioGet('/guest/foods?businessId=$businessId');
    for (var food in response.data) {
      FoodModel foodModel = FoodModel.fromMap(food);
      foods.add(foodModel);
    }
    return foods;
  }

  static Future<FoodModel> createFood(String token, FoodModel foodModel) async {
    Response response = await DioService.dioPostAuthen(
      '/food',
      token,
      foodModel.toMap(),
    );
    FoodModel food = FoodModel.fromMap(response.data);
    return food;
  }

  static Future<void> editFood(String token,FoodModel foodModel) async {
    await DioService.dioPut('/food/${foodModel.id}', token, foodModel.toMap());
  }

  static Future<void> deleteFood(String token ,String docId) async {
    await DioService.dioDelete('/food/$docId', token);
  }
}
