import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/constants/asset_path.dart';
import 'package:chonburi_mobileapp/modules/manage_activity/screen/admin/activity_list.dart';
import 'package:chonburi_mobileapp/modules/manage_package/screen/main_package.dart';
import 'package:chonburi_mobileapp/modules/partner/screen/home_partner.dart';
import 'package:flutter/material.dart';

import 'components/menu_card_admin.dart';

class HomeAdmin extends StatelessWidget {
  final String token;
  const HomeAdmin({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> menuCards = [
      // {
      //   "title": 'สมาชิกในระบบ',
      //   "pathImage": AppConstantAssets.memberPicture,
      //   "goWidget": const BuyerList(),
      // },
      {
        "title": 'ผู้ประกอบการ',
        "pathImage": AppConstantAssets.partnerImage,
        "goWidget": const HomePartnerApprove(),
      },
      {
        "title": 'แพ็คเกจทัวร์',
        "pathImage": AppConstantAssets.packageTourImage,
        "goWidget": MainPackageAdmin(token: token),
      },
      // {
      //   "title": 'แหล่งท่องเที่ยว',
      //   "pathImage": AppConstantAssets.locationImage,
      //   "goWidget": Locations(isAdmin: true),
      // },
      // {
      //   "title": 'ไกด์นำเที่ยว',
      //   "pathImage": AppConstantAssets.guideImage,
      //   "goWidget": GuideList(),
      // },
      {
        "title": 'กิจกรรม',
        "pathImage": AppConstantAssets.notifyImage,
        "goWidget": ActivityList(
          token: token,
        ),
      },
      // {
      //   "title": 'กิจการยอดนิยม',
      //   "pathImage": AppConstantAssets.partnerImage,
      //   "goWidget": BusinessPopular(),
      // },
    ];
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppConstant.backgroudApp,
      body: SingleChildScrollView(
        child: SizedBox(
          height: height * 1,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Welcome To",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppConstant.colorText,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Our Service",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppConstant.colorText,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                height: height * 0.86,
                width: width * 1,
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio:
                      height > 730 ? width / height / 0.4 : width / height / 1,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: List.generate(
                    menuCards.length,
                    (index) => MenuCard(
                      gotoWidget: menuCards[index]["goWidget"],
                      imageUrl: menuCards[index]["pathImage"],
                      title: menuCards[index]["title"],
                      titleColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
