import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/home_splash.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/utils/services/firebase_messaging_service.dart';
import 'package:chonburi_mobileapp/utils/services/local_notification.dart';
import 'package:flutter/material.dart';

import 'config/routes/route.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    checkNotifications();
    initilizeFirebaseMessaging();
  }

  initilizeFirebaseMessaging() async {
    UserBloc userBloc = UserBloc();
    await FirebaseMessagingService(LocalNotificationServices(),userBloc).initialize();
  }

  checkNotifications() async {
    await LocalNotificationServices().checkForNotifications();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      title: AppConstant.appName,
      routes: Routes.protectRoute,
      home: const HomeSplash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
