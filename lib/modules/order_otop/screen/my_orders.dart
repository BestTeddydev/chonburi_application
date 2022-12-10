import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/order_otop/bloc/order_otop_bloc.dart';
import 'package:chonburi_mobileapp/modules/order_otop/screen/my_order_detail.dart';
import 'package:chonburi_mobileapp/modules/tracking_order_otop/models/order_otop_model.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrdersOtop extends StatefulWidget {
  final String token, businessId;
  const MyOrdersOtop({
    Key? key,
    required this.token,
    required this.businessId,
  }) : super(key: key);

  @override
  State<MyOrdersOtop> createState() => _MyOrdersOtopState();
}

class _MyOrdersOtopState extends State<MyOrdersOtop> {
  @override
  void initState() {
    super.initState();
    fetchsOrdersOtop(widget.token, widget.businessId);
  }

  void fetchsOrdersOtop(String token, String businessId) {
    context
        .read<OrderOtopBloc>()
        .add(FetchMyOrdersOtopEvent(token: token, businessId: businessId));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppConstant.backgroudApp,
      body: BlocBuilder<OrderOtopBloc, OrderOtopState>(
        builder: (context, state) {
          return SafeArea(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                OrderOtopModel order = state.orders[index];
                String status = AppConstant.translateStatus[order.status] ?? "";
                return SizedBox(
                  child: Card(
                    margin: const EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => MyOrderDetail(order: order),
                        ),
                      ),
                      child: SizedBox(
                        height: height * 0.16,
                        child: Row(
                          children: [
                            Container(
                              width: width * 0.26,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: ShowImageNetwork(
                                  pathImage: order.imagePayment.last,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 16),
                              width: width * 0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextCustom(
                                    title:
                                        "${order.user.firstName} ${order.user.lastName}",
                                    maxLine: 2,
                                  ),
                                  TextCustom(
                                    title:
                                        "ราคาทั้งหมด ${order.totalPrice} บาท",
                                    fontSize: 12,
                                  ),
                                  TextCustom(
                                    title:
                                        "จ่ายล่วงหน้า ${order.prepaidPrice} บาท",
                                    fontSize: 12,
                                  ),
                                  TextCustom(
                                    title:
                                        "จำนวนสินค้า ${order.product.length} ชิ้น",
                                    fontSize: 12,
                                  ),
                                  TextCustom(
                                    title: "สถานะ: $status",
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
