import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:flutter/material.dart';

class DialogSuccess extends StatelessWidget {
  final String message;
  const DialogSuccess({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 90,
        child: Column(children: [
          Icon(
            Icons.check_circle_outline,
            color: AppConstant.bgChooseActivity,
            size: 40,
          ),
          Text(
            message,
            style: TextStyle(color: AppConstant.colorText),
          ),
        ]),
      ),
    );
  }
}
