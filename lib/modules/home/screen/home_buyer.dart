import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/constants/asset_path.dart';
import 'package:chonburi_mobileapp/modules/custom_activity/screen/home_package.dart';
import 'package:chonburi_mobileapp/modules/home/screen/components/menu_card_admin.dart';
import 'package:flutter/material.dart';

class HomeBuyer extends StatelessWidget {
  const HomeBuyer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> menuCards = [
      // {
      //   "title": 'สมาชิกในระบบ',
      //   "pathImage": AppConstantAssets.memberPicture,
      //   "goWidget": const BuyerList(),
      // },
      // {
      //   "title": 'พาร์ทเนอร์',
      //   "pathImage": AppConstantAssets.partnerImage,
      //   "goWidget": Partner(),
      // },
      {
        "title": 'แพ็คเกจทัวร์',
        "pathImage": AppConstantAssets.packageImage,
        "goWidget": const HomePackages(),
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
                  // crossAxisSpacing: 15,
                  // mainAxisSpacing: 15,
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
    // Scaffold(
    //   body: Responsive(
    //     desktop: Center(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           const Text("Home Buyer Desktop"),
    //           ElevatedButton(
    //             onPressed: () => Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (builder) => const CustomPackage(),
    //               ),
    //             ),
    //             child: const Text('go to custom package'),
    //           )
    //         ],
    //       ),
    //     ),
    //     mobile: Column(
    //       children: [
    //         const Text("Home Buyer Mobile"),
    //         ElevatedButton(
    //           onPressed: () => Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (builder) => const HomePackages(),
    //             ),
    //           ),
    //           child: const Text('go to custom package'),
    //         )
    //       ],
    //     ),
    //     tablet: Column(
    //       children: [
    //         const Text("Home Buyer Tablet"),
    //         ElevatedButton(
    //           onPressed: () => Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (builder) => const HomePackages(),
    //             ),
    //           ),
    //           child: const Text('go to custom package'),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
