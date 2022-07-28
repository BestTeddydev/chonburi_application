import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/manage_package/bloc/manage_package_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/day_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectDay extends StatefulWidget {
  const SelectDay({Key? key}) : super(key: key);

  @override
  State<SelectDay> createState() => _SelectDayState();
}

class _SelectDayState extends State<SelectDay> {
  List<DayModel> days = [
    DayModel(en: 'Sunday', th: 'วันอาทิตย์'),
    DayModel(en: 'Monday', th: 'วันจันทร์'),
    DayModel(en: 'Tuesday', th: 'วันอังคาร'),
    DayModel(en: 'Wednesday', th: 'วันพุธ'),
    DayModel(en: 'Thursday', th: 'วันพฤหัสบดี'),
    DayModel(en: 'Friday', th: 'วันศุกร์'),
    DayModel(en: 'Saturday', th: 'วันเสาร์')
  ];
  // @override
  // void initState() {
  //   super.initState();
  //   for (var element in AppConstant.day.entries) {
  //     days.add(DayModel(en: element.key, th: element.value));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'เลือกวัน',
          style: TextStyle(color: AppConstant.colorTextHeader),
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(
          color: AppConstant.colorTextHeader,
        ),
      ),
      backgroundColor: AppConstant.backgroudApp,
      body: BlocBuilder<ManagePackageBloc, ManagePackageState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: width * 1,
                  height: height * 1,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: days.length,
                    itemBuilder: (itemBuilder, index) {
                      bool isMatch = state.dayForrents.contains(days[index].en);
                      return InkWell(
                        onTap: () {
                          if (isMatch) {
                            context.read<ManagePackageBloc>().add(
                                  RemoveDayEvent(
                                    day: days[index].en,
                                  ),
                                );
                          } else {
                            context
                                .read<ManagePackageBloc>()
                                .add(AddDayEvent(day: days[index].en));
                          }
                        },
                        child: Card(
                          color: AppConstant.bgTextFormField,
                          margin: const EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  days[index].th,
                                  style: TextStyle(
                                    color: AppConstant.colorText,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(
                                  isMatch ? Icons.check : null,
                                  color: AppConstant.colorText,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
