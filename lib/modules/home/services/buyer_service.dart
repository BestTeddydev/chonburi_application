import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/modules/auth/models/user_model.dart';
import 'package:chonburi_mobileapp/modules/auth/screen/profile.dart';
import 'package:chonburi_mobileapp/modules/home/screen/home_buyer.dart';
import 'package:chonburi_mobileapp/modules/notification/screen/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class BuyerService extends StatefulWidget {
  final String token;
  const BuyerService({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<BuyerService> createState() => _BuyerServiceState();
}

class _BuyerServiceState extends State<BuyerService> {
  int _selected = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selected = index;
    });
  }

  checkUserExpire(String token) {
    if (token != '') {
      DateTime dateNow = DateTime.now();
      DateTime hasExpired = JwtDecoder.getExpirationDate(token);
      DateTime limitExpired = DateTime(
        dateNow.year,
        dateNow.month,
        dateNow.day,
        dateNow.hour + 2,
      );
      if (hasExpired.compareTo(limitExpired) < 0) {
        UserModel userModel = UserModel(
          userId: '',
          username: '',
          firstName: '',
          lastName: '',
          roles: 'guest',
          token: '',
          tokenDevice: '',
          profileRef: '',
        );
        context.read<UserBloc>().add(
              UserLogoutEvent(userModel: userModel),
            );
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUserExpire(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: [
              const HomeBuyer(),
              MyNotification(recipientId: state.user.userId),
              const Profile(),
            ][_selected],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'หน้าแรก',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active),
                label: 'แจ้งเตือน',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'ตั้งค่า',
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
