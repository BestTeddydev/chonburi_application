import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:flutter/material.dart';

class DialogError extends StatelessWidget {
  final String message;
  const DialogError({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 90,
        child: Column(children: [
          Icon(
            Icons.highlight_off_rounded,
            color: AppConstant.bgCancelActivity,
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
