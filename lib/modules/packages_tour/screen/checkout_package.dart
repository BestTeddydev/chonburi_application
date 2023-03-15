import 'dart:convert';
import 'dart:io';

import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/constants/asset_path.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/modules/contact_info/bloc/contact_bloc.dart';
import 'package:chonburi_mobileapp/modules/contact_info/models/contact_models.dart';
import 'package:chonburi_mobileapp/modules/contact_info/screen/contact_detail.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/package_tour_models.dart';
import 'package:chonburi_mobileapp/modules/order_package/models/order_package.dart';
import 'package:chonburi_mobileapp/modules/order_package/screen/packages_tracking.dart';
import 'package:chonburi_mobileapp/modules/packages_tour/bloc/package_bloc.dart';
import 'package:chonburi_mobileapp/utils/services/qrcode_service.dart';
import 'package:chonburi_mobileapp/widget/dialog_camera.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/dialog_loading.dart';
import 'package:chonburi_mobileapp/widget/dialog_order_package.dart';
import 'package:chonburi_mobileapp/widget/dialog_success.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPackage extends StatefulWidget {
  final String userId;
  final String userToken;
  const CheckoutPackage({
    Key? key,
    required this.userId,
    required this.userToken,
  }) : super(key: key);

  @override
  State<CheckoutPackage> createState() => _CheckoutPackageState();
}

class _CheckoutPackageState extends State<CheckoutPackage> {
  onSelectImagePayment(File selectImage) {
    context
        .read<PackageBloc>()
        .add(SelectImageSlipPaymentEvent(image: selectImage));
  }

