import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/modules/partner/bloc/manage_partner_bloc.dart';
import 'package:chonburi_mobileapp/modules/partner/screen/partner_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePartnerApprove extends StatefulWidget {
  const HomePartnerApprove({Key? key}) : super(key: key);

  @override
  State<HomePartnerApprove> createState() => _HomePartnerApproveState();
}

class _HomePartnerApproveState extends State<HomePartnerApprove> {
  int tabValue = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocBuilder<ManagePartnerBloc, ManagePartnerState>(
        builder: (context, state) {
          return BlocBuilder<UserBloc, UserState>(
            builder: (context, stateUser) {
              return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: AppConstant.themeApp,
                  iconTheme: IconThemeData(
                    color: AppConstant.colorText,
                  ),
                  title: Text(
                    'รายชื่อผู้ประกรอบการ',
                    style: TextStyle(color: AppConstant.colorText),
                  ),
                  bottom: TabBar(
                    labelColor: AppConstant.colorText,
                    tabs: const [
                      Tab(
                        icon: Icon(Icons.person),
                        text: "ผู้ประกรอบการ",
                      ),
                      Tab(
                        icon: Icon(
                          Icons.check_circle_outline,
                        ),
                        text: "รอการยืนยัน",
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    PartnerList(status: true, token: stateUser.user.token),
                    PartnerList(status: false, token: stateUser.user.token),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
