import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:flutter/material.dart';

Future<DateTime?> buildMaterialDatePicker(
    BuildContext context, DateTime initialDate) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(2021),
    lastDate: DateTime(2100),
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    initialDatePickerMode: DatePickerMode.day,
    cancelText: 'ยกเลิก',
    confirmText: 'เลือก',
    errorFormatText: 'Enter valid date',
    errorInvalidText: 'Enter date in valid range',
    fieldLabelText: 'dashboard date',
    fieldHintText: 'Month/Date/Year',
    builder: (context, child) {
      return Theme(
        data: ThemeData.from(
            colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: const Color.fromRGBO(147, 187, 205, 1),
          onPrimary: const Color.fromRGBO(45, 95, 108, 1),
          secondary: AppConstant.themeApp,
          onSecondary: AppConstant.themeApp,
          error: AppConstant.bgCancelActivity,
          onError: AppConstant.bgCancelActivity,
          background: Colors.white,
          onBackground: Colors.white,
          surface: Colors.black,
          onSurface: AppConstant.colorText,
        )),
        child: child!,
      );
    },
  );
  return picked;
}
