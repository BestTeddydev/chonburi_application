import 'package:chonburi_mobileapp/modules/manage_room/models/room_models.dart';
import 'package:chonburi_mobileapp/utils/helper/dio.dart';
import 'package:dio/dio.dart';

class RoomService {
  static Future<List<RoomModel>> fetchsRoom(String businessId) async {
    List<RoomModel> foods = [];
    Response response =
        await DioService.dioGet('/guest/rooms?businessId=$businessId');
    for (var room in response.data) {
      RoomModel productModel = RoomModel.fromMap(room);
      foods.add(productModel);
    }
    return foods;
  }

  static Future<RoomModel> createRoom(
      String token, RoomModel roomModel) async {
    Response response = await DioService.dioPostAuthen(
      '/room',
      token,
      roomModel.toMap(),
    );
    RoomModel food = RoomModel.fromMap(response.data);
    return food;
  }

  static Future<void> editRoom(String token, RoomModel roomModel) async {
    await DioService.dioPut('/room/${roomModel.id}', token, roomModel.toMap());
  }

  static Future<void> deleteRoom(String token, String docId) async {
    await DioService.dioDelete('/room/$docId', token);
  }
}
