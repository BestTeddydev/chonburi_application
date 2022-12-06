import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/home/services/buyer_service.dart';
import 'package:chonburi_mobileapp/modules/otop/screen/otop_detail.dart';
import 'package:chonburi_mobileapp/modules/tracking_order_otop/bloc/tracking_order_otop_bloc.dart';
import 'package:chonburi_mobileapp/modules/tracking_order_otop/models/order_otop_model.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackingOrderOtop extends StatefulWidget {
  final String userId;
  final String token;
  const TrackingOrderOtop({
    Key? key,
    required this.token,
    required this.userId,
  }) : super(key: key);

  @override
  State<TrackingOrderOtop> createState() => _TrackingOrderOtopState();
}

class _TrackingOrderOtopState extends State<TrackingOrderOtop> {
  @override
  void initState() {
    super.initState();
    fetchsOrdersOtop(widget.token, widget.userId);
  }

  void fetchsOrdersOtop(String token, String userId) {
    context
        .read<TrackingOrderOtopBloc>()
        .add(FetchOrdersOtopEvent(token: token, userId: userId));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppConstant.backgroudApp,
      body: BlocBuilder<TrackingOrderOtopBloc, TrackingOrderOtopState>(
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(color: AppConstant.themeApp),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => const BuyerService(
                              token: '',
                            ),
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: AppConstant.colorText,
                        ),
                      ),
                      const TextCustom(
                        title: "รายการสินค้าของฉัน",
                        fontSize: 16,
                      )
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.orders.length,
                  itemBuilder: (context, index) {
                    OrderOtopModel order = state.orders[index];
                    String status =
                        AppConstant.translateStatus[order.status] ?? "";

                    return SizedBox(
                      child: Card(
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            SizedBox(
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
                                        pathImage: order.business.imageRef,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 16),
                                    width: width * 0.6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TextCustom(
                                          title: order.business.businessName,
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
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (builder) => OtopDetail(
                                            businessId: order.business.id,
                                          ),
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        backgroundColor: AppConstant.themeApp,
                                      ),
                                      child: const TextCustom(
                                        title: 'เยี่ยมชมร้านค้า >',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
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
      ),
    );
  }
}
