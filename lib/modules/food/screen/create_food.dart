import 'dart:io';

import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/category/bloc/category_bloc.dart';
import 'package:chonburi_mobileapp/modules/category/screen/select_category.dart';
import 'package:chonburi_mobileapp/modules/food/bloc/food_bloc.dart';
import 'package:chonburi_mobileapp/modules/food/models/food_model.dart';
import 'package:chonburi_mobileapp/widget/dialog_camera.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/dialog_loading.dart';
import 'package:chonburi_mobileapp/widget/dialog_success.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:chonburi_mobileapp/widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateFood extends StatefulWidget {
  final String token, businessId;
  const CreateFood({
    Key? key,
    required this.businessId,
    required this.token,
  }) : super(key: key);

  @override
  State<CreateFood> createState() => _CreateFoodState();
}

class _CreateFoodState extends State<CreateFood> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController foodNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  onSelectImageFood(File image) {
    context.read<FoodBloc>().add(SelectImageFoodEvent(imageRef: image));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'สร้างอาหาร',
          style: TextStyle(color: AppConstant.colorTextHeader),
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
      ),
      body: BlocListener<FoodBloc, FoodState>(
        listener: (context, state) {
          if (state.loading) {
            showDialog(
              context: context,
              builder: (builder) => const DialogLoading(),
            );
          }
          if (state.loaded) {
            Navigator.pop(context);
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
        child: BlocBuilder<FoodBloc, FoodState>(
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, categoryState) {
                  return Center(
                    child: SizedBox(
                      width: width * 0.7,
                      child: ListView(
                        children: [
                          Container(
                            width: width * 0.7,
                            margin: const EdgeInsets.all(10),
                            child: TextFormFieldCustom(
                              controller: foodNameController,
                              labelText: 'ชื่ออาหาร',
                              requiredText: 'กรุณากรอกชื่ออาหาร',
                            ),
                          ),
                          Container(
                            width: width * 0.7,
                            margin: const EdgeInsets.all(10),
                            child: TextFormFieldCustom(
                              controller: priceController,
                              labelText: 'ราคา',
                              requiredText: 'กรุณากรอกราคา',
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => const SelectCategory(),
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              width: width * 0.7,
                              decoration: BoxDecoration(
                                color: AppConstant.bgTextFormField,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextCustom(
                                  title: categoryState
                                          .selectedCategory.categoryName.isEmpty
                                      ? 'เลือกหมวดหมู่'
                                      : categoryState
                                          .selectedCategory.categoryName,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: width * 0.7,
                            margin: const EdgeInsets.all(10),
                            child: TextFormFieldCustom(
                              controller: descriptionController,
                              labelText: 'รายละเอียด',
                              requiredText: '',
                              maxLines: 3,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 14),
                            width: width * 0.66,
                            height: height * 0.2,
                            decoration: BoxDecoration(
                              color: AppConstant.bgTextFormField,
                            ),
                            child: state.imageFood.path.isNotEmpty
                                ? Image.file(
                                    state.imageFood,
                                    fit: BoxFit.fill,
                                  )
                                : Center(
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      color: AppConstant.colorText,
                                      size: 40,
                                    ),
                                  ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            width: width * 0.4,
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () => dialogCamera(
                                context,
                                onSelectImageFood,
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: AppConstant.bgTextFormField,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.add_a_photo_outlined,
                                      color: AppConstant.colorText,
                                      size: 15,
                                    ),
                                  ),
                                  Text(
                                    'เพิ่มรูปภาพอาหาร',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: AppConstant.colorText,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  categoryState
                                      .selectedCategory.id.isNotEmpty) {
                                FoodModel foodModel = FoodModel(
                                  id: '',
                                  foodName: foodNameController.text,
                                  price: double.parse(priceController.text),
                                  imageRef: '',
                                  businessId: widget.businessId,
                                  categoryId: categoryState.selectedCategory.id,
                                  description: descriptionController.text,
                                  status: 1,
                                );
                                context.read<FoodBloc>().add(
                                      CreateFoodEvent(
                                        token: widget.token,
                                        foodModel: foodModel,
                                      ),
                                    );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (builder) => const DialogError(
                                    message: 'กรุณากรอกข้อมูลให้ครบ',
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: AppConstant.themeApp,
                            ),
                            child: const TextCustom(
                              title: 'สร้างข้อมูลอาหาร',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
