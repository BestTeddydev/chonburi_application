import 'package:chonburi_mobileapp/modules/contact_admin/models/contact_admin_model.dart';
import 'package:chonburi_mobileapp/utils/helper/dio.dart';
import 'package:dio/dio.dart';

class ContactAdminService {
  static Future<void> createContact(
    ContactAdminModel contactModel,
    String token,
  ) async {
    await DioService.dioPut(
      '/contact/admin',
      token,
      contactModel.toMap(),
    );
  }

  static Future<List<ContactAdminModel>> fetchsContacts() async {
    try {
      Response response = await DioService.dioGet('/guest/contact/admin');
      List<ContactAdminModel> contacts = [];
      for (var contact in response.data) {
        ContactAdminModel contactModel = ContactAdminModel.fromMap(contact);
        contacts.add(contactModel);
      }
      return contacts;
    } catch (e) {
      return [];
    }
  }
}
