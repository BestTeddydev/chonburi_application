import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TextFormPhone extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String requiredText;
  final Color? background;
  final Color? fontColor;
  final int? maxLines;
  const TextFormPhone({
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
    MaskTextInputFormatter phoneMask = MaskTextInputFormatter(
      mask: '###-###-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );
    return TextFormField(
      inputFormatters: [phoneMask],
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
