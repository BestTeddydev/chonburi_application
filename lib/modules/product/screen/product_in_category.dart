import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/category/bloc/category_bloc.dart';
import 'package:chonburi_mobileapp/modules/category/models/category_model.dart';
import 'package:chonburi_mobileapp/modules/product/bloc/product_bloc.dart';
import 'package:chonburi_mobileapp/modules/product/models/product_models.dart';
import 'package:chonburi_mobileapp/modules/product/screen/edit_product.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductInCategory extends StatefulWidget {
  final String token;
  const ProductInCategory({Key? key, required this.token}) : super(key: key);

  @override
  State<ProductInCategory> createState() => _ProductInCategoryState();
}

class _ProductInCategoryState extends State<ProductInCategory> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, stateCategory) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: stateCategory.categories.length,
              itemBuilder: (context, index) {
                CategoryModel categoryModel = stateCategory.categories[index];
                List<ProductModel> products = state.products
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
                        itemCount: products.length,
                        itemBuilder: (context, indexProduct) {
                          ProductModel product = products[indexProduct];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => EditProduct(
                                    category: categoryModel,
                                    product: product,
                                    token: widget.token,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    width: width * 0.24,
                                    height: 80,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: ShowImageNetwork(
                                        pathImage: product.imageRef,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextCustom(
                                          title: product.productName,
                                          maxLine: 2,
                                        ),
                                        TextCustom(
                                          title: '${product.price} ฿',
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.1,
                                    child: Switch(
                                      value: product.status,
                                      activeColor: AppConstant.themeApp,
                                      onChanged: (bool status) {
                                        if (status != product.status) {
                                          context.read<ProductBloc>().add(
                                                UpdateStatusEvent(
                                                  token: widget.token,
                                                  productModel: product
                                                      .copyWith(status: status),
                                                ),
                                              );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
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
