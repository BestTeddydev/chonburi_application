import 'package:flutter/material.dart';

class AppConstant {
  static String appName = 'chonburi';
  static String homeBuyerRoute = "/home/buyer";
  static String customPackage = "/custom/package";
  static String packageDetail = "/package/detail";
  static String aminService = '/adminService';
  static String sellerService = '/sellerService';

  // status
  static String waitingStatus = 'รออนุมัติ';
  static String acceptStatus = 'อนุมัติ';
  static String rejectStatus = 'ปฏิเสธ';
  static String pay = 'รอการชำระเงิน';
  static String payed = 'ชำระเงินแล้ว';

  static Map<String, String> tripsType = {
    "zero": 'เลือกประเภทแพ็คเกจ',
    '1d': 'วันเดย์ทริป',
    "2d1n": '2 วัน 1 คืน'
  };

  static Map<String, String> day = {
    "Sunday": "อา.",
    "Monday": "จ.",
    "Tuesday": "อ.",
    "Wednesday": "พ.",
    "Thursday": "พฤ.",
    "Friday": "ศ.",
    "Saturday": "ส.",
  };

  // color
  static Color backgroudApp = const Color.fromRGBO(238, 242, 255, 1);
  static Color themeApp = const Color.fromRGBO(201, 230, 243, 1);
  static Color bgActivityName = const Color.fromRGBO(216, 230, 237, 1);
  static Color bgChooseActivity = const Color.fromRGBO(159, 210, 138, 1);
  static Color bgCancelActivity = const Color.fromRGBO(236, 123, 123, 1);
  static Color bgTextFormField = const Color.fromRGBO(206, 229, 244, 1);
  static Color colorText = const Color.fromRGBO(93, 128, 137, 1);
  static Color colorTextHeader = const Color.fromRGBO(104, 160, 174, 1);
  static Color bgbutton = const Color.fromRGBO(126, 171, 184, 1);
  static Color bgHastag = const Color.fromRGBO(184, 203, 214, 1);
  static Color bgHasTaged = const Color.fromRGBO(135, 190, 230, 1);
  static Color bgAlert = const Color.fromRGBO(243, 251, 255, 1);
  static Color colorTextLogin = const Color.fromRGBO(105, 182, 239, 1);
  static Color blurLogin = const Color.fromRGBO(238, 242, 255, 1);
  static Color bgOrderCard = const Color.fromRGBO(243, 251, 255, 1);

  static Map<String, Color> statusColor = {
    waitingStatus: const Color.fromRGBO(241, 194, 50, 1),
    acceptStatus: bgChooseActivity,
    rejectStatus: bgCancelActivity,
    pay: const Color.fromRGBO(85, 150, 225, 1),
    payed: const Color.fromRGBO(85, 192, 95, 1)
  };
}
