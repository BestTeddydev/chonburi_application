import 'package:chonburi_mobileapp/modules/booking_room/models/booking_model.dart';
import 'package:chonburi_mobileapp/utils/helper/dio.dart';
import 'package:dio/dio.dart';

class BookingService {
  static Future<List<BookingModel>> fetchsBooking(
      String? query, String token, String typeQuery) async {
    List<BookingModel> orders = [];
    Response response =
        await DioService.dioGetAuthen('/booking?$typeQuery=$query', token);
    for (var order in response.data) {
      BookingModel orderOtopModel = BookingModel.fromMap(order);

      orders.add(orderOtopModel);
    }
    return orders;
  }

  static Future<void> createBooking(String token, BookingModel order) async {
    await DioService.dioPostAuthen(
      '/booking',
      token,
      order.toMap(),
    );
  }

  static Future<void> editBooking(
      String path, String token, BookingModel order) async {
    await DioService.dioPut(path, token, order.toMap());
  }
}
