import 'dart:io';

import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/order_package/models/order_package.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';

dialogConfirmPayment(
  BuildContext context,
  OrderPackageModel order,
  String token,
  File image,
  onSubmit,
) {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      backgroundColor: AppConstant.bgAlert,
      title: ListTile(
        title: Icon(
          Icons.error,
          color: AppConstant.bgHastag,
        ),
        subtitle: const Center(
          child: TextCustom(
            title: 'คุณยืนยันที่การชำระเงินใช่หรือไม่',
          ),
        ),
      ),
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  onSubmit(context, order, token, image);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: AppConstant.bgHasTaged,
                  shadowColor: AppConstant.backgroudApp,
                ),
                child: const TextCustom(
                  title: 'ยืนยัน',
                  fontSize: 12,
                  fontColor: Colors.white,
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  primary: AppConstant.bgCancelActivity,
                  shadowColor: AppConstant.backgroudApp,
                ),
                child: const TextCustom(
                  title: 'ยกเลิก',
                  fontSize: 12,
                  fontColor: Colors.white,
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
