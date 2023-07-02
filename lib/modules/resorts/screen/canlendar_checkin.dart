import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/resorts/bloc/resort_bloc.dart';
import 'package:chonburi_mobileapp/modules/resorts/screen/resorts.dart';
import 'package:chonburi_mobileapp/utils/ui/material_date_picker.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CalendarCheckIn extends StatefulWidget {
  const CalendarCheckIn({Key? key}) : super(key: key);

  @override
  State<CalendarCheckIn> createState() => _CalendarCheckInState();
}

class _CalendarCheckInState extends State<CalendarCheckIn> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<ResortBloc, ResortState>(
      builder: (context, state) {
        DateTime checkDate = state.checkInDate;
        return Scaffold(
          appBar: AppBar(
            title: const TextCustom(title: 'เช็คอิน'),
            backgroundColor: AppConstant.themeApp,
            iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
          ),
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
                      "วันไป",
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
                          context.read<ResortBloc>().add(
                                SelectCheckInDate(date: picked),
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
                      left: 8.0,
                      top: 10,
                    ),
                    child: Text(
                      "วันกลับ",
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
                            context, state.checkOutDate);
                        if (picked != null) {
                          // ignore: use_build_context_synchronously
                          context.read<ResortBloc>().add(
                                SelectCheckOutDate(date: picked),
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
                                DateFormat('dd').format(state.checkOutDate),
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
                                DateFormat('MM').format(state.checkOutDate),
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
                                DateFormat('yyyy').format(state.checkOutDate),
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
                      'กรุณาเลือกจำนวนผู้เข้าใช้บริการ',
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
                              context.read<ResortBloc>().add(
                                    TotalMemberResortEvent(
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
                                    context.read<ResortBloc>().add(
                                          TotalMemberResortEvent(
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
                        if (state.totalMember <= 0) {
                          showDialog(
                            context: context,
                            builder: (builder) =>
                                const DialogError(message: "กรุณาเพิ่มจำนวนคน"),
                          );
                          return;
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => const Resorts(),
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
