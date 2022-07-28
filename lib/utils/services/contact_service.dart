import 'package:chonburi_mobileapp/modules/contact_info/models/contact_models.dart';
import 'package:chonburi_mobileapp/utils/helper/dio.dart';
import 'package:dio/dio.dart';

class ContactService {
  static Future<ContactModel> createContact(
      ContactModel contactModel, String token) async {
    Response response =
        await DioService.dioPostAuthen('/contact', token, contactModel.toMap());
    ContactModel contactRes = ContactModel.fromMap(response.data);
    return contactRes;
  }

  static Future<List<ContactModel>> fetchsContacts(String token) async {
    try {
      Response response = await DioService.dioGetAuthen('/contact', token);
      List<ContactModel> contacts = [];
      for (var contact in response.data) {
        ContactModel contactModel = ContactModel.fromMap(contact);
        contacts.add(contactModel);
      }
      return contacts;
    } catch (e) {
      return [];
    }
  }

  static Future<ContactModel> fetchContact(String docId, String token) async {
    Response response = await DioService.dioGetAuthen('/contact/$docId', token);
    ContactModel contactModel = ContactModel.fromMap(response.data);
    return contactModel;
  }

  static Future<void> updateContact(
      String docId, ContactModel contactModel, String token) async {
    await DioService.dioPut('/contact/$docId', token, contactModel.toMap());
  }

  static Future<void> deleteContact(String docId, String token) async {
    await DioService.dioDelete('/contact/$docId', token);
  }
}
