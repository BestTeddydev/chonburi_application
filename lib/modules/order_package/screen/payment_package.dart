import 'dart:io';

import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/custom_package/models/order_custom.dart';
import 'package:chonburi_mobileapp/modules/order_package/bloc/order_package_bloc.dart';
import 'package:chonburi_mobileapp/modules/order_package/models/order_activity.dart';
import 'package:chonburi_mobileapp/widget/dialog_camera.dart';
import 'package:chonburi_mobileapp/widget/dialog_comfirm.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/dialog_loading.dart';
import 'package:chonburi_mobileapp/widget/dialog_success.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentPackage extends StatefulWidget {
  final OrderCustomModel orderCustomPackage;
  final double totalPrice;
  final String token;
  final String docId;
  const PaymentPackage({
    Key? key,
    required this.orderCustomPackage,
    required this.totalPrice,
    required this.docId,
    required this.token,
  }) : super(key: key);

  @override
  State<PaymentPackage> createState() => _PaymentPackageState();
}

class _PaymentPackageState extends State<PaymentPackage> {
  onSetImageReciept(File image) {
    context.read<OrderPackageBloc>().add(SelectImageReceiptEvent(image: image));
  }

  onSubmitPayment(BuildContext context) {
    context.read<OrderPackageBloc>().add(
          BillOrderPackageEvent(
            token: widget.token,
            status: AppConstant.payed,
            docId: widget.docId,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.themeApp,
        title: Text(
          'ชำระเงิน',
          style: TextStyle(
            color: AppConstant.colorText,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: IconThemeData(color: AppConstant.colorText),
      ),
      backgroundColor: AppConstant.backgroudApp,
      body: BlocListener<OrderPackageBloc, OrderPackageState>(
        listener: (context, state) {
          if (state.loading) {
            showDialog(
              context: context,
              builder: (builder) => const DialogLoading(),
            );
          }
          if (state.loaded) {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (builder) => DialogSuccess(message: state.message),
            );
          }
          if (state.hasError) {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (builder) => DialogError(message: state.message),
            );
          }
        },
        child: BlocBuilder<OrderPackageBloc, OrderPackageState>(
          builder: (context, state) {
            OrderActivityModel orderActivity =
                widget.orderCustomPackage.orderActivities.first;
            return SingleChildScrollView(
              child: Container(
                width: width * 0.9,
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextCustom(
                            title: 'ยอดที่ต้องชำระ',
                            fontColor: AppConstant.bgChooseActivity,
                            fontWeight: FontWeight.w600,
                          ),
                          TextCustom(
                            title:
                                '${widget.totalPrice * orderActivity.totalPerson} ฿',
                            fontColor: AppConstant.bgChooseActivity,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 6,
                      ),
                      child: TextCustom(
                        title:
                            widget.orderCustomPackage.contactAdmin.typePayment,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextCustom(
                            title: widget
                                .orderCustomPackage.contactAdmin.accountPayment,
                          ),
                          IconButton(
                            onPressed: () {
                              Clipboard.setData(
                                ClipboardData(
                                  text: widget.orderCustomPackage.contactAdmin
                                      .accountPayment,
                                ),
                              );
                              showDialog(
                                context: context,
                                builder: (builder) => const DialogSuccess(
                                    message: 'คัดลอกเรียบร้อย'),
                              );
                            },
                            icon: Icon(
                              Icons.copy,
                              color: AppConstant.colorText,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: width * 0.5,
                        height: height * 0.2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ShowImageNetwork(
                            pathImage: widget
                                .orderCustomPackage.contactAdmin.imagePayment,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(
                          bottom: 14,
                          top: 14,
                        ),
                        width: width * 0.5,
                        height: height * 0.2,
                        decoration: BoxDecoration(
                          color: AppConstant.bgTextFormField,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: state.reciepImage.path.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  state.reciepImage,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : Center(
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: AppConstant.colorText,
                                  size: 40,
                                ),
                              ),
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          dialogCamera(context, onSetImageReciept);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppConstant.bgTextFormField,
                        ),
                        child: const TextCustom(
                          title: 'เลือกรูปภาพ',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 1,
                      child: ElevatedButton(
                        onPressed: () {
                          if (state.reciepImage.path.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (builder) => const DialogError(
                                  message: 'กรุณาแนบรูปภาพยืนยันการชำระเงิน'),
                            );
                            return;
                          }
                          dialogConfirm(
                            context,
                            onSubmitPayment,
                            'คุณยืนยันที่จะชำระเงินใช่หรือไม่',
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppConstant.bgTextFormField,
                        ),
                        child: const TextCustom(
                          title: 'ยืนยันการชำระเงิน',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