  onSubmit(
    BuildContext context,
    OrderPackageModel order,
    String token,
    File image,
  ) {
    context.read<PackageBloc>().add(
          CheckoutPackageEvent(
            token: token,
            order: order,
            slipPayment: image,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const TextCustom(title: 'ชำระเงิน'),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
      ),
      body: BlocListener<PackageBloc, PackageState>(
        listener: (context, packageListener) {
          if (packageListener.loaded) {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (builder) => TrackingPackage(
                    token: widget.userToken,
                    userId: widget.userId,
                  ),
                ),
                (route) => false);
            showDialog(
              context: context,
              builder: (builder) =>
                  const DialogSuccess(message: 'ชำระเงินเรียบร้อย '),
            );
          }
          if (packageListener.isError) {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (builder) => const DialogError(
                message: 'เกิดเหตุขัดข้องขออภัยในความไม่สะดวก',
              ),
            );
          }
        },
        child: BlocBuilder<PackageBloc, PackageState>(
          builder: (context, state) {
            return SafeArea(
              child: ListView(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const ContactDetail(),
                          Container(
                            margin: const EdgeInsets.only(top: 15),
                            width: width * 0.9,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  buildText(
                                    width,
                                    'ชื่อแพ็คเกจ:',
                                    state.packagesTour.packageName,
                                  ),
                                  buildText(
                                    width,
                                    'ชื่อเจ้าของบัญชี:',
                                    state.packagesTour.contactAdmin.fullName,
                                  ),
                                  buildText(
                                    width,
                                    'พร้อมเพย์/ธนาคาร:',
                                    state.packagesTour.contactAdmin.typePayment,
                                  ),
                                  buildPromptpay(
                                      width,
                                      state.packagesTour.contactAdmin
                                          .accountPayment),
                                  buildText(
                                    width,
                                    'ราคาทั้งหมด:',
                                    '${state.totalMember * state.packagesTour.price}',
                                  ),
                                  buildText(
                                    width,
                                    'วันที่ชำระ:',
                                    DateTime.now().toString(),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
                          FutureBuilder(
                              future: GenerateQRCodeService.getQRCodeURL(
                                state.packagesTour.contactAdmin.accountPayment,
                                state.totalMember * state.packagesTour.price,
                              ),
                              builder: (
                                BuildContext context,
                                AsyncSnapshot<String> snapshot,
                              ) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const DialogLoading();
                                }
                                List<String> split = snapshot.data!.split(",");
                                return buildQrcode(
                                  width,
                                  height,
                                  split[1],
                                  state.packagesTour.contactAdmin.imagePayment,
                                );
                              }),
                          buildTextSlip(),
                          buildSelectImagePayment(
                            width,
                            height,
                            state.slipPayment,
                            context,
                          )
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder<ContactBloc, ContactState>(
                    builder: (context, stateContact) {
                      return BlocBuilder<UserBloc, UserState>(
                        builder: (context, stateUser) {
                          return buildButton(
                            height,
                            state.slipPayment.path.isNotEmpty,
                            state.packagesTour,
                            state.totalMember,
                            state.packagesTour.price * state.totalMember,
                            state.checkDate,
                            stateContact.myContact,
                            widget.userId,
                            state.slipPayment,
                            widget.userToken,
                            context,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Column buildSelectImagePayment(
      double width, double height, File imagePayment, BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 14),
          width: width * 0.66,
          height: height * 0.2,
          decoration: BoxDecoration(
            color: AppConstant.bgTextFormField,
          ),
          child: imagePayment.path.isNotEmpty
              ? Image.file(
                  imagePayment,
                  fit: BoxFit.fill,
                )
              : Center(
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: AppConstant.colorText,
                    size: 40,
                  ),
                ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          width: width * 0.4,
          height: 30,
          child: ElevatedButton(
            onPressed: () => dialogCamera(
              context,
              onSelectImagePayment,
            ),
            style: ElevatedButton.styleFrom(
              primary: AppConstant.bgTextFormField,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.add_a_photo_outlined,
                    color: AppConstant.colorText,
                    size: 15,
                  ),
                ),
                Text(
                  'เพิ่มรูปภาพการชำระเงิน',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppConstant.colorText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Row buildPromptpay(double width, String promptPay) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8.0, left: 8.0),
          width: width * 0.26,
          child: Text(
            'เลขบัญชี: ',
            style: TextStyle(color: AppConstant.colorText),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8.0, left: 8.0),
          width: width * 0.4,
          child: Text(promptPay),
        ),
        SizedBox(
          width: width * 0.1,
          child: IconButton(
            onPressed: () {
              Clipboard.setData(
                ClipboardData(text: promptPay),
              );
              showDialog(
                context: context,
                builder: (builder) =>
                    const DialogSuccess(message: 'คัดลอกเรียบร้อย'),
              );
            },
            icon: const Icon(
              Icons.copy,
            ),
          ),
        )
      ],
    );
  }

  Row buildTextSlip() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'หลักฐานการชำระเงิน',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppConstant.colorText,
            ),
          ),
        )
      ],
    );
  }

  Column buildQrcode(
      double width, double height, String promptPayQR, String qrcodeRef) {
    return Column(
      children: qrcodeRef.isNotEmpty
          ? [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'คิวอาร์โค้ดของทางร้าน',
                      style: TextStyle(
                        color: AppConstant.colorText,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width * 0.7,
                    height: height * 0.3,
                    child: ShowImageNetwork(
                      pathImage: qrcodeRef,
                    ),
                  ),
                ],
              ),
            ]
          : [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: width * 0.76,
                    height: height * 0.1,
                    child: Image.asset(
                      AppConstantAssets.promptPayImage,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width * 0.7,
                    height: height * 0.2,
                    child: Image.memory(base64Decode(promptPayQR)),
                  ),
                ],
              ),
            ],
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
          child: Text(text),
        ),
      ],
    );
  }

  SizedBox buildButton(
    double height,
    bool isPay,
    PackageTourModel packageTourModel,
    int totalMember,
    double totalPrice,
    DateTime checkIn,
    ContactModel contact,
    String userId,
    File image,
    String token,
    BuildContext context,
  ) {
    return SizedBox(
      width: double.maxFinite,
      height: height * 0.06,
      child: ElevatedButton(
        onPressed: isPay
            ? () {
                OrderPackageModel orderPackageModel = OrderPackageModel(
                  id: '',
                  package: packageTourModel,
                  status: AppConstant.payed,
                  totalMember: totalMember,
                  totalPrice: totalPrice,
                  checkIn: checkIn,
                  checkOut: packageTourModel.dayTrips == '1d'
                      ? checkIn
                      : DateTime(
                          checkIn.year,
                          checkIn.month,
                          checkIn.day + 1,
                        ),
                  contact: contact,
                  orderActivities: [], // not yet custom
                  userId: userId,
                  receiptImage: '',
                );
                dialogConfirmPayment(
                  context,
                  orderPackageModel,
                  token,
                  image,
                  onSubmit,
                );
              }
            : null,
        style: ElevatedButton.styleFrom(primary: AppConstant.themeApp),
        child: const TextCustom(
          title: 'ยืนยันการชำระเงิน',
          fontSize: 18,
        ),
      ),
    );
  }
}
