import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:flutter/material.dart';

class TextSearch extends StatelessWidget {
  final TextEditingController searchController;
  final Function funcSearch;
  final Function funcClear;
  final String labelText;
  final bool isSearch; // สถานะ ค้นหา แล้วหรือยัง
  const TextSearch({
    Key? key,
    required this.funcClear,
    required this.funcSearch,
    required this.searchController,
    required this.labelText,
    required this.isSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchController,
      onChanged: (value) {
        if (value.isEmpty && isSearch) {
          funcClear();
        }
      },
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: labelText,
        labelStyle: TextStyle(color: AppConstant.colorText),
        suffixIcon: IconButton(
          icon: Icon(Icons.search, color: AppConstant.colorText),
          onPressed: () {
            if (!isSearch && searchController.text.isNotEmpty) {
              funcSearch();
            }
          },
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppConstant.bgTextFormField),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppConstant.bgTextFormField),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
