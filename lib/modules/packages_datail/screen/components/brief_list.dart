import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/custom_activity/bloc/activity_bloc.dart';
import 'package:chonburi_mobileapp/modules/packages_datail/bloc/package_bloc.dart';
import 'package:flutter/material.dart';

class BriefList extends StatelessWidget {
  final PackageState state;
  final double totalPrice;
  final ActivityState stateActivity;
  const BriefList({
    Key? key,
    required this.state,
    required this.stateActivity,
    required this.totalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'คำสั่งซื้อทั้งหมด ( ${state.buyActivity.length} รายการ )',
                style: TextStyle(
                  color: AppConstant.colorText,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '$totalPrice ฿',
                style: TextStyle(
                  color: AppConstant.colorText,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ราคาเริ่มต้น',
                style: TextStyle(
                  color: AppConstant.colorText,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${state.packagesTour.price} ฿',
                style: TextStyle(
                  color: AppConstant.colorText,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'จำนวนสมาชิกทั้งหมด',
                style: TextStyle(
                  color: AppConstant.colorText,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${stateActivity.totalMember} คน',
                style: TextStyle(
                  color: AppConstant.colorText,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ยอดรวมทั้งหมด',
                style: TextStyle(
                  color: AppConstant.colorText,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${(totalPrice + state.packagesTour.price) * stateActivity.totalMember} ฿',
                style: TextStyle(
                  color: AppConstant.colorText,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
