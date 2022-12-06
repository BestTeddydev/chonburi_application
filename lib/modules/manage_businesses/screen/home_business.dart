import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/businesses/bloc/businesses_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBusiness extends StatefulWidget {
  final String businessId;
  final List<Widget> itemTabs;
  const HomeBusiness({
    Key? key,
    required this.businessId,
    required this.itemTabs,
  }) : super(key: key);

  @override
  State<HomeBusiness> createState() => _HomeBusinessState();
}

class _HomeBusinessState extends State<HomeBusiness> {
  int _selected = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selected = index;
    });
  }

  @override
  void initState() {
    context
        .read<BusinessesBloc>()
        .add(FetchBusinessByIdEvent(docId: widget.businessId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: widget.itemTabs[_selected],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppConstant.themeApp,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity_outlined),
            label: 'กิจกรรม',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.reorder),
            label: 'ออร์เดอร์',
          ),
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
  }
}
