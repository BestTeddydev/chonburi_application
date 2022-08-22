import 'dart:io';

import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/category/bloc/category_bloc.dart';
import 'package:chonburi_mobileapp/modules/category/screen/select_category.dart';
import 'package:chonburi_mobileapp/modules/product/bloc/product_bloc.dart';
import 'package:chonburi_mobileapp/modules/product/models/product_models.dart';
import 'package:chonburi_mobileapp/widget/dialog_camera.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/dialog_loading.dart';
import 'package:chonburi_mobileapp/widget/dialog_success.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:chonburi_mobileapp/widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateProduct extends StatefulWidget {
  final String token, businessId;
  const CreateProduct({
    Key? key,
    required this.businessId,
    required this.token,
  }) : super(key: key);

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController widthtController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController longController = TextEditingController();

  @override
  void initState() {
    context.read<CategoryBloc>().add(ClearSelectedCategoryEvent());
    super.initState();
  }

  onSelectImageProduct(File image) {
    context.read<ProductBloc>().add(SelectImageProductEvent(imageRef: image));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'สร้างข้อมูลสินค้าโอท็อป',
          style: TextStyle(color: AppConstant.colorTextHeader),
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
      ),
      body: BlocListener<ProductBloc, ProductState>(
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
        child: BlocBuilder<ProductBloc, ProductState>(
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
                                controller: productNameController,
                                labelText: 'ชื่อสินค้า',
                                requiredText: 'กรุณากรอกชื่อสินค้า',
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
                            Container(
                              width: width * 0.7,
                              margin: const EdgeInsets.all(10),
                              child: TextFormFieldCustom(
                                controller: weightController,
                                labelText: 'น้ำหนัก กม.',
                                requiredText: 'กรุณากรอกน้ำหนัก',
                                textInputType: TextInputType.number,
                              ),
                            ),
                            Container(
                              width: width * 0.7,
                              margin: const EdgeInsets.all(10),
                              child: TextFormFieldCustom(
                                controller: heightController,
                                labelText: 'ความสูง(ซม.)',
                                requiredText: 'กรุณากรอกความสูง',
                                textInputType: TextInputType.number,
                              ),
                            ),
                            Container(
                              width: width * 0.7,
                              margin: const EdgeInsets.all(10),
                              child: TextFormFieldCustom(
                                controller: widthtController,
                                labelText: 'ความกว้าง(ซม.)',
                                requiredText: 'กรุณากรอกความกว้าง',
                                textInputType: TextInputType.number,
                              ),
                            ),
                            Container(
                              width: width * 0.7,
                              margin: const EdgeInsets.all(10),
                              child: TextFormFieldCustom(
                                controller: longController,
                                labelText: 'ความยาว(ซม.)',
                                requiredText: 'กรุณากรอกความยาว',
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
                              child: state.imageProduct.path.isNotEmpty
                                  ? Image.file(
                                      state.imageProduct,
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
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              width: width * 0.4,
                              height: 30,
                              child: ElevatedButton(
                                onPressed: () => dialogCamera(
                                  context,
                                  onSelectImageProduct,
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
                                      'เพิ่มรูปภาพสินค้า',
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
                                  ProductModel productModel = ProductModel(
                                    id: '',
                                    productName: productNameController.text,
                                    price: double.parse(priceController.text),
                                    imageRef: '',
                                    businessId: widget.businessId,
                                    categoryId:
                                        categoryState.selectedCategory.id,
                                    description: descriptionController.text,
                                    status: true,
                                    height: double.parse(heightController.text),
                                    long: double.parse(longController.text),
                                    weight: double.parse(weightController.text),
                                    width: double.parse(
                                      widthtController.text,
                                    ),
                                  );
                                  context.read<ProductBloc>().add(
                                        CreateProductEvent(
                                            token: widget.token,
                                            productModel: productModel),
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
                                title: 'สร้างข้อมูลสินค้า',
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
