import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/modules/contact_info/bloc/contact_bloc.dart';
import 'package:chonburi_mobileapp/modules/contact_info/screen/contact_detail.dart';
import 'package:chonburi_mobileapp/modules/otop/bloc/otop_bloc.dart';
import 'package:chonburi_mobileapp/modules/otop/models/product_cart_model.dart';
import 'package:chonburi_mobileapp/modules/otop/screen/checkout_order.dart';
import 'package:chonburi_mobileapp/modules/otop/screen/components/card_product_order.dart';
import 'package:chonburi_mobileapp/modules/tracking_order_otop/models/order_otop_model.dart';
import 'package:chonburi_mobileapp/utils/helper/calculate_shipping.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmOrder extends StatefulWidget {
  final String businessId;
  const ConfirmOrder({Key? key, required this.businessId}) : super(key: key);

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
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

  double sumPrice(List<ProductCartModel> products) {
    double totalPrice = 0;
    for (ProductCartModel product in products) {
      totalPrice += product.price * product.amount;
    }
    return totalPrice;
  }

  double sumWHL(List<ProductCartModel> products) {
    double totalWHL = 0;
    for (ProductCartModel product in products) {
      num total = product.width + product.height + product.long;
      totalWHL += total;
    }
    return totalWHL;
  }

  double sumWeight(List<ProductCartModel> products) {
    double totalWeight = 0;
    for (ProductCartModel product in products) {
      totalWeight += product.weight;
    }
    return totalWeight;
  }

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
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ยืนยันคำสั่งซื้อ',
          style: TextStyle(color: AppConstant.colorText),
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(color: AppConstant.colorText),
      ),
      backgroundColor: AppConstant.backgroudApp,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ContactDetail(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'สรุปคำสั่งซื้อ',
                  style: TextStyle(
                    color: AppConstant.colorText,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              BlocBuilder<OtopBloc, OtopState>(
                builder: (context, state) {
                  List<ProductCartModel> productsInOrders = state.cartProduct
                      .where(
                        (element) => element.businessId == widget.businessId,
                      )
                      .toList();
                  double totalPrice = sumPrice(productsInOrders);
                  double totalWHL = sumWHL(productsInOrders);
                  double totalWeight = sumWeight(productsInOrders);
                  return SizedBox(
                    width: width * 1,
                    height: height * 0.7,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: productsInOrders.length,
                            itemBuilder: (context, index) {
                              ProductCartModel product =
                                  productsInOrders[index];
                              return CardProductOrder(
                                width: width,
                                product: product,
                                removeProduct: onRemoveProduct,
                              );
                            },
                          ),
                        ),
                        cardBriefOrder(
                            state, totalPrice, totalWHL, totalWeight),
                        BlocBuilder<UserBloc, UserState>(
                          builder: (context, stateUser) {
                            return BlocBuilder<ContactBloc, ContactState>(
                              builder: (context, stateContact) {
                                double resultShipping = CalculateShipping()
                                    .calculateShipping(totalWHL, totalWeight);
                                return SizedBox(
                                  width: width * 0.8,
                                  child: ElevatedButton(
                                    onPressed: totalPrice <= 0 ||
                                            stateContact
                                                .myContact.userId.isEmpty
                                        ? null
                                        : () {
                                            OrderOtopModel orderOtopModel =
                                                OrderOtopModel(
                                              id: '',
                                              user: stateUser.user,
                                              contact: stateContact.myContact,
                                              totalPrice: totalPrice,
                                              prepaidPrice: totalPrice / 2,
                                              imagePayment: [],
                                              business: state.otop,
                                              status: AppConstant.payPrePaid,
                                              reviewed: false,
                                              product: productsInOrders,
                                              shippingPrice: resultShipping,
                                            );
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (builder) =>
                                                    CheckoutOrderProduct(
                                                  accountName:
                                                      state.otop.sellerId,
                                                  accountNumber:
                                                      state.otop.paymentNumber,
                                                  businessName:
                                                      state.otop.businessName,
                                                  prepaidPrice:
                                                      "${(totalPrice / 2)}",
                                                  qrcodeRef:
                                                      state.otop.qrcodeRef,
                                                  totalPrice: "$totalPrice",
                                                  typePayment:
                                                      state.otop.typePayment,
                                                  businessId: state.otop.id,
                                                  order: orderOtopModel,
                                                  user: stateUser.user,
                                                  shippingPrice:
                                                      "$resultShipping",
                                                ),
                                              ),
                                            );
                                          },
                                    style: ElevatedButton.styleFrom(
                                      primary: AppConstant.bgTextFormField,
                                    ),
                                    child: const TextCustom(
                                      title: 'ชำระเงิน',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card cardBriefOrder(
    OtopState state,
    double totalPrice,
    double totalSize,
    double totalWeight,
  ) {
    double resultShipping =
        CalculateShipping().calculateShipping(totalSize, totalWeight);
    return Card(
      color: AppConstant.bgTextFormField,
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'คำสั่งซื้อทั้งหมด ( ${state.cartProduct.length} รายการ )',
                  style: TextStyle(
                    color: AppConstant.colorText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '$totalPrice ฿',
                  style: TextStyle(
                    color: AppConstant.colorText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ค่าส่ง',
                  style: TextStyle(
                    color: AppConstant.colorText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '$resultShipping ฿',
                  style: TextStyle(
                    color: AppConstant.colorText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'จ่ายล่วงหน้า 50 % + ค่าส่ง',
                  style: TextStyle(
                    color: AppConstant.colorText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${totalPrice / 2 + resultShipping} ฿',
                  style: TextStyle(
                    color: AppConstant.colorText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
