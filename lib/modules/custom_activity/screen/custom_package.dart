import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/custom_activity/bloc/activity_bloc.dart';
import 'package:chonburi_mobileapp/modules/custom_activity/screen/packages_list.dart';
import 'package:chonburi_mobileapp/utils/helper/loop_id.dart';
import 'package:chonburi_mobileapp/utils/ui/material_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CustomPackage extends StatefulWidget {
  const CustomPackage({Key? key}) : super(key: key);

  @override
  State<CustomPackage> createState() => _CustomPackageState();
}

class _CustomPackageState extends State<CustomPackage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<ActivityBloc, ActivityState>(
      builder: (context, state) {
        DateTime checkDate = state.checkDate;
        return Scaffold(
          body: SingleChildScrollView(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              behavior: HitTestBehavior.opaque,
              child: Form(
                key: _formKey,
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
                            DateTime? picked = await buildMaterialDatePicker(
                                context, checkDate);
                            if (picked != null) {
                              // ignore: use_build_context_synchronously
                              context.read<ActivityBloc>().add(
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
                                  context.read<ActivityBloc>().add(
                                        FetchActivityEvent(
                                          totalMembers: state.totalMember + 1,
                                          checkDate: DateFormat('EEEE')
                                              .format(checkDate),
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
                                        context.read<ActivityBloc>().add(
                                              FetchActivityEvent(
                                                totalMembers:
                                                    state.totalMember - 1,
                                                checkDate: DateFormat('EEEE')
                                                    .format(checkDate),
                                              ),
                                            );
                                      }
                                    : null,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        width: width * 1,
                        height: height * 0.4,
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: state.activities.length,
                          itemBuilder: (context, index) => Container(
                            margin: const EdgeInsets.all(4),
                            width: width * 0.4,
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<ActivityBloc>().add(
                                      SelectHasTagEvent(
                                        activitySelectedModel:
                                            state.activities[index],
                                      ),
                                    );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                primary: state.activities[index].selected
                                    ? AppConstant.bgHasTaged
                                    : AppConstant.bgHastag,
                              ),
                              child: Text(
                                '# ${state.activities[index].activityName}',
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 2,
                              ),
                            ),
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 12,
                            childAspectRatio: width / height / 0.2,
                          ),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: state.activities.isEmpty
                              ? null
                              : () {
                                  List<String> activitiesID =
                                      loopSelectHasTag(state.activities);
                                  context.read<ActivityBloc>().add(
                                        FetchsPackagesEvent(
                                          activitiesID: activitiesID,
                                          day: DateFormat('EEEE')
                                              .format(checkDate),
                                        ),
                                      );
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
            ),
          ),
        );
      },
    );
  }
}
