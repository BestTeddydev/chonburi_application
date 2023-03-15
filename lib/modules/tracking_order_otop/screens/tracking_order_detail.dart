import 'dart:io';

import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/modules/otop/models/product_cart_model.dart';
import 'package:chonburi_mobileapp/modules/tracking_order_otop/bloc/tracking_order_otop_bloc.dart';
import 'package:chonburi_mobileapp/modules/tracking_order_otop/models/order_otop_model.dart';
import 'package:chonburi_mobileapp/widget/dialog_camera.dart';
import 'package:chonburi_mobileapp/widget/dialog_order_otop.dart';
import 'package:chonburi_mobileapp/widget/dialog_success.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackOrderDetail extends StatefulWidget {
  final OrderOtopModel order;

  const TrackOrderDetail({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<TrackOrderDetail> createState() => _TrackOrderDetailState();
}

class _TrackOrderDetailState extends State<TrackOrderDetail> {
  List<DropdownMenuItem<String>> items = [
    AppConstant.approve,
    AppConstant.payPrePaid,
    AppConstant.payedOrder,
  ].map<DropdownMenuItem<String>>((String value) {
    String? status = AppConstant.translateStatus[value];
    return DropdownMenuItem<String>(
      value: value,
      child: TextCustom(
        title: status!,
        fontColor: Colors.white,
      ),
    );
  }).toList();

  @override
  void initState() {
    super.initState();
    setStatusOrder(widget.order.status);
  }

  setStatusOrder(String status) {
    context
        .read<TrackingOrderOtopBloc>()
        .add(BuyerSetInitOrderStatusEvent(status: status));
  }

  onChangeStatusOrder(
      BuildContext context, OrderOtopModel order, String token, File image) {
    //fix order status payedOrder
    context.read<TrackingOrderOtopBloc>().add(
          BuyerUpdateOrderOtopEvent(
            token: token,
            orderOtopModel: order,
            imagePayment: image,
          ),
        );
  }

  onSelectImagePayment(File selectImage) {
    context
        .read<TrackingOrderOtopBloc>()
        .add(BuyerSelectImagePaymentEvent(image: selectImage));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: TextCustom(
          title: widget.order.business.businessName,
          fontSize: 18,
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
      ),
      backgroundColor: AppConstant.backgroudApp,
      body: SafeArea(
        child: BlocBuilder<TrackingOrderOtopBloc, TrackingOrderOtopState>(
          builder: (context, state) {
            String? status = AppConstant.translateStatus[widget.order.status];
            return ListView(
              shrinkWrap: true,
              children: [
                Card(
                  margin: const EdgeInsets.all(8),
                  child: SizedBox(
                    width: width * 1,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.person_outline_outlined),
                            TextCustom(
                              title:
                                  "${widget.order.user.firstName} ${widget.order.user.lastName}",
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.phone_android),
                            TextCustom(
                              title: widget.order.business.phoneNumber,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.monetization_on_outlined),
                            TextCustom(
                              title:
                                  "จ่ายล่วงหน้า ${widget.order.prepaidPrice} บาท",
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.monetization_on_outlined),
                            TextCustom(
                              title:
                                  "ราคาค้างชำระ + ค่าส่ง ${widget.order.prepaidPrice + widget.order.shippingPrice} บาท",
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.pin_drop_outlined),
                            TextCustom(
                              title: widget.order.contact.address,
                              maxLine: 3,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.account_balance_outlined),
                            TextCustom(
                              title: widget.order.business.typePayment,
                              maxLine: 1,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 8.0),
                              width: width * 0.6,
                              child: TextCustom(
                                title:
                                    'เลขบัญชี: ${widget.order.business.paymentNumber}',
                              ),
                            ),
                            SizedBox(
                              width: width * 0.1,
                              child: IconButton(
                                onPressed: () {
                                  Clipboard.setData(
                                    ClipboardData(
                                      text: widget.order.business.paymentNumber,
                                    ),
                                  );
                                  showDialog(
                                    context: context,
                                    builder: (builder) => const DialogSuccess(
                                      message: 'คัดลอกเรียบร้อย',
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.copy,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 6),
                              child: TextCustom(
                                title: "สถานะสินค้า: $status",
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: TextCustom(title: "รายการสินค้า"),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: widget.order.product.length,
                          itemBuilder: (context, index) {
                            ProductCartModel product =
                                widget.order.product[index];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextCustom(
                                  title: "${index + 1} ${product.productName}",
                                ),
                                TextCustom(
                                    title: "จำนวน ${product.amount} ชิ้น")
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const Center(
                  child: TextCustom(title: "รูปภาพยืนยันการชำระเงิน"),
                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      width: width * 0.66,
                      height: height * 0.2,
                      decoration: BoxDecoration(
                        color: AppConstant.bgTextFormField,
                      ),
                      child: state.imagePayment.path.isNotEmpty
                          ? Image.file(
                              state.imagePayment,
                              fit: BoxFit.fill,
                            )
                          : Container(
                              width: width * 0.6,
                              alignment: Alignment.center,
                              child: ShowImageNetwork(
                                pathImage: widget.order.imagePayment.last,
                              ),
                            ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      width: width * 0.4,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () => dialogCamera(
                          context,
                          onSelectImagePayment,
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
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.add_a_photo_outlined,
                                color: AppConstant.colorText,
                                size: 15,
                              ),
                            ),
                            Text(
                              'เพิ่มรูปภาพการชำระเงิน',
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
                  ],
                ),
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, stateUser) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: ElevatedButton(
                            onPressed: state.imagePayment.path.isNotEmpty
                                ? () {
                                    widget.order.status =
                                        AppConstant.payedOrder;
                                    dialogConfirmBuyerChangeStatus(
                                      context,
                                      widget.order,
                                      stateUser.user.token,
                                      state.imagePayment,
                                      onChangeStatusOrder,
                                    );
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              primary: AppConstant.bgbutton,
                            ),
                            child: Row(
                              children: const [
                                TextCustom(
                                  title: "ยืนยันการชำระเงิน",
                                  fontColor: Colors.white,
                                ),
                                Icon(Icons.touch_app),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
