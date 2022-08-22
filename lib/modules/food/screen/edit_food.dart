import 'dart:io';

import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/category/bloc/category_bloc.dart';
import 'package:chonburi_mobileapp/modules/category/models/category_model.dart';
import 'package:chonburi_mobileapp/modules/category/screen/select_category.dart';
import 'package:chonburi_mobileapp/modules/food/bloc/food_bloc.dart';
import 'package:chonburi_mobileapp/modules/food/models/food_model.dart';
import 'package:chonburi_mobileapp/widget/dialog_camera.dart';
import 'package:chonburi_mobileapp/widget/dialog_comfirm.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/dialog_loading.dart';
import 'package:chonburi_mobileapp/widget/dialog_success.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:chonburi_mobileapp/widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditFood extends StatefulWidget {
  final String token;
  final FoodModel food;
  final CategoryModel category;
  const EditFood({
    Key? key,
    required this.food,
    required this.token,
    required this.category,
  }) : super(key: key);

  @override
  State<EditFood> createState() => _EditFoodState();
}

class _EditFoodState extends State<EditFood> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController foodNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    context.read<CategoryBloc>().add(
          SelectCategoryEvent(
            category: widget.category,
          ),
        );
    super.initState();
    foodNameController.text = widget.food.foodName;
    priceController.text = widget.food.price.toString();
    descriptionController.text = widget.food.description;
  }

  onSelectImageFood(File image) {
    context.read<FoodBloc>().add(SelectImageFoodEvent(imageRef: image));
  }

  onDeleteFood(BuildContext context) {
    context.read<FoodBloc>().add(
          DeleteFoodEvent(token: widget.token, docId: widget.food.id),
        );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'แก้ไขข้อมูลอาหาร',
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
            return GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              behavior: HitTestBehavior.opaque,
              child: Form(
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
                                textInputType: TextInputType.number,
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
                                    title: categoryState.selectedCategory
                                            .categoryName.isEmpty
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
                                  : ShowImageNetwork(
                                      pathImage: widget.food.imageRef,
                                    ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10),
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
                                      'อัพโหลดรูปภาพอาหาร',
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
                                dialogConfirm(
                                  context,
                                  onDeleteFood,
                                  'คุณแน่ใจที่จะลบเมนูอาหารใช่หรือไม่',
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: AppConstant.bgCancelActivity,
                              ),
                              child: const Text('ลบข้อมูลอาหาร'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                    categoryState
                                        .selectedCategory.id.isNotEmpty) {
                                  FoodModel foodModel = FoodModel(
                                    id: widget.food.id,
                                    foodName: foodNameController.text,
                                    price: double.parse(priceController.text),
                                    imageRef: widget.food.imageRef,
                                    businessId: widget.food.businessId,
                                    categoryId:
                                        categoryState.selectedCategory.id,
                                    description: descriptionController.text,
                                    status: 1,
                                  );
                                  context.read<FoodBloc>().add(
                                        EditFoodEvent(
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
                                title: 'แก้ไขข้อมูลอาหาร',
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
              ),
            );
          },
        ),
      ),
    );
  }
}
