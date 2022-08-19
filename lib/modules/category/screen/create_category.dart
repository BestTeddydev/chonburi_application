import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/category/bloc/category_bloc.dart';
import 'package:chonburi_mobileapp/modules/category/models/category_model.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/dialog_loading.dart';
import 'package:chonburi_mobileapp/widget/dialog_success.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:chonburi_mobileapp/widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCategory extends StatefulWidget {
  final String token, businessId;
  const CreateCategory({
    Key? key,
    required this.businessId,
    required this.token,
  }) : super(key: key);

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController categoryNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BlocListener<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state.loading) {
          showDialog(
            context: context,
            builder: (builder) => const DialogLoading(),
          );
        }
        if (state.loaded) {
          showDialog(
            context: context,
            builder: (builder) => DialogSuccess(message: state.message),
          );
        }
        if (state.hasError) {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (builder) => DialogError(message: state.message),
          );
        }
      },
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'สร้างหมวดหมู่',
                style: TextStyle(color: AppConstant.colorTextHeader),
              ),
              backgroundColor: AppConstant.themeApp,
              iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
            ),
            body: SingleChildScrollView(
                child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: width * 0.7,
                      margin: const EdgeInsets.all(10),
                      child: TextFormFieldCustom(
                        controller: categoryNameController,
                        labelText: 'ชื่อหมวดหมู่',
                        requiredText: 'กรุณากรอกชื่อหมวดหมู่',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          CategoryModel category = CategoryModel(
                            id: '',
                            categoryName: categoryNameController.text,
                            businessId: widget.businessId,
                          );
                          context.read<CategoryBloc>().add(
                                CreateCategoryEvent(
                                  token: widget.token,
                                  category: category,
                                ),
                              );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: AppConstant.themeApp,
                      ),
                      child: const TextCustom(
                        title: 'สร้างหมวดหมู่',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            )),
          );
        },
      ),
    );
  }
}
