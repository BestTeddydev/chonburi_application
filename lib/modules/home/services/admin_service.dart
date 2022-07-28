// ignore_for_file: library_private_types_in_public_api

import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/modules/home/screen/home_admin.dart';
import 'package:chonburi_mobileapp/modules/auth/screen/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminService extends StatefulWidget {
  const AdminService({
    Key? key,
  }) : super(key: key);

  @override
  _AdminServiceState createState() => _AdminServiceState();
}

class _AdminServiceState extends State<AdminService> {
  int _selected = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: [
              HomeAdmin(token: state.user.token),
              const Profile(),
            ][_selected],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.list_alt),
              //   label: 'Order',
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            onTap: _onItemTapped,
            currentIndex: _selected,
            selectedItemColor: AppConstant.colorText,
            unselectedItemColor: Colors.grey,
            backgroundColor: AppConstant.themeApp,
          ),
        );
      },
    );
  }
}
