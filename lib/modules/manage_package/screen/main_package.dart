import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/manage_package/screen/create_package.dart';
import 'package:chonburi_mobileapp/modules/manage_package/screen/order_package_admin.dart';
import 'package:chonburi_mobileapp/modules/manage_package/screen/packages_show.dart';
import 'package:flutter/material.dart';

class MainPackageAdmin extends StatelessWidget {
  final String token;
  const MainPackageAdmin({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstant.themeApp,
          iconTheme: IconThemeData(
            color: AppConstant.colorText,
          ),
          title: Text(
            'แพ็คเกจ',
            style: TextStyle(color: AppConstant.colorText),
          ),
          actions: [
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) => CreatePackage(token: token),
                ),
              ),
              icon: const Icon(Icons.add),
            )
          ],
          bottom: TabBar(
            labelColor: AppConstant.colorText,
            tabs: const [
              Tab(
                icon: Icon(Icons.local_activity_outlined),
                text: "แพ็คเกจ",
              ),
              Tab(
                icon: Icon(
                  Icons.view_list,
                ),
                text: "รายการออเดอร์",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PackageListAdmin(token: token),
            OrderPackageAdmin(token: token),
          ],
        ),
      ),
    );
  }
}
