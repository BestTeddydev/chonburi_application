import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_activity/screen/seller/activity_business.dart';
import 'package:chonburi_mobileapp/modules/manage_activity/screen/seller/order_activity_business.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainActivity extends StatefulWidget {
  final String placeId;
  const MainActivity({Key? key, required this.placeId}) : super(key: key);

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppConstant.themeApp,
          iconTheme: IconThemeData(
            color: AppConstant.colorText,
          ),
          title: Text(
            'รายการธุรกิจของฉัน',
            style: TextStyle(color: AppConstant.colorText),
          ),
          bottom: TabBar(
            labelColor: AppConstant.colorText,
            tabs: const [
              Tab(
                icon: Icon(Icons.local_activity_outlined),
                text: "กิจกรรมทั้งหมด",
              ),
              Tab(
                icon: Icon(
                  Icons.view_list,
                ),
                text: "ออเดอร์",
              ),
              Tab(
                icon: Icon(
                  Icons.check_circle_outlined,
                ),
                text: "รออนุมัติ",
              ),
            ],
          ),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return TabBarView(
              children: [
                ActivityBusiness(
                  placeId: widget.placeId,
                  token: state.user.token,
                  accepted: true,
                ),
                OrderActivityBusiness(
                  placeId: widget.placeId,
                  token: state.user.token,
                ),
                ActivityBusiness(
                  placeId: widget.placeId,
                  token: state.user.token,
                  accepted: false,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
