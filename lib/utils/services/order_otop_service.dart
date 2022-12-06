import 'package:chonburi_mobileapp/modules/tracking_order_otop/models/order_otop_model.dart';
import 'package:chonburi_mobileapp/utils/helper/dio.dart';
import 'package:dio/dio.dart';

class OrderOtopService {
  static Future<List<OrderOtopModel>> fetchsOrderOtop(
      String? userId, String token, String query) async {
    List<OrderOtopModel> orders = [];
    Response response =
        await DioService.dioGetAuthen('/order/product?$query=$userId', token);
    for (var order in response.data) {
      print('print order $order');
      OrderOtopModel orderOtopModel = OrderOtopModel.fromMap(order);
      orders.add(orderOtopModel);
    }
    return orders;
  }

  static Future<void> createOrderOtop(
      String token, OrderOtopModel order) async {
    await DioService.dioPostAuthen(
      '/order/product',
      token,
      order.toMap(),
    );
  }

  static Future<void> editOrderOtop(
      String path, String token, OrderOtopModel order) async {
    await DioService.dioPut(path, token, order.toMap());
  }
}
