import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/modules/auth/screen/profile.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/screen/create_business.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/screen/create_place.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/screen/my_business.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/screen/my_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeSellerService extends StatefulWidget {
  const HomeSellerService({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeSellerServiceState createState() => _HomeSellerServiceState();
}

class _HomeSellerServiceState extends State<HomeSellerService> {
  int tabValue = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Scaffold(
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
              actions: [
                PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'profile':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => const Profile(),
                          ),
                        );
                        break;
                      case 'place':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => CreatePlace(
                              token: state.user.token,
                              userId: state.user.userId,
                            ),
                          ),
                        );
                        break;
                      default:
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => CreateBusiness(
                              typeBusiness: value,
                              sellerId: state.user.userId,
                              token: state.user.token,
                            ),
                          ),
                        );
                    }
                  },
                  icon: const Icon(Icons.add),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'restaurant',
                      child: Text('ร้านอาหาร'),
                    ),
                    const PopupMenuItem(
                      value: 'otop',
                      child: Text('ผลิตภัณฑ์ชุมชน'),
                    ),
                    const PopupMenuItem(
                      value: 'resort',
                      child: Text('บ้านพัก'),
                    ),
                    const PopupMenuItem(
                      value: 'place',
                      child: Text('สถานที่'),
                    ),
                    const PopupMenuItem(
                      value: 'profile',
                      child: Text('บัญชีของฉัน'),
                    ),
                  ],
                ),
              ],
              bottom: TabBar(
                labelColor: AppConstant.colorText,
                tabs: const [
                  Tab(
                    icon: Icon(Icons.food_bank_outlined),
                    text: "ร้านอาหาร",
                  ),
                  Tab(
                    icon: Icon(
                      Icons.store_mall_directory_outlined,
                    ),
                    text: "ผลิตภัณฑ์ชุมชน",
                  ),
                  Tab(
                    icon: Icon(
                      Icons.hotel_outlined,
                    ),
                    text: "บ้านพัก",
                  ),
                  Tab(
                    icon: Icon(
                      Icons.place_outlined,
                    ),
                    text: "สถานที่",
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                MyBusinesses(
                  token: state.user.token,
                  typeBusiness: 'restaurant',
                ),
                MyBusinesses(token: state.user.token, typeBusiness: 'otop'),
                MyBusinesses(token: state.user.token, typeBusiness: 'resort'),
                MyPlace(token: state.user.token),
              ],
            ),
          );
        },
      ),
    );
  }
}
