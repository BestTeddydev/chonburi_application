import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/models/user_model.dart';
import 'package:chonburi_mobileapp/modules/businesses/models/business_models.dart';
import 'package:chonburi_mobileapp/modules/category/models/category_model.dart';
import 'package:chonburi_mobileapp/modules/otop/models/product_cart_model.dart';
import 'package:chonburi_mobileapp/modules/product/models/product_models.dart';
import 'package:chonburi_mobileapp/widget/dialog_comfirm.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  final List<CategoryModel> categories;
  final List<ProductModel> products;
  final UserModel user;
  final BusinessModel otop;
  final Function funcAddToCart;
  final Function funcUpdateToCard;
  final String businessName;
  final List<ProductCartModel> productCarts;
  const ProductList({
    Key? key,
    required this.categories,
    required this.products,
    required this.otop,
    required this.user,
    required this.funcAddToCart,
    required this.businessName,
    required this.productCarts,
    required this.funcUpdateToCard,
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
        List<ProductModel> productsCategory = products
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
            children: productsCategory.isNotEmpty
                ? [
                    TextCustom(
                      title: categoryModel.categoryName,
                      fontSize: 14,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: productsCategory.length,
                      itemBuilder: (context, indexFood) {
                        ProductModel product = productsCategory[indexFood];
                        List<ProductCartModel> productCartById = productCarts
                            .where(
                              (element) => element.productId == product.id,
                            )
                            .toList();
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
                                    pathImage: product.imageRef,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(10),
                                width: width * 0.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                child: Column(
                                  children: [
                                    SizedBox(
                                      child: productCartById.isNotEmpty
                                          ? IconButton(
                                              onPressed: () {
                                                if (!otop.statusOpen) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (builder) =>
                                                        const DialogError(
                                                      message:
                                                          'ร้านค้ายังไม่เปิดให้บริการ ณ ขณะนี้ ขออภัยในความไม่สะดวก',
                                                    ),
                                                  );
                                                }
                                                ProductCartModel productCart =
                                                    ProductCartModel(
                                                  productId: product.id,
                                                  productName:
                                                      product.productName,
                                                  businessId:
                                                      product.businessId,
                                                  amount: productCartById[0]
                                                          .amount -
                                                      1,
                                                  totalPrice: product.price,
                                                  price: product.price,
                                                  businessName: businessName,
                                                  userId: user.userId,
                                                  imageURL: product.imageRef,
                                                  weight: product.weight,
                                                  width: product.width,
                                                  height: product.height,
                                                  long: product.long,
                                                );
                                                funcUpdateToCard(productCart);
                                              },
                                              icon: const Icon(
                                                Icons.remove_circle,
                                              ),
                                              color: AppConstant.bgbutton,
                                            )
                                          : null,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppConstant.themeApp,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: productCartById.isNotEmpty
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: TextCustom(
                                                title: productCartById[0]
                                                    .amount
                                                    .toString(),
                                              ),
                                            )
                                          : null,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        if (user.token.isEmpty) {
                                          dialogWarningLogin(context);
                                          return;
                                        }
                                        if (!otop.statusOpen) {
                                          showDialog(
                                            context: context,
                                            builder: (builder) =>
                                                const DialogError(
                                              message:
                                                  'ร้านค้ายังไม่เปิดให้บริการ ณ ขณะนี้ ขออภัยในความไม่สะดวก',
                                            ),
                                          );
                                        }
                                        ProductCartModel productCart =
                                            ProductCartModel(
                                          productId: product.id,
                                          productName: product.productName,
                                          businessId: product.businessId,
                                          amount: productCartById.isEmpty
                                              ? 1
                                              : productCartById[0].amount + 1,
                                          totalPrice: product.price,
                                          price: product.price,
                                          businessName: businessName,
                                          userId: user.userId,
                                          imageURL: product.imageRef,
                                          weight: product.weight,
                                          width: product.width,
                                          height: product.height,
                                          long: product.long,
                                        );
                                        if (productCartById.isEmpty) {
                                          funcAddToCart(productCart);
                                        } else {
                                          funcUpdateToCard(productCart);
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.add_circle,
                                      ),
                                      color: AppConstant.bgbutton,
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
