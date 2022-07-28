import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:flutter/material.dart';

class DataEmpty extends StatelessWidget {
  const DataEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Icon(
        //   Icons.data_array,
        //   color: AppConstant.colorText,
        //   size: 40,
        // ),
        Text(
          'ไม่มีข้อมูล',
          style: TextStyle(
            color: AppConstant.colorText,
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
