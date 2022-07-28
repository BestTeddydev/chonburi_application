import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final String title;
  final Color? bgbutton;
  final Color? fontColor;
  final Function onPressed;
  final int? borderRadiusSize;
  const ButtonCustom({
    Key? key,
    required this.title,
    required this.onPressed,
    this.bgbutton,
    this.borderRadiusSize,
    this.fontColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style:
          ElevatedButton.styleFrom(primary: bgbutton ?? AppConstant.bgbutton),
      child: const TextCustom(
        title: 'เลือกรูปภาพ',
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
