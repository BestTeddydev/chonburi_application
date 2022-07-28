import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/home/screen/home_seller.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/bloc/manage_businesses_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/screen/edit_place.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingPlace extends StatefulWidget {
  final String token, userId;
  const SettingPlace({
    Key? key,
    required this.token,
    required this.userId,
  }) : super(key: key);

  @override
  State<SettingPlace> createState() => _SettingPlaceState();
}

class _SettingPlaceState extends State<SettingPlace> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<ManageBusinessesBloc, ManageBusinessesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: height * 0.13,
            automaticallyImplyLeading: false,
            title: buildHeader(width, state.place.placeName),
            backgroundColor: AppConstant.themeApp,
            iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
          ),
          backgroundColor: AppConstant.backgroudApp,
          body: Column(
            children: [
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => EditPlace(
                      token: widget.token,
                      userId: widget.userId,
                      place: state.place,
                    ),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 30,
                    bottom: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: width * 0.1,
                          child: Icon(
                            Icons.edit,
                            color: AppConstant.colorText,
                          ),
                        ),
                        SizedBox(
                          width: width * 0.76,
                          child: Text(
                            'แก้ไขข้อมูลสถานที่',
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
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.1,
                        child: Icon(
                          Icons.person,
                          color: AppConstant.colorText,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.76,
                        child: Text(
                          'บัญชีของฉัน',
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
              ),
              Container(
                width: width * 0.6,
                margin: const EdgeInsets.all(4),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppConstant.bgTextFormField,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => const HomeSellerService(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextCustom(
                          title: 'เปลี่ยนธุรกิจ',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: AppConstant.colorText,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Row buildHeader(double width, String placeName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: width * 0.9,
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 5.0, right: 10.0),
                height: 60,
                width: width * 0.2,
                decoration: BoxDecoration(
                  border: Border.all(color: AppConstant.colorText, width: 2),
                  color: AppConstant.themeApp,
                  shape: BoxShape.circle,
                ),
                child: SizedBox(
                  width: width * 0.16,
                  child: Icon(
                    Icons.place,
                    color: AppConstant.colorText,
                    size: 40,
                  ),
                ),
              ),
              Expanded(
                child: TextCustom(
                  title: placeName,
                  maxLine: 2,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
