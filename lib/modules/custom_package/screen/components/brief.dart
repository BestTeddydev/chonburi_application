import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/custom_package/models/order_custom.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';

class BriefCustomPackage extends StatefulWidget {
  final OrderCustomModel orderPackageModel;
  const BriefCustomPackage({
    Key? key,
    required this.orderPackageModel,
  }) : super(key: key);

  @override
  State<BriefCustomPackage> createState() => _BriefCustomPackageState();
}

class _BriefCustomPackageState extends State<BriefCustomPackage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      color: AppConstant.themeApp,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'คำสั่งซื้อทั้งหมด ( ${widget.orderPackageModel.orderActivities.length} รายการ )',
                  style: TextStyle(
                    color: AppConstant.colorText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${widget.orderPackageModel.totalPrice} ฿',
                  style: TextStyle(
                    color: AppConstant.colorText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextCustom(title: 'ยอดรวมทั้งหมด'),
                TextCustom(
                    title:
                        '${(widget.orderPackageModel.totalPrice * widget.orderPackageModel.totalMember)} ฿')
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
