import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/custom_package/bloc/custom_package_bloc.dart';
import 'package:chonburi_mobileapp/modules/custom_package/models/order_custom.dart';
import 'package:chonburi_mobileapp/modules/home/screen/order_detail.dart';
import 'package:chonburi_mobileapp/modules/home/services/buyer_service.dart';
import 'package:chonburi_mobileapp/modules/order_package/screen/payment_package.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TrackingCustom extends StatefulWidget {
  final String token;
  final String userId;
  const TrackingCustom({
    Key? key,
    required this.token,
    required this.userId,
  }) : super(key: key);

  @override
  State<TrackingCustom> createState() => _TrackingCustomState();
}

class _TrackingCustomState extends State<TrackingCustom> {
  @override
  void initState() {
    context.read<CustomPackageBloc>().add(FetchsOrderCustomEvent(
          token: widget.token,
          id: widget.userId,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<CustomPackageBloc, CustomPackageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const TextCustom(title: 'สถานะคัสตอมแพ็คเกจของฉัน'),
            backgroundColor: AppConstant.themeApp,
            iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
            actions: [
              IconButton(
                onPressed: () => {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => BuyerService(
                        token: widget.token,
                      ),
                    ),
                    (route) => false,
                  )
                },
                icon: const Icon(Icons.home),
              )
            ],
          ),
          backgroundColor: AppConstant.backgroudApp,
          body: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.orders.length,
                  itemBuilder: (itemBuilder, index) {
                    OrderCustomModel order = state.orders[index];
                    int totalPerson = order.orderActivities.first.totalPerson;
                    return InkWell(
                      onTap: () {
                        if (order.receiptImage.isEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => PaymentPackage(
                                orderCustomPackage: order,
                                token: widget.token,
                                docId: order.id,
                                totalPrice: order.totalPrice,
                              ),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => OrderCustomDetail(
                                order: order,
                              ),
                            ),
                          );
                        }
                      },
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: AppConstant.bgOrderCard,
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                left: 20,
                                bottom: 25,
                              ),
                              width: width * 0.8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      bottom: 8,
                                    ),
                                    child: Text(
                                      'ราคา : ${order.totalPrice * totalPerson} ฿',
                                      style: TextStyle(
                                        color: AppConstant.colorText,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        order.status,
                                        style: TextStyle(
                                          color: AppConstant
                                              .statusColor[order.status],
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextCustom(
                                              title: DateFormat('dd/MM/yyyy')
                                                  .format(order.checkIn),
                                              fontSize: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
          ),
        );
      },
    );
  }
}
