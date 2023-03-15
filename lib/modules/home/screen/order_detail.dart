import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/custom_package/models/order_custom.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderCustomDetail extends StatefulWidget {
  final OrderCustomModel order;
  const OrderCustomDetail({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderCustomDetail> createState() => _OrderCustomDetailState();
}

class _OrderCustomDetailState extends State<OrderCustomDetail> {
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
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  width: width * 0.9,
                  child: Column(
                    children: [
                      buildText(
                        width,
                        'ชื่อ:',
                        widget.order.contact.fullName,
                      ),
                      buildText(
                        width,
                        'ตั้งแต่วันที่:',
                        DateFormat('dd/MM/yyyy').format(widget.order.checkIn),
                      ),
                      buildText(
                        width,
                        'ถึงวันที่:',
                        DateFormat('dd/MM/yyyy').format(widget.order.checkOut),
                      ),
                      buildText(
                        width,
                        'จำนวนสมาชิก:',
                        widget.order.totalMember.toString(),
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
                    pathImage: widget.order.receiptImage,
                  ),
                )
              ],
            ),
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
