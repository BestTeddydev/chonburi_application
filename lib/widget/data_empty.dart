import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:flutter/material.dart';

class DataEmpty extends StatelessWidget {
  final String? title;
  const DataEmpty({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Icon(
        //   Icons.data_array,
        //   color: AppConstant.colorText,
        //   size: 40,
        // ),
        Text(
          title ?? 'ไม่มีข้อมูล',
          style: TextStyle(
            color: AppConstant.colorText,
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
