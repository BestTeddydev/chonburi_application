import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:flutter/material.dart';
class TextFormPassword extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String requiredText;
  final bool eyesPassword;
  final Function onPressedEye;
  final Color? background;
  final Color? fontColor;
  final int? maxLines;
  const TextFormPassword({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.requiredText,
    required this.eyesPassword,
    required this.onPressedEye,
    this.background,
    this.fontColor,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: eyesPassword,
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
        suffixIcon: IconButton(
                  icon: eyesPassword
                      ? Icon(Icons.remove_red_eye, color:fontColor ?? AppConstant.colorText)
                      : Icon(Icons.remove_red_eye_outlined,
                          color: fontColor ?? AppConstant.colorText),
                  onPressed: () => onPressedEye(),
                ),
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