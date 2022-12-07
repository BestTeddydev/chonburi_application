import 'dart:developer';

import 'package:chonburi_mobileapp/config/routes/route.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/modules/notification/models/notification_models.dart';
import 'package:chonburi_mobileapp/utils/services/local_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  final LocalNotificationServices _notificationService;
  final UserBloc userBloc;
  FirebaseMessagingService(this._notificationService, this.userBloc);

  Future<void> initialize() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true,
    );
    getDeviceFirebaseToken();
    _onMessage();
    _onMessageOpenedApp();
  }

  getDeviceFirebaseToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      log('token $token');
      userBloc.add(UpdateDeviceTokenEvent(token: token));
    }
  }

  _onMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      AppleNotification? apple = message.notification!.apple;

      if (notification != null && android != null) {
        _notificationService.showLocalNotification(
          NotificationModel(
            id: android.hashCode.toString(),
            title: notification.title!,
            message: notification.body!,
            recipientId: '',
            readed: false,
          ),
        );
      }
      if (notification != null && apple != null) {
        _notificationService.showLocalNotification(
          NotificationModel(
            id: android.hashCode.toString(),
            title: notification.title!,
            message: notification.body!,
            recipientId: '',
            readed: false,
          ),
        );
      }
    });
  }

  _onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen(_goToPageAfterMessage);
  }

  _goToPageAfterMessage(message) {
    Routes.navigatorKey?.currentState?.pushNamed('/home');
  }
}
