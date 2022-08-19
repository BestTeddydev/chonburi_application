import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/category/bloc/category_bloc.dart';
import 'package:chonburi_mobileapp/modules/food/bloc/food_bloc.dart';
import 'package:chonburi_mobileapp/modules/food/screen/create_food.dart';
import 'package:chonburi_mobileapp/modules/food/screen/food_in_category.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/screen/components/header_create_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainFood extends StatefulWidget {
  final String businessId, token;
  const MainFood({
    Key? key,
    required this.businessId,
    required this.token,
  }) : super(key: key);

  @override
  State<MainFood> createState() => _MainFoodState();
}

class _MainFoodState extends State<MainFood> {
  @override
  void initState() {
    context
        .read<CategoryBloc>()
        .add(FetchCategoryEvent(businessId: widget.businessId));
    context.read<FoodBloc>().add(FetchFoodEvent(businessId: widget.businessId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'รายการอาหาร',
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
            createProduct: CreateFood(
              businessId: widget.businessId,
              token: widget.token,
            ),
            type: 'อาหาร',
          ),
          const FoodInCategory(),
        ],
      ),
    );
  }
}
