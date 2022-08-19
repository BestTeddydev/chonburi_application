import 'package:chonburi_mobileapp/home_splash.dart';
import 'package:chonburi_mobileapp/modules/auth/screen/login.dart';
import 'package:chonburi_mobileapp/modules/home/screen/home_seller.dart';
import 'package:chonburi_mobileapp/modules/home/services/admin_service.dart';
import 'package:chonburi_mobileapp/modules/home/services/buyer_service.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Routes {
  static Map<String, WidgetBuilder> protectRoute = {
    "/authen": (context) => const AuthenLogin(),
    "/buyerService": (context) => const BuyerService(),
    '/adminService': (context) => const AdminService(),
    '/sellerService': (context) => const HomeSellerService(),
    '/home': (context) => const HomeSplash(),
  };

  static Widget initialRoute(String role, String token) {
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
        return const AuthenLogin();
      }
    }

    if (role == "admin") {
      return const AdminService();
    }
    if (role == "seller") {
      return const HomeSellerService();
    }
    if (role == "buyer") {
      return const BuyerService();
    }
    return const BuyerService();
  }

  // static String initialRoute(String role, String token) {
  //   if (token != '') {
  //     DateTime dateNow = DateTime.now();
  //     DateTime hasExpired = JwtDecoder.getExpirationDate(token);
  //     DateTime limitExpired = DateTime(
  //       dateNow.year,
  //       dateNow.month,
  //       dateNow.day,
  //       dateNow.hour + 2,
  //     );
  //     if (hasExpired.compareTo(limitExpired) < 0) {
  //       return '/authen';
  //     }
  //   }

  //   if (role == "admin") {
  //     return '/adminService';
  //   }
  //   if (role == "seller") {
  //     return '/sellerService';
  //   }
  //   if (role == "buyer") {
  //     return '/buyerService';
  //   }
  //   return '/buyerService';
  // }

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
