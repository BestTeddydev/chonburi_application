import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/order_package/models/order_package.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardOrderPackage extends StatelessWidget {
  const CardOrderPackage({
    Key? key,
    required this.width,
    required this.height,
    required this.order,
  }) : super(key: key);

  final double width;
  final double height;
  final OrderPackageModel order;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: AppConstant.bgOrderCard,
      child: Row(
        children: [
          Container(
            width: width * 0.46,
            height: height * 0.18,
            decoration: const BoxDecoration(),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              child: ShowImageNetwork(
                pathImage: order.package.packageImage,
                boxFit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 20,
              bottom: 25,
            ),
            width: width * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.package.packageName,
                  style: TextStyle(
                    color: AppConstant.colorTextHeader,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: Text(
                    'ราคา : ${order.totalPrice} ฿',
                    style: TextStyle(
                      color: AppConstant.colorText,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                Text(
                  order.status,
                  style: TextStyle(
                    color: AppConstant.statusColor[order.status],
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextCustom(
                        title: DateFormat('dd/MM/yyyy').format(order.checkIn),
                        fontSize: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
