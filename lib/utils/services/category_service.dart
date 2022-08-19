import 'package:chonburi_mobileapp/modules/category/models/category_model.dart';
import 'package:chonburi_mobileapp/utils/helper/dio.dart';
import 'package:dio/dio.dart';

class CategoryService {
  static Future<List<CategoryModel>> fetchCategoryBusiness(
    String businessId,
  ) async {
    Response response = await DioService.dioGet('/guest/category/$businessId');
    List<CategoryModel> categories = [];
    for (var category in response.data) {
      CategoryModel categoryModel = CategoryModel.fromMap(category);
      categories.add(categoryModel);
    }
    return categories;
  }

  static Future<CategoryModel> createCategory(
    String token,
    CategoryModel category,
  ) async {
    Response response = await DioService.dioPostAuthen(
      '/category',
      token,
      category.toMap(),
    );
    CategoryModel categoryModel = CategoryModel.fromMap(response.data);
    return categoryModel;
  }

  static Future<void> editCategory(String token, CategoryModel category) async {
    await DioService.dioPut('/category/${category.id}', token, category.toMap());
  }

  static Future<void> deleteCategory(String token, String docId) async {
    await DioService.dioDelete('/category/$docId', token);
  }
}
