import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/constants/asset_path.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';

class WarningDeveloping extends StatelessWidget {
  const WarningDeveloping({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
      ),
      backgroundColor: AppConstant.backgroudApp,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: width * 0.26,
                height: height * 0.2,
                child: Image.asset(AppConstantAssets.notifyImage),
              ),
              const TextCustom(
                title: 'อยู่ในช่วงกำลังพัฒนา',
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              const TextCustom(
                title: 'ขออภัยในความไม่สะดวก',
                fontSize: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
