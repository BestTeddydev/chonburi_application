import 'package:chonburi_mobileapp/modules/manage_businesses/models/place_model.dart';
import 'package:chonburi_mobileapp/utils/helper/dio.dart';
import 'package:dio/dio.dart';

class PlaceService {
  static Future<List<PlaceModel>> fetchsMyPlaces(String token) async {
    List<PlaceModel> places = [];
    Response response = await DioService.dioGetAuthen('/place', token);
    for (var place in response.data) {
      PlaceModel placeModel = PlaceModel.fromMap(place);
      places.add(placeModel);
    }
    return places;
  }

  static Future<List<PlaceModel>> fetchsPlaces() async {
    List<PlaceModel> places = [];
    Response response = await DioService.dioGet('/guest/places');
    for (var place in response.data) {
      PlaceModel placeModel = PlaceModel.fromMap(place);
      places.add(placeModel);
    }
    return places;
  }

  static Future<PlaceModel> createPlace(String token, PlaceModel place) async {
    Response response = await DioService.dioPostAuthen('/place', token, place.toMap());
    PlaceModel placeModel = PlaceModel.fromMap(response.data);
    return placeModel;
  }

  static Future<void> updatePlace(String token, PlaceModel place) async {
    await DioService.dioPut('/place/${place.id}', token, place.toMap());
  }

  static Future<void> deletePlace(String token, String docId) async {
    await DioService.dioDelete('/place/$docId', token);
  }
}
