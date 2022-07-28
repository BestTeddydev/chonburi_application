import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/bloc/manage_businesses_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/models/place_model.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/screen/main_activity.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/screen/setting_place.dart';
import 'package:chonburi_mobileapp/modules/notification/screen/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePlace extends StatefulWidget {
  final PlaceModel placeModel;
  const HomePlace({
    Key? key,
    required this.placeModel,
  }) : super(key: key);

  @override
  State<HomePlace> createState() => _HomePlaceState();
}

class _HomePlaceState extends State<HomePlace> {
  int _selected = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selected = index;
    });
  }

  @override
  void initState() {
    context.read<ManageBusinessesBloc>().add(
          SetPlaceForUpdateEvent(place: widget.placeModel),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: [
              MainActivity(businessId: widget.placeModel.id),
              MyNotification(recipientId: widget.placeModel.id),
              SettingPlace(
                userId: state.user.userId,
                token: state.user.token,
              ),
            ][_selected],
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: AppConstant.themeApp,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.local_activity_outlined),
                label: 'กิจกรรม',
              ),

              // BottomNavigationBarItem(
              //   icon: Icon(Icons.reorder),
              //   label: 'ออร์เดอร์',
              // ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.auto_graph),
              //   label: 'สถิติ',
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'แจ้งเตือน',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'ตั้งค่า',
              ),
            ],
            onTap: _onItemTapped,
            currentIndex: _selected,
            selectedItemColor: AppConstant.colorTextHeader,
            unselectedItemColor: AppConstant.bgHasTaged,
          ),
        );
      },
    );
  }
}
