import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/order_otop/bloc/order_otop_bloc.dart';
import 'package:chonburi_mobileapp/modules/otop/models/product_cart_model.dart';
import 'package:chonburi_mobileapp/modules/tracking_order_otop/models/order_otop_model.dart';
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
  @override
  void initState() {
    super.initState();
    setStatusOrder();
  }

  setStatusOrder() {
    context
        .read<OrderOtopBloc>()
        .add(SetInitOrderStatus(status: widget.order.status));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: AppConstant.backgroudApp,
      body: SafeArea(
        child: BlocBuilder<OrderOtopBloc, OrderOtopState>(
          builder: (context, state) {
            String status = AppConstant.translateStatus[state.orderStatus] ?? "";
            return ListView(
              shrinkWrap: true,
              children: [
                Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.person),
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
                            title: "ราคาทั้งหมด ${widget.order.totalPrice} บาท",
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.pin_drop_rounded),
                          TextCustom(
                            title: widget.order.contact.address,
                            maxLine: 3,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          TextCustom(title: "สถานะสินค้า: $status"),
                          ElevatedButton(
                            onPressed: () {},
                            child: Row(
                              children: const [
                                TextCustom(title: "ิอัพเดทสถานะ"),
                                Icon(Icons.touch_app),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const TextCustom(title: "รายการสินค้า"),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: widget.order.product.length,
                        itemBuilder: (context, index) {
                          ProductCartModel product =
                              widget.order.product[index];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextCustom(
                                title: "${index + 1} ${product.productName}",
                              ),
                              TextCustom(title: "จำนวน ${product.amount} ชิ้น")
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.4,
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
