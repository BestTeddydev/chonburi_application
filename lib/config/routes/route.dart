import 'package:chonburi_mobileapp/modules/auth/screen/login.dart';
import 'package:chonburi_mobileapp/modules/home/screen/home_seller.dart';
import 'package:chonburi_mobileapp/modules/home/services/admin_service.dart';
import 'package:chonburi_mobileapp/modules/home/services/buyer_service.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Routes {
  static Map<String, WidgetBuilder> protectRoute(String role) {
    Map<String, WidgetBuilder> routes = {
      "/authen": (context) => const AuthenLogin(),
      "/buyerService": (context) => const BuyerService(),
      '/adminService': (context) => const AdminService(),
      '/sellerService': (context) => const HomeSellerService()
    };
    return routes;
  }

  static String initialRoute(String role, String token) {
    if (token != '') {
      DateTime dateNow = DateTime.now();
      DateTime hasExpired = JwtDecoder.getExpirationDate(token);
      DateTime limitExpired = DateTime(
        dateNow.year,
        dateNow.month,
        dateNow.day,
        dateNow.hour + 2,
      );
      if (hasExpired.compareTo(limitExpired) < 0) {
        return '/authen';
      }
    }

    if (role == "admin") {
      return '/adminService';
    }
    if (role == "seller") {
      return '/sellerService';
    }
    if (role == "buyer") {
      return '/buyerService';
    }
    if (role == "guide") {
      return '/guideService';
    }
    return '/buyerService';
  }

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
