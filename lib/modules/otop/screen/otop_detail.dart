import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/modules/businesses/models/business_models.dart';
import 'package:chonburi_mobileapp/modules/otop/bloc/otop_bloc.dart';
import 'package:chonburi_mobileapp/modules/otop/models/product_cart_model.dart';
import 'package:chonburi_mobileapp/modules/otop/screen/components/list_products.dart';
import 'package:chonburi_mobileapp/modules/otop/screen/confirm_order.dart';
import 'package:chonburi_mobileapp/widget/dialog_comfirm.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtopDetail extends StatefulWidget {
  final String businessId;
  const OtopDetail({Key? key, required this.businessId}) : super(key: key);

  @override
  State<OtopDetail> createState() => _OtopDetailState();
}

class _OtopDetailState extends State<OtopDetail> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    context.read<OtopBloc>().add(FetchOtopEvent(businessId: widget.businessId));
    context
        .read<OtopBloc>()
        .add(FetchsCategoryOtopEvent(businessId: widget.businessId));
    context
        .read<OtopBloc>()
        .add(FetchsProductsEvent(businessId: widget.businessId));
  }

  void addProductToCart(ProductCartModel productCart) {
    context.read<OtopBloc>().add(
          AddProductToCartEvent(
            productCart: productCart,
          ),
        );
  }

  void updateProductToCart(ProductCartModel productCart) {
    context
        .read<OtopBloc>()
        .add(UpdateProductInCartEvent(productCart: productCart));
  }

  double sumTotalProductCart(List<ProductCartModel> carts) {
    double sumPrice = 0;
    for (ProductCartModel cart in carts) {
      sumPrice += cart.totalPrice * cart.amount;
    }
    return sumPrice;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocBuilder<OtopBloc, OtopState>(
        builder: (context, state) {
          BusinessModel otop = state.otop;
          List<ProductCartModel> cartOfOtopByIds = state.cartProduct
              .where((element) => element.businessId == widget.businessId)
              .toList();
          double sumPrice = sumTotalProductCart(cartOfOtopByIds);
          return BlocBuilder<UserBloc, UserState>(
            builder: (context, stateUser) {
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: width * 1,
                              height: height * 0.25,
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white54,
                                    blurRadius: 5,
                                    offset: Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: ShowImageNetwork(
                                pathImage: otop.imageRef,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                color: AppConstant.backgroudApp,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () => Navigator.pop(context, true),
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: AppConstant.colorTextHeader,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                width: width * 0.7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextCustom(
                                      title: otop.businessName,
                                      maxLine: 2,
                                      fontSize: 16,
                                    ),
                                    TextCustom(
                                      title: 'ที่อยู่ ${otop.address}',
                                      maxLine: 3,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: width * 0.2,
                                child: IconButton(
                                  onPressed: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (builder) => otopAbout(
                                    //       otop: widget.otop,
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                  icon: Icon(
                                    Icons.info,
                                    color: AppConstant.colorText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ProductList(
                          categories: state.categories,
                          products: state.products,
                          otop: otop,
                          user: stateUser.user,
                          funcAddToCart: addProductToCart,
                          businessName: otop.businessName,
                          productCarts: state.cartProduct,
                          funcUpdateToCard: updateProductToCart,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    width: double.maxFinite,
                    height: height * 0.06,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width * 0.85,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: state.cartProduct.isEmpty
                                ? null
                                : () {
                                    if (stateUser.user.token.isEmpty) {
                                      dialogWarningLogin(context);
                                      return;
                                    }
                                    if (!otop.statusOpen) {
                                      showDialog(
                                        context: context,
                                        builder: (builder) => const DialogError(
                                          message:
                                              'ร้านค้ายังไม่เปิดให้บริการ ณ ขณะนี้ ขออภัยในความไม่สะดวก',
                                        ),
                                      );
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (builder) => ConfirmOrder(
                                          businessId: widget.businessId,
                                        ),
                                      ),
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                                primary: AppConstant.themeApp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextCustom(
                                  title: cartOfOtopByIds.length.toString(),
                                ),
                                const TextCustom(
                                  title: 'สั่งสินค้า',
                                  fontSize: 18,
                                ),
                                TextCustom(
                                  title: sumPrice.toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
