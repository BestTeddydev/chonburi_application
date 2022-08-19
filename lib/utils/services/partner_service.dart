import 'package:chonburi_mobileapp/modules/register_partner/models/partner_model.dart';
import 'package:chonburi_mobileapp/utils/helper/dio.dart';
import 'package:dio/dio.dart';

class PartnerService {
  static Future<List<PartnerModel>> fetchsPartner(
      String token, bool status) async {
    List<PartnerModel> partners = [];
    Response response =
        await DioService.dioGetAuthen('/partner/$status', token);
    for (var partner in response.data) {
      PartnerModel partnerModel = PartnerModel.fromMap(partner);
      partners.add(partnerModel);
    }
    return partners;
  }

  static Future<void> register(PartnerModel partner) async {
    await DioService.dioPost('/user/partner/register', partner.toMap());
  }

  static Future<void> approvePartner(String token, PartnerModel partner) async {
    await DioService.dioPut('/partner/${partner.id}', token, partner.toMap());
  }

  static Future<void> rejectPartner(String token, String docId) async {
    await DioService.dioDelete('/partner/$docId', token);
  }
}
