import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:flutter/material.dart';

class TextFormFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String requiredText;
  final Color? background;
  final Color? fontColor;
  final int? maxLines;
  const TextFormFieldCustom({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.requiredText,
    this.background,
    this.fontColor,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty && requiredText.isNotEmpty) return requiredText;
        return null;
      },
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        fillColor: background ?? AppConstant.bgTextFormField,
        filled: true,
        labelText: labelText,
        labelStyle: TextStyle(color: fontColor ?? AppConstant.colorText),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: background ?? AppConstant.bgTextFormField),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: background ?? AppConstant.bgTextFormField),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: TextStyle(
        color: fontColor ?? AppConstant.colorText,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
