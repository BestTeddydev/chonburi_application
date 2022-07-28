import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:flutter/material.dart';

class TextCustom extends StatelessWidget {
  final String title;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final int ? maxLine;
  const TextCustom({
    Key? key,
    this.fontColor,
    this.fontSize,
    this.fontWeight,
    this.maxLine,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      softWrap: true,
      maxLines: maxLine ?? 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: fontColor ?? AppConstant.colorText,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
    );
  }
}
