import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/modules/auth/models/user_model.dart';
import 'package:chonburi_mobileapp/modules/auth/screen/edit_profile.dart';
import 'package:chonburi_mobileapp/modules/contact_info/screen/contact_list.dart';
import 'package:chonburi_mobileapp/modules/custom_package/screen/tracking_custom.dart';
import 'package:chonburi_mobileapp/modules/order_package/screen/packages_tracking.dart';
import 'package:chonburi_mobileapp/modules/register/screen/register.dart';
import 'package:chonburi_mobileapp/modules/tracking_order_otop/screens/tracking_orders.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Center(
              child: Text(
                'บัญชีของฉัน',
                style: TextStyle(color: AppConstant.colorTextHeader),
              ),
            ),
            backgroundColor: AppConstant.themeApp,
            iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
          ),
          backgroundColor: AppConstant.backgroudApp,
          body: Column(
            children: state.user.token.isEmpty
                ? [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: height * 0.25),
                        width: width * 0.8,
                        height: height * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'กรุณาเข้าสู่ระบบ',
                                  style: TextStyle(
                                    color: AppConstant.colorText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/authen');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: AppConstant.bgHasTaged,
                                    ),
                                    child: const Text('เข้าสู่ระบบ'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (builder) =>
                                              const RegisterUser(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: AppConstant.bgCancelActivity,
                                    ),
                                    child: const Text('สร้างบัญชี'),
                                  )
                                ],
                              )
                            ]),
                      ),
                    )
                  ]
                : [
                    Card(
                      margin: EdgeInsets.only(
                        top: height * 0.06,
                        bottom: 10,
                      ),
                      color: AppConstant.backgroudApp,
                      child: Row(
                        children: [
                          Container(
                            width: width * 0.21,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ShowImageNetwork(
                              pathImage: state.user.profileRef,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.65,
                            child: Text(
                              '${state.user.firstName} ${state.user.lastName}',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppConstant.colorText,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => EditProfile(
                                    user: state.user,
                                  ),
                                ),
                              ),
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: AppConstant.colorText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: state.user.roles == "buyer"
                          ? TextButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => ContactList(
                                    token: state.user.token,
                                    userId: state.user.userId,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.1,
                                    child: Icon(
                                      Icons.pin_drop_sharp,
                                      color: AppConstant.colorText,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.76,
                                    child: Text(
                                      'ที่อยู่ของฉัน',
                                      style: TextStyle(
                                        color: AppConstant.colorText,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppConstant.colorText,
                                    size: 16,
                                  ),
                                ],
                              ),
                            )
                          : null,
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: state.user.roles == "buyer"
                          ? TextButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => TrackingPackage(
                                    token: state.user.token,
                                    userId: state.user.userId,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.1,
                                    child: Icon(
                                      Icons.pin_drop_sharp,
                                      color: AppConstant.colorText,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.76,
                                    child: Text(
                                      'ติดตามแพ็คเกจทัวร์ของฉัน',
                                      style: TextStyle(
                                        color: AppConstant.colorText,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppConstant.colorText,
                                    size: 16,
                                  ),
                                ],
                              ),
                            )
                          : null,
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: state.user.roles == "buyer"
                          ? TextButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => TrackingCustom(
                                    token: state.user.token,
                                    userId: state.user.userId,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.1,
                                    child: Icon(
                                      Icons.pin_drop_sharp,
                                      color: AppConstant.colorText,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.76,
                                    child: Text(
                                      'ติดตามคัสตอมแพ็คเกจทัวร์',
                                      style: TextStyle(
                                        color: AppConstant.colorText,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppConstant.colorText,
                                    size: 16,
                                  ),
                                ],
                              ),
                            )
                          : null,
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: state.user.roles == "buyer"
                          ? TextButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => TrackingOrderOtop(
                                    token: state.user.token,
                                    userId: state.user.userId,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.1,
                                    child: Icon(
                                      Icons.delivery_dining_rounded,
                                      color: AppConstant.colorText,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.76,
                                    child: Text(
                                      'ติดตามสินค้าโอท็อปของฉัน',
                                      style: TextStyle(
                                        color: AppConstant.colorText,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppConstant.colorText,
                                    size: 16,
                                  ),
                                ],
                              ),
                            )
                          : null,
                    ),
                    Container(
                      margin: const EdgeInsets.all(4),
                      child: TextButton(
                        onPressed: () {
                          UserModel userModel = UserModel(
                            userId: '',
                            username: '',
                            firstName: '',
                            lastName: '',
                            roles: 'guest',
                            token: '',
                            tokenDevice: state.user.tokenDevice,
                            profileRef: '',
                          );
                          context.read<UserBloc>().add(
                                UserLogoutEvent(userModel: userModel),
                              );
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/buyerService',
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.1,
                              child: Icon(
                                Icons.logout,
                                color: AppConstant.bgCancelActivity,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.756,
                              child: Text(
                                'ออกจากระบบ',
                                style: TextStyle(
                                  color: AppConstant.colorText,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: AppConstant.colorText,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
          ),
        );
      },
    );
  }
}
