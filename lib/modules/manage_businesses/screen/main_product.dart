import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/category/bloc/category_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/screen/components/header_create_edit.dart';
import 'package:chonburi_mobileapp/modules/product/bloc/product_bloc.dart';
import 'package:chonburi_mobileapp/modules/product/screen/create_product.dart';
import 'package:chonburi_mobileapp/modules/product/screen/product_in_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainProduct extends StatefulWidget {
  final String businessId, token;
  const MainProduct({
    Key? key,
    required this.businessId,
    required this.token,
  }) : super(key: key);

  @override
  State<MainProduct> createState() => _MainProductState();
}

class _MainProductState extends State<MainProduct> {
  @override
  void initState() {
    context
        .read<CategoryBloc>()
        .add(FetchCategoryEvent(businessId: widget.businessId));
    context
        .read<ProductBloc>()
        .add(FetchsProductEvent(businessId: widget.businessId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'รายการผลิตภัณฑ์ชุมชน',
          style: TextStyle(color: AppConstant.colorTextHeader),
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
      ),
      backgroundColor: AppConstant.backgroudApp,
      body: ListView(
        children: [
          HeaderCreateAndEdit(
            businessId: widget.businessId,
            token: widget.token,
            createProduct: CreateProduct(
              businessId: widget.businessId,
              token: widget.token,
            ),
            type: 'สินค้า',
          ),
          ProductInCategory(token: widget.token),
        ],
      ),
    );
  }
}
