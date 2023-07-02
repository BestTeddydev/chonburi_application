import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';

class OrderRestaurant extends StatefulWidget {
  const OrderRestaurant({Key? key}) : super(key: key);

  @override
  State<OrderRestaurant> createState() => _OrderRestaurantState();
}

class _OrderRestaurantState extends State<OrderRestaurant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.backgroudApp,
      body: const Center(child: TextCustom(title: "ไม่มีออเดอร์อาหาร")),
    );
  }
}
