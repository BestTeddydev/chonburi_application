import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/order_package/models/order_activity.dart';
import 'package:chonburi_mobileapp/modules/order_package/models/order_package.dart';
import 'package:chonburi_mobileapp/modules/order_package/screen/components/card_order_package.dart';
import 'package:chonburi_mobileapp/modules/order_package/screen/payment_package.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:flutter/material.dart';

class OrderDetailBuyer extends StatefulWidget {
  final OrderPackageModel orderPackageModel;
  final String token;
  const OrderDetailBuyer({
    Key? key,
    required this.orderPackageModel,
    required this.token,
  }) : super(key: key);

  @override
  State<OrderDetailBuyer> createState() => _OrderDetailBuyerState();
}

class _OrderDetailBuyerState extends State<OrderDetailBuyer> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'สถานะ',
          style: TextStyle(
            color: AppConstant.colorTextHeader,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(
          color: AppConstant.colorTextHeader,
        ),
      ),
      backgroundColor: AppConstant.backgroudApp,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.826,
              child: ListView(
                children: [
                  CardOrderPackage(
                    width: width,
                    height: height,
                    order: widget.orderPackageModel,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: widget.orderPackageModel.orderActivities.length,
                    itemBuilder: (itemBuilder, index) {
                      OrderActivityModel orderActivityModel =
                          widget.orderPackageModel.orderActivities[index];
                      return Card(
                        margin: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          left: 30,
                          right: 30,
                        ),
                        color: AppConstant.bgOrderCard,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 15,
                            bottom: 15,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: width * 0.6,
                                child: Text(
                                  orderActivityModel.activityName,
                                  softWrap: true,
                                  style: TextStyle(
                                    color: AppConstant.colorText,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Text(
                                '${orderActivityModel.status} ',
                                style: TextStyle(
                                  color: AppConstant
                                      .statusColor[orderActivityModel.status],
                                  fontWeight: FontWeight.w600,
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
            SizedBox(
              width: width * 1,
              child: ElevatedButton(
                onPressed: () {
                  if (widget.orderPackageModel.status != AppConstant.pay) {
                    showDialog(
                      context: context,
                      builder: (builder) => DialogError(
                        message:
                            'ยังไม่สามารถชำระเงินได้ เนื่องจากอยู่ในสถานะ ${widget.orderPackageModel.status}',
                      ),
                    );
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => PaymentPackage(
                        packageTourModel: widget.orderPackageModel.package,
                        totalPrice: widget.orderPackageModel.totalPrice,
                        token: widget.token,
                        docId: widget.orderPackageModel.id,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: AppConstant.themeApp,
                ),
                child: Text(
                  'ชำระเงิน',
                  style: TextStyle(
                    color: AppConstant.colorText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
