import 'package:chonburi_mobileapp/modules/category/models/category_model.dart';
import 'package:chonburi_mobileapp/utils/helper/dio.dart';
import 'package:dio/dio.dart';

class CategoryService {
  static Future<List<CategoryModel>> fetchCategoryBusiness(String businessId) async{
    Response response = await DioService.dioGet('/guest/category/$businessId');
    List<CategoryModel> categories = [];
    return categories;
  }
}