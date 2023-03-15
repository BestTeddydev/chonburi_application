import 'package:chonburi_mobileapp/modules/custom_package/models/order_custom.dart';
import 'package:chonburi_mobileapp/utils/helper/dio.dart';
import 'package:dio/dio.dart';

class OrderCustomService {
  static Future<void> createOrderCustom(
      OrderCustomModel order, String token) async {
    await DioService.dioPostAuthen('/custom/package', token, order.toMap());
  }

  static Future<List<OrderCustomModel>> fetchOrderCustoms(
      String token, String userId, String businessId) async {
    String url = '/custom/package';
    if (userId.isNotEmpty) {
      url = '/custom/package?userId=$userId';
    }
    if (businessId.isNotEmpty) {
      url = '/custom/package?businessId=$businessId';
    }

    List<OrderCustomModel> orders = [];
    Response response = await DioService.dioGetAuthen(url, token);
    for (var order in response.data) {
      OrderCustomModel orderPackageModel = OrderCustomModel.fromMap(order);
      orders.add(orderPackageModel);
    }
    return orders;
  }

  static Future<OrderCustomModel> fetchOrderCustom(
    String token,
    String docId,
  ) async {
    Response response =
        await DioService.dioGetAuthen('/custom/package/$docId', token);
    OrderCustomModel order = OrderCustomModel.fromMap(response.data);
    return order;
  }

  static Future<void> actionOrderActivity(
      String token, String docId, String status, String businessId) async {
    await DioService.dioPut('/custom/package/activity/$docId', token, {
      "status": status,
      "businessId": businessId,
    });
  }

  static Future<void> approveOrderCustom(
    String token,
    String docId,
    String status,
  ) async {
    await DioService.dioPut(
        '/custom/package/$docId', token, {"status": status});
  }

  static Future<void> billOrderCustom(
    String token,
    String docId,
    String status,
    String pathImage,
  ) async {
    await DioService.dioPut('/custom/package/attact/$docId', token, {
      "status": status,
      "receiptImage": pathImage,
    });
  }
}
