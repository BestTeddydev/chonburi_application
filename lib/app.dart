import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/modules/businesses/bloc/businesses_bloc.dart';
import 'package:chonburi_mobileapp/modules/contact_info/bloc/contact_bloc.dart';
import 'package:chonburi_mobileapp/modules/custom_activity/bloc/activity_bloc.dart';
import 'package:chonburi_mobileapp/modules/location/bloc/location_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/bloc/manage_businesses_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_package/bloc/manage_package_bloc.dart';
import 'package:chonburi_mobileapp/modules/notification/bloc/notification_bloc.dart';
import 'package:chonburi_mobileapp/modules/order_package/bloc/order_package_bloc.dart';
import 'package:chonburi_mobileapp/modules/packages_datail/bloc/package_bloc.dart';
import 'package:chonburi_mobileapp/modules/register/bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/routes/route.dart';
import 'modules/manage_activity/bloc/manage_activity_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ActivityBloc(),
          lazy: false,
        ),
        BlocProvider(create: (context) => PackageBloc()),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => RegisterBloc()),
        BlocProvider(create: (context) => ContactBloc()),
        BlocProvider(create: (context) => LocationBloc()),
        BlocProvider(create: (context) => ManageActivityBloc()),
        BlocProvider(create: (context) => BusinessesBloc()),
        BlocProvider(create: (context) => ManagePackageBloc()),
        BlocProvider(create: (context) => OrderPackageBloc()),
        BlocProvider(create: (context) => NotificationBloc()),
        BlocProvider(create: (context) => ManageBusinessesBloc()),
      ],
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return MaterialApp(
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!,
              );
            },
            title: AppConstant.appName,
            routes: Routes.protectRoute(state.user.roles),
            initialRoute: Routes.initialRoute(
              state.user.roles,
              state.user.token,
            ),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
