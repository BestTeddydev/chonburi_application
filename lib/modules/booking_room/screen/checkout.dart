import 'dart:convert';
import 'dart:io';

import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/constants/asset_path.dart';
import 'package:chonburi_mobileapp/modules/auth/models/user_model.dart';
import 'package:chonburi_mobileapp/modules/booking_room/bloc/booking_room_bloc.dart';
import 'package:chonburi_mobileapp/modules/booking_room/models/booking_model.dart';
import 'package:chonburi_mobileapp/modules/booking_room/screen/track_booking_room.dart';
import 'package:chonburi_mobileapp/modules/businesses/models/business_models.dart';
import 'package:chonburi_mobileapp/modules/contact_info/models/contact_models.dart';
import 'package:chonburi_mobileapp/modules/manage_room/models/room_models.dart';
import 'package:chonburi_mobileapp/modules/resorts/bloc/resort_bloc.dart';
import 'package:chonburi_mobileapp/utils/services/qrcode_service.dart';
import 'package:chonburi_mobileapp/widget/dialog_camera.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/dialog_loading.dart';
import 'package:chonburi_mobileapp/widget/dialog_success.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CheckoutRoom extends StatefulWidget {
  final BusinessModel businessModel;
  final String businessName;
  final String accountNumber;
  final double totalPrice;
  final double prepaidPrice;
  final String qrcodeRef;
  final String typePayment;
  final UserModel user;
  final RoomModel roomId;
  final int totalRoom;
  final DateTime checkIn;
  final DateTime checkOut;
  final ContactModel contactId;
  const CheckoutRoom({
    Key? key,
    required this.businessModel,
    required this.accountNumber,
    required this.businessName,
    required this.prepaidPrice,
    required this.totalPrice,
    required this.qrcodeRef,
    required this.typePayment,
    required this.user,
    required this.roomId,
    required this.checkIn,
    required this.checkOut,
    required this.totalRoom,
    required this.contactId,
  }) : super(key: key);

  @override
  State<CheckoutRoom> createState() => _CheckoutRoomState();
}

class _CheckoutRoomState extends State<CheckoutRoom> {
  onSelectImagePayment(File selectImage) {
    context.read<ResortBloc>().add(SelectPaymentImageEvent(image: selectImage));
  }

  onSubmit(
    BuildContext context,
    File imagePayment,
    String token,
  ) {
    BookingModel bookingModel = BookingModel(
      userId: widget.user.userId,
      contactInfo: widget.contactId,
      totalPrice: widget.totalPrice,
      totalRoom: widget.totalRoom,
      prepaidPrice: widget.prepaidPrice,
      imagePayment: '',
      status: AppConstant.payPrePaid,
      roomId: widget.roomId,
      reviewed: false,
      checkIn: widget.checkIn,
      checkOut: widget.checkOut,
      businessId: widget.businessModel,
      id: '',
    );
    context.read<BookingRoomBloc>().add(
          CreateBookingEvent(
            bookingModel: bookingModel,
            imagePayment: imagePayment,
            token: token,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ชำระเงิน',
          style: TextStyle(color: AppConstant.colorText),
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(color: AppConstant.colorText),
      ),
      body: BlocListener<BookingRoomBloc, BookingRoomState>(
        listener: (context, trackingListener) {
          if (trackingListener.loading) {
            showDialog(
              context: context,
              builder: (builder) => const DialogLoading(),
            );
          }

          if (trackingListener.loaded) {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (builder) => TrackBookingRoom(
                      token: widget.user.token, userId: widget.user.userId),
                ),
                (route) => false);
            showDialog(
              context: context,
              builder: (builder) =>
                  DialogSuccess(message: trackingListener.message),
            );
          }
          if (trackingListener.hasError) {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (builder) => DialogError(
                message: trackingListener.message,
              ),
            );
          }
        },
        child: BlocBuilder<ResortBloc, ResortState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
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
                                  'ชื่อร้าน:',
                                  widget.businessName,
                                ),
                                buildText(
                                  width,
                                  'พร้อมเพย์/ธนาคาร:',
                                  widget.typePayment,
                                ),
                                buildText(
                                  width,
                                  'เช็คอิน:',
                                  DateFormat('dd:MM:yyyy')
                                      .format(widget.checkIn),
                                ),
                                buildText(
                                  width,
                                  'เช็คเอาท์:',
                                  DateFormat('dd:MM:yyyy')
                                      .format(widget.checkOut),
                                ),
                                buildPromptpay(width, widget.accountNumber),
                                buildText(
                                  width,
                                  'ราคาทั้งหมด:',
                                  '${widget.totalPrice}',
                                ),
                                buildText(
                                  width,
                                  'ราคาที่ต้องชำระ(ล่วงหน้า):',
                                  '${widget.prepaidPrice}',
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
                              widget.accountNumber,
                              widget.prepaidPrice,
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
                                widget.qrcodeRef,
                              );
                            }),
                        buildTextSlip(),
                        buildSelectImagePayment(
                          width,
                          height,
                          state.imagePayment,
                          context,
                        )
                      ],
                    ),
                  ),
                ),
                buildButton(
                  height,
                  state.imagePayment.path.isNotEmpty,
                  state.imagePayment,
                  widget.user.token,
                  context,
                ),
              ],
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
                          title: 'คุณยืนยันที่จะชำระเงินใช่หรือไม่',
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
                                onSubmit(context, image, token);
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
