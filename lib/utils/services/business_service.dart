import 'package:chonburi_mobileapp/modules/businesses/models/business_models.dart';
import 'package:chonburi_mobileapp/utils/helper/dio.dart';
import 'package:dio/dio.dart';

class BusinessService {
  static Future<List<BusinessModel>> fetchBusiness(
      String businessName, String typeBusiness) async {
    List<BusinessModel> businesses = [];
    Response response = await DioService.dioGet('/guest/business');
    for (var business in response.data) {
      BusinessModel businessModel = BusinessModel.fromMap(business);
      businesses.add(businessModel);
    }
    return businesses;
  }

  static Future<BusinessModel> fetchBusinessById(String docId) async {
    Response response = await DioService.dioGet('/guest/business/$docId');
    BusinessModel businessModel = BusinessModel.fromMap(response.data);
    return businessModel;
  }

  static Future<List<BusinessModel>> fetchBusinessOwner(
      String token, String typeBusiness) async {
    List<BusinessModel> businesses = [];
    Response response =
        await DioService.dioGetAuthen('/business/$typeBusiness', token);
    for (var business in response.data) {
      BusinessModel businessModel = BusinessModel.fromMap(business);
      businesses.add(businessModel);
    }
    return businesses;
  }

  static Future<BusinessModel> createBusiness(
      String token, BusinessModel business) async {
    Response response = await DioService.dioPostAuthen(
      '/business',
      token,
      business.toMap(),
    );
    BusinessModel businessModel = BusinessModel.fromMap(response.data);
    return businessModel;
  }

  static Future<void> updateBusiness(
      String token, BusinessModel business) async {
    await DioService.dioPut(
      '/business/${business.id}',
      token,
      business.toMap(),
    );
  }

  static Future<void> deleteBusiness(String token, String docId) async {
    await DioService.dioDelete('/business/$docId', token);
  }
}
