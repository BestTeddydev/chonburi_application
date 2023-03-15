import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/order_package/models/order_package.dart';
import 'package:chonburi_mobileapp/modules/order_package/screen/components/card_order_package.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
            ListView(
              shrinkWrap: true,
              children: [
                CardOrderPackage(
                  width: width,
                  height: height,
                  order: widget.orderPackageModel,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  width: width * 0.9,
                  child: Column(
                    children: [
                      buildText(
                        width,
                        'ชื่อ:',
                        widget.orderPackageModel.contact.fullName,
                      ),
                      buildText(
                        width,
                        'ตั้งแต่วันที่:',
                        DateFormat('dd/MM/yyyy')
                            .format(widget.orderPackageModel.checkIn),
                      ),
                      buildText(
                        width,
                        'ถึงวันที่:',
                        DateFormat('dd/MM/yyyy')
                            .format(widget.orderPackageModel.checkOut),
                      ),
                      buildText(
                        width,
                        'จำนวนสมาชิก:',
                        widget.orderPackageModel.totalMember.toString(),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
                Container(
                  width: width * 0.7,
                  height: height * 0.4,
                  margin: const EdgeInsets.all(10),
                  child: ShowImageNetwork(
                    pathImage: widget.orderPackageModel.receiptImage,
                  ),
                )
              ],
            ),

            // SizedBox(
            //   width: width * 1,
            //   child: widget.orderPackageModel.status == AppConstant.payed ||
            //           widget.orderPackageModel.status ==
            //               AppConstant.acceptStatus
            //       ? null
            //       : ElevatedButton(
            //           // check order package of custom or normal package
            //           onPressed: () {
            //             if (widget.orderPackageModel.status !=
            //                 AppConstant.pay) {
            //               showDialog(
            //                 context: context,
            //                 builder: (builder) => DialogError(
            //                   message:
            //                       'ยังไม่สามารถชำระเงินได้ เนื่องจากอยู่ในสถานะ ${widget.orderPackageModel.status}',
            //                 ),
            //               );
            //               return;
            //             }
            //             Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                 builder: (builder) => PaymentPackage(
            //                   packageTourModel:
            //                       widget.orderPackageModel.package,
            //                   totalPrice: widget.orderPackageModel.totalPrice,
            //                   token: widget.token,
            //                   docId: widget.orderPackageModel.id,
            //                 ),
            //               ),
            //             );
            //           },
            //           style: ElevatedButton.styleFrom(
            //             primary: AppConstant.themeApp,
            //           ),
            //           child: Text(
            //             'ชำระเงิน',
            //             style: TextStyle(
            //               color: AppConstant.colorText,
            //               fontWeight: FontWeight.w600,
            //             ),
            //           ),
            //         ),
            // )
          ],
        ),
      ),
    );
  }

  Row buildText(double width, String typeText, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8.0, left: 8.0),
          width: width * 0.26,
          child: Text(
            typeText,
            style: TextStyle(color: AppConstant.colorText),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8.0, left: 8.0),
          width: width * 0.5,
          child: TextCustom(title: text),
        ),
      ],
    );
  }
}
