import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/modules/order_otop/bloc/order_otop_bloc.dart';
import 'package:chonburi_mobileapp/modules/otop/models/product_cart_model.dart';
import 'package:chonburi_mobileapp/modules/tracking_order_otop/models/order_otop_model.dart';
import 'package:chonburi_mobileapp/widget/dialog_order_otop.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrderDetail extends StatefulWidget {
  final OrderOtopModel order;
  const MyOrderDetail({Key? key, required this.order}) : super(key: key);

  @override
  State<MyOrderDetail> createState() => _MyOrderDetailState();
}

class _MyOrderDetailState extends State<MyOrderDetail> {
  List<DropdownMenuItem<String>> items = [
    AppConstant.approve,
    AppConstant.payPrePaid,
    AppConstant.reject,
    AppConstant.payedOrder,
  ].map<DropdownMenuItem<String>>((String value) {
    String? status = AppConstant.translateStatus[value];
    return DropdownMenuItem<String>(
      value: value,
      child: TextCustom(title: status!),
    );
  }).toList();

  @override
  void initState() {
    super.initState();
    setStatusOrder(widget.order.status);
  }

  setStatusOrder(String status) {
    context.read<OrderOtopBloc>().add(SetInitOrderStatusEvent(status: status));
  }

  onChangeStatusOrder(
      BuildContext context, OrderOtopModel order, String token) {
    context.read<OrderOtopBloc>().add(UpdateOrderOtopEvent(
          token: token,
          orderOtopModel: order,
        ));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: TextCustom(
          title: widget.order.contact.fullName,
          fontSize: 18,
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
      ),
      backgroundColor: AppConstant.backgroudApp,
      body: SafeArea(
        child: BlocBuilder<OrderOtopBloc, OrderOtopState>(
          builder: (context, state) {
            return ListView(
              shrinkWrap: true,
              children: [
                Card(
                  margin: const EdgeInsets.all(8),
                  child: Container(
                    margin: const EdgeInsets.all(8),
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
                                  "ราคาทั้งหมด ${widget.order.totalPrice} บาท",
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
                        BlocBuilder<UserBloc, UserState>(
                          builder: (context, stateUser) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: TextCustom(title: "สถานะสินค้า"),
                                    ),
                                    Container(
                                      width: width * .5,
                                      decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(color: Colors.white)
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          items: items,
                                          value: state.orderStatus,
                                          onChanged: (String? value) =>
                                              setStatusOrder(value!),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    widget.order.status = state.orderStatus;
                                    dialogConfirmChangeStatus(
                                      context,
                                      widget.order,
                                      stateUser.user.token,
                                      onChangeStatusOrder,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: AppConstant.bgbutton,
                                  ),
                                  child: Row(
                                    children: const [
                                      TextCustom(
                                        title: "อัพเดทสถานะ",
                                        fontColor: Colors.white,
                                      ),
                                      Icon(Icons.touch_app),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
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
                Container(
                  margin: const EdgeInsets.all(10),
                  height: height * 0.3,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.order.imagePayment.length,
                    itemBuilder: (context, index) => Container(
                      width: width * 0.6,
                      alignment: Alignment.center,
                      child: ShowImageNetwork(
                        pathImage: widget.order.imagePayment[index],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
