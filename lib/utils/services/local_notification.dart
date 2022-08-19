import 'dart:math';

import 'package:chonburi_mobileapp/config/routes/route.dart';
import 'package:chonburi_mobileapp/modules/notification/models/notification_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class LocalNotificationServices {
  // 1.
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;

  // 2.
  LocalNotificationServices() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupAndroidDetails();
    _setupNotifications();
  }

  // 3.
  _setupAndroidDetails() {
    androidDetails = const AndroidNotificationDetails(
      'takhientia_notification_x',
      'takhientia',
      channelDescription: 'welcome to takhientia',
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
    );
  }

  _setupNotifications() async {
    await _setupTimezone();
    await _initializeNotifications();
  }

  // 4.
  Future<void> _setupTimezone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  _initializeNotifications() async {
    AndroidInitializationSettings android =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    IOSInitializationSettings ios = const IOSInitializationSettings();
    // Fazer: macOs, iOS, Linux...
    await localNotificationsPlugin.initialize(
      InitializationSettings(android: android, iOS: ios),
      onSelectNotification: _onSelectNotification,
    );
  }

  // 5.
  _onSelectNotification(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      Navigator.of(Routes.navigatorKey!.currentContext!).pushNamed(payload);
    } else {
      if (Routes.navigatorKey != null &&
          Routes.navigatorKey!.currentContext != null) {
        Navigator.of(Routes.navigatorKey!.currentContext!).pushNamed('/home');
      }
    }
  }

  // 6.
  showLocalNotification(NotificationModel notification) {
    IOSNotificationDetails iosNotificationDetails =
        const IOSNotificationDetails();
    localNotificationsPlugin.show(
      Random().nextInt(10000),
      notification.title,
      notification.message,
      NotificationDetails(android: androidDetails, iOS: iosNotificationDetails),
      payload: '/home',
    );
  }

  checkForNotifications() async {
    final details =
        await localNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      _onSelectNotification(details.payload);
    }
  }
}
