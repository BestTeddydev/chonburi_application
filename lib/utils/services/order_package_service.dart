import 'package:chonburi_mobileapp/modules/order_package/models/order_package.dart';
import 'package:chonburi_mobileapp/utils/helper/dio.dart';
import 'package:dio/dio.dart';

class OrderPackageService {
  static Future<void> createOrderPackage(
      OrderPackageModel order, String token) async {
    await DioService.dioPostAuthen('/order/package', token, order.toMap());
  }

  static Future<List<OrderPackageModel>> fetchOrderPackages(
      String token, String userId, String businessId) async {
    String url = '/order/package';
    if (userId.isNotEmpty) {
      url = '/order/package?userId=$userId';
    }
    if (businessId.isNotEmpty) {
      url = '/order/package?businessId=$businessId';
    }

    List<OrderPackageModel> orders = [];
    Response response = await DioService.dioGetAuthen(url, token);
    for (var order in response.data) {
      OrderPackageModel orderPackageModel = OrderPackageModel.fromMap(order);
      orders.add(orderPackageModel);
    }
    return orders;
  }

  static Future<OrderPackageModel> fetchOrderPackage(
    String token,
    String docId,
  ) async {
    Response response =
        await DioService.dioGetAuthen('/order/package/$docId', token);
    OrderPackageModel order = OrderPackageModel.fromMap(response.data);
    return order;
  }

  static Future<void> actionOrderActivity(
      String token, String docId, String status, String businessId) async {
    await DioService.dioPut('/custom/package/activity/$docId', token, {
      "status": status,
      "businessId": businessId,
    });
  }

  // cancel
  static Future<void> approveOrderPackage(
    String token,
    String docId,
    String status,
  ) async {
    await DioService.dioPut('/order/package/$docId', token, {"status": status});
  }

  // cancel
  static Future<void> billOrderPackage(
    String token,
    String docId,
    String status,
    String pathImage,
  ) async {
    await DioService.dioPut('/order/package/attact/$docId', token, {
      "status": status,
      "receiptImage": pathImage,
    });
  }
}
