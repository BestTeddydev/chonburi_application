import 'package:chonburi_mobileapp/modules/category/models/category_model.dart';
import 'package:chonburi_mobileapp/modules/food/models/food_model.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';

class ListFoods extends StatelessWidget {
  final List<CategoryModel> categories;
  final List<FoodModel> foods;
  const ListFoods({
    Key? key,
    required this.categories,
    required this.foods,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        CategoryModel categoryModel = categories[index];
        List<FoodModel> foodsCategory = foods
            .where(
              (element) => element.categoryId == categoryModel.id,
            )
            .toList();
        return Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12.0,
            top: 6,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: foodsCategory.isNotEmpty
                ? [
                    TextCustom(
                      title: categoryModel.categoryName,
                      fontSize: 14,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: foodsCategory.length,
                      itemBuilder: (context, indexFood) {
                        FoodModel food = foodsCategory[indexFood];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: width * 0.24,
                                height: 80,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: ShowImageNetwork(
                                    pathImage: food.imageRef,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(10),
                                width: width * 0.55,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      },
                    ),
                  ]
                : [],
          ),
        );
      },
    );
  }
}
