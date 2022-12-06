import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/modules/otop/bloc/otop_bloc.dart';
import 'package:chonburi_mobileapp/modules/otop/models/product_cart_model.dart';
import 'package:chonburi_mobileapp/modules/otop/screen/components/card_product_order.dart';
import 'package:chonburi_mobileapp/modules/otop/screen/confirm_order.dart';
import 'package:chonburi_mobileapp/modules/otop/screen/otop_detail.dart';
import 'package:chonburi_mobileapp/widget/dialog_comfirm.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartProducts extends StatefulWidget {
  const CartProducts({Key? key}) : super(key: key);

  @override
  State<CartProducts> createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  void onRemoveProduct(ProductCartModel product) {
    context.read<OtopBloc>().add(
          UpdateProductInCartEvent(
            productCart: product,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const TextCustom(
          title: 'ตะกร้าของคุณ',
          fontSize: 18,
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(color: AppConstant.colorText),
      ),
      backgroundColor: AppConstant.backgroudApp,
      body: BlocBuilder<OtopBloc, OtopState>(
        builder: (context, state) {
          List<String> businesses =
              state.cartProduct.map((e) => e.businessId).toSet().toList();
          return BlocBuilder<UserBloc, UserState>(
            builder: (context, userState) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: businesses.length,
                itemBuilder: (context, index) {
                  List<ProductCartModel> products = state.cartProduct
                      .where(
                          (element) => element.businessId == businesses[index])
                      .toList();
                  return Card(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 0.2,
                                color: AppConstant.colorText,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextCustom(title: products[0].businessName),
                                TextButton(
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (builder) => OtopDetail(
                                          businessId: products[0].businessId),
                                    ),
                                  ),
                                  child: const TextCustom(
                                    title: 'เยี่ยมชมร้านค้า',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListView.builder(
                          itemCount: products.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, indexProduct) {
                            ProductCartModel product = products[indexProduct];
                            return CardProductOrder(
                              width: width,
                              product: product,
                              removeProduct: onRemoveProduct,
                            );
                          },
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: 0.2,
                                color: AppConstant.colorText,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    if (userState.user.token.isEmpty) {
                                      dialogWarningLogin(context);
                                      return;
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (builder) => ConfirmOrder(
                                          businessId: products[0].businessId,
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: AppConstant.bgbutton,
                                  ),
                                  child: const TextCustom(
                                    title: 'ชำระเงิน',
                                    fontColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
