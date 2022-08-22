import 'package:chonburi_mobileapp/modules/product/models/product_models.dart';
import 'package:chonburi_mobileapp/utils/helper/dio.dart';
import 'package:dio/dio.dart';

class ProductService {
  static Future<List<ProductModel>> fetchsProduct(String businessId) async {
    List<ProductModel> products = [];
    Response response = await DioService.dioGet('/guest/products?businessId=$businessId');
    for (var product in response.data) {
      ProductModel productModel = ProductModel.fromMap(product);
      products.add(productModel);
    }
    return products;
  }

  static Future<ProductModel> createProduct(String token, ProductModel productModel) async {
    Response response = await DioService.dioPostAuthen(
      '/product',
      token,
      productModel.toMap(),
    );
    ProductModel food = ProductModel.fromMap(response.data);
    return food;
  }

  static Future<void> editProduct(String token,ProductModel productModel) async {
    await DioService.dioPut('/product/${productModel.id}', token, productModel.toMap());
  }

  static Future<void> deleteProduct(String token ,String docId) async {
    await DioService.dioDelete('/product/$docId', token);
  }
}