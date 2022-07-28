import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:flutter/material.dart';

class ImageBlank extends StatelessWidget {
  const ImageBlank({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.18,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image,
              color: AppConstant.themeApp,
              size: 50,
            ),
            Text(
              "ไม่มีรูปภาพ",
              style: TextStyle(fontSize: 12, color: AppConstant.colorText),
            ),
          ],
        ),
      ),
    );
  }
}
