import 'package:chonburi_mobileapp/modules/contact_admin/bloc/contact_admin_bloc.dart';
import 'package:chonburi_mobileapp/modules/custom_activity/bloc/activity_bloc.dart';
import 'package:chonburi_mobileapp/modules/custom_package/bloc/custom_package_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_room/bloc/manage_room_bloc.dart';
import 'package:chonburi_mobileapp/modules/order_otop/bloc/order_otop_bloc.dart';
import 'package:chonburi_mobileapp/modules/otop/bloc/otop_bloc.dart';
import 'package:chonburi_mobileapp/modules/product/bloc/product_bloc.dart';
import 'package:chonburi_mobileapp/modules/restaurant/bloc/restaurant_bloc.dart';
import 'package:chonburi_mobileapp/modules/tracking_order_otop/bloc/tracking_order_otop_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'modules/auth/bloc/user_bloc.dart';
import 'modules/businesses/bloc/businesses_bloc.dart';
import 'modules/category/bloc/category_bloc.dart';
import 'modules/contact_info/bloc/contact_bloc.dart';
import 'modules/food/bloc/food_bloc.dart';
import 'modules/location/bloc/location_bloc.dart';
import 'modules/manage_activity/bloc/manage_activity_bloc.dart';
import 'modules/manage_businesses/bloc/manage_businesses_bloc.dart';
import 'modules/manage_package/bloc/manage_package_bloc.dart';
import 'modules/notification/bloc/notification_bloc.dart';
import 'modules/order_package/bloc/order_package_bloc.dart';
import 'modules/packages_tour/bloc/package_bloc.dart';
import 'modules/partner/bloc/manage_partner_bloc.dart';
import 'modules/register/bloc/register_bloc.dart';
import 'modules/register_partner/bloc/register_partner_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ActivityBloc(),
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
          BlocProvider(create: (context) => CategoryBloc()),
          BlocProvider(create: (context) => FoodBloc()),
          BlocProvider(create: (context) => RegisterPartnerBloc()),
          BlocProvider(create: (context) => ManagePartnerBloc()),
          BlocProvider(create: (context) => ProductBloc()),
          BlocProvider(create: (context) => ManageRoomBloc()),
          BlocProvider(create: (context) => RestaurantBloc()),
          BlocProvider(create: (context) => OtopBloc()),
          BlocProvider(create: (context) => TrackingOrderOtopBloc()),
          BlocProvider(create: (context) => OrderOtopBloc()),
          BlocProvider(create: (context) => ContactAdminBloc()),
          BlocProvider(create: (context) => CustomPackageBloc()),
        ],
        child: const MyApp(),
      ),
    ),
    storage: storage,
  );
}
