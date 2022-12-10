import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/packages_tour/bloc/package_bloc.dart';
import 'package:chonburi_mobileapp/modules/packages_tour/screen/packages_list.dart';
import 'package:chonburi_mobileapp/utils/ui/material_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomePackages extends StatefulWidget {
  const HomePackages({Key? key}) : super(key: key);

  @override
  State<HomePackages> createState() => _HomePackagesState();
}

class _HomePackagesState extends State<HomePackages> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<PackageBloc, PackageState>(
      builder: (context, state) {
        DateTime checkDate = state.checkDate;
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      top: 10,
                    ),
                    child: Text(
                      "กรุณาเลือกวันที่ต้องการ",
                      style: TextStyle(
                        color: AppConstant.colorText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      try {
                        DateTime? picked =
                            await buildMaterialDatePicker(context, checkDate);
                        if (picked != null) {
                          // ignore: use_build_context_synchronously
                          context.read<PackageBloc>().add(
                                SelectCheckDate(date: picked),
                              );
                        }
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                    },
                    child: Row(
                      children: [
                        Container(
                          width: width * 0.2,
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppConstant.bgTextFormField,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Text(
                                DateFormat('dd').format(checkDate),
                                style: TextStyle(
                                  color: AppConstant.colorText,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: width * 0.2,
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppConstant.bgTextFormField,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Text(
                                DateFormat('MM').format(checkDate),
                                style: TextStyle(
                                  color: AppConstant.colorText,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: width * 0.2,
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppConstant.bgTextFormField,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Text(
                                DateFormat('yyyy').format(checkDate),
                                style: TextStyle(
                                  color: AppConstant.colorText,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 6.0,
                      top: 10,
                    ),
                    child: Text(
                      'กรุณาเลือกจำนวนสมาชิกที่ต้องการ',
                      style: TextStyle(
                        color: AppConstant.colorText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.5,
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppConstant.bgTextFormField,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'จำนวนคน',
                          style: TextStyle(
                            color: AppConstant.colorText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.add_circle,
                              color: AppConstant.colorTextHeader,
                            ),
                            onPressed: () {
                              context.read<PackageBloc>().add(
                                    TotalMemberEvent(
                                      member: state.totalMember + 1,
                                    ),
                                  );
                            },
                          ),
                        ),
                        Text(
                          state.totalMember.toString(),
                          style: TextStyle(
                            color: AppConstant.colorText,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.remove_circle,
                              color: AppConstant.colorTextHeader,
                            ),
                            onPressed: state.totalMember > 0
                                ? () {
                                    context.read<PackageBloc>().add(
                                          TotalMemberEvent(
                                            member: state.totalMember - 1,
                                          ),
                                        );
                                  }
                                : null,
                          ),
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // List<String> activitiesID =
                        //     loopSelectHasTag(state.activities);
                        // context.read<ActivityBloc>().add(
                        //       FetchsPackagesEvent(
                        //         activitiesID: activitiesID,
                        //         day: DateFormat('EEEE')
                        //             .format(checkDate),
                        //       ),
                        //     );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => const PackageList(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: AppConstant.bgbutton,
                      ),
                      child: const Text("ค้นหา"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
