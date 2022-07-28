import 'package:chonburi_mobileapp/modules/notification/models/notification_models.dart';
import 'package:chonburi_mobileapp/utils/helper/dio.dart';
import 'package:dio/dio.dart';

class NotificationService {
  static Future<List<NotificationModel>> fetchsNotification(
      String recipientId) async {
    List<NotificationModel> notifications = [];
    Response response = await DioService.dioGet('/notification/$recipientId');
    for (var noti in response.data) {
      NotificationModel notificationModel = NotificationModel.fromMap(noti);
      notifications.add(notificationModel);
    }
    return notifications;
  }

  static Future<void> deleteNotification(String docId, String token) async {
    await DioService.dioDelete('/notification/$docId', token);
  }
}
