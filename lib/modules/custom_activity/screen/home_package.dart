import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/modules/custom_activity/bloc/activity_bloc.dart';
import 'package:chonburi_mobileapp/modules/custom_activity/screen/custom_package.dart';
import 'package:chonburi_mobileapp/modules/order_package/screen/packages_tracking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePackages extends StatefulWidget {
  const HomePackages({Key? key}) : super(key: key);

  @override
  State<HomePackages> createState() => _HomePackagesState();
}

class _HomePackagesState extends State<HomePackages> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityBloc, ActivityState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                'แพ็คเกจ',
                style: TextStyle(
                  color: AppConstant.colorTextHeader,
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: AppConstant.themeApp,
              iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'แพ็คเกจ',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.delivery_dining),
                  label: 'การติดตาม',
                ),
              ],
              onTap: (int tab) {
                context.read<ActivityBloc>().add(ChangeTabEvent(tab: tab));
              },
              currentIndex: state.isTab,
              selectedItemColor: AppConstant.colorText,
              unselectedItemColor: Colors.grey,
              backgroundColor: AppConstant.themeApp,
            ),
            body: BlocBuilder<UserBloc, UserState>(
              builder: (context, stateUser) {
                return SafeArea(
                  child: [
                    const CustomPackage(),
                    TrackingPackage(
                      token: stateUser.user.token,
                      userId: stateUser.user.userId,
                    ),
                  ][state.isTab],
                );
              },
            ));
      },
    );
  }
}
