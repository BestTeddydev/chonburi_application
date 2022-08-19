import 'package:chonburi_mobileapp/modules/category/bloc/category_bloc.dart';
import 'package:chonburi_mobileapp/modules/category/models/category_model.dart';
import 'package:chonburi_mobileapp/modules/food/bloc/food_bloc.dart';
import 'package:chonburi_mobileapp/modules/food/models/food_model.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodInCategory extends StatefulWidget {
  const FoodInCategory({Key? key}) : super(key: key);

  @override
  State<FoodInCategory> createState() => _FoodInCategoryState();
}

class _FoodInCategoryState extends State<FoodInCategory> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<FoodBloc, FoodState>(
      builder: (context, state) {
        return BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, stateCategory) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: stateCategory.categories.length,
              itemBuilder: (context, index) {
                CategoryModel categoryModel = stateCategory.categories[index];
                List<FoodModel> foods = state.foods
                    .where(
                      (element) => element.categoryId == categoryModel.id,
                    )
                    .toList();
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextCustom(title: categoryModel.categoryName),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: foods.length,
                          itemBuilder: (context, indexFood) {
                            FoodModel food = foods[indexFood];
                            return Card(
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    width: width * 0.24,
                                    height: 80,
                                    child: ShowImageNetwork(
                                      pathImage: food.imageRef,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextCustom(
                                          title: food.foodName,
                                          maxLine: 2,
                                        ),
                                        TextCustom(
                                          title: '${food.price} ฿',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
