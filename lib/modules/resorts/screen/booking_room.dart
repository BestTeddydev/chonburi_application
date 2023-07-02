import 'dart:developer';

import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/models/user_model.dart';
import 'package:chonburi_mobileapp/modules/booking_room/screen/checkout.dart';
import 'package:chonburi_mobileapp/modules/businesses/models/business_models.dart';
import 'package:chonburi_mobileapp/modules/contact_info/bloc/contact_bloc.dart';
import 'package:chonburi_mobileapp/modules/contact_info/screen/contact_detail.dart';
import 'package:chonburi_mobileapp/modules/manage_room/models/room_models.dart';
import 'package:chonburi_mobileapp/modules/resorts/bloc/resort_bloc.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingRoom extends StatefulWidget {
  final RoomModel room;
  final BusinessModel resort;
  final UserModel user;
  const BookingRoom({
    Key? key,
    required this.room,
    required this.resort,
    required this.user,
  }) : super(key: key);

  @override
  State<BookingRoom> createState() => _BookingRoomState();
}

class _BookingRoomState extends State<BookingRoom> {
  @override
  void initState() {
    super.initState();
    changeImageCover(widget.room.imageCover);
  }

  void changeImageCover(String url) {
    context.read<ResortBloc>().add(ChangeImageCoverRoom(imageURL: url));
  }

  double calTotalPrice(
      double roomPrice, int totalRoom, DateTime checkIn, DateTime checkout) {
    int dateRage = checkout.difference(checkIn).inDays + 1;
    log(dateRage.toString());
    return roomPrice * totalRoom * dateRage;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppConstant.backgroudApp,
      body: BlocBuilder<ResortBloc, ResortState>(
        builder: (context, state) {
          List<String> intregateImage = [
            widget.room.imageCover,
            ...widget.room.listImageDetail
          ];
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: width * 1,
                      height: height * 0.25,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white54,
                            blurRadius: 5,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ShowImageNetwork(
                        pathImage: state.imageCoverRoom,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: AppConstant.backgroudApp,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back,
                          color: AppConstant.colorTextHeader,
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: TextCustom(title: "Preview "),
                ),
                Container(
                  height: height * 0.12,
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: intregateImage.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => changeImageCover(intregateImage[index]),
                          child: Container(
                            width: width * 0.3,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: state.imageCoverRoom ==
                                        intregateImage[index]
                                    ? 4
                                    : 0,
                                color: Colors.white,
                              ),
                            ),
                            margin: const EdgeInsets.all(4),
                            child: ShowImageNetwork(
                                pathImage: intregateImage[index]),
                          ),
                        );
                      }),
                ),
                Container(
                  margin: const EdgeInsets.all(4),
                  child: TextCustom(title: 'ราคา :  ${widget.room.price} ฿'),
                ),
                Container(
                  margin: const EdgeInsets.all(4),
                  child: TextCustom(
                      title:
                          'เข้าพักได้สูงสุด : ผู้ใหญ่ ${widget.room.totalGuest} คน'),
                ),
                Container(
                  margin: const EdgeInsets.all(4),
                  child: TextCustom(title: widget.room.descriptionRoom),
                ),
                Center(
                  child: Container(
                    width: width * 0.5,
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppConstant.bgTextFormField,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'จำนวนห้อง',
                          style: TextStyle(
                            color: AppConstant.colorText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.add_circle,
                              color: AppConstant.colorTextHeader,
                            ),
                            onPressed: () {
                              int roomLeft = state.roomsLeft
                                  .where(
                                      (element) => element.id == widget.room.id)
                                  .first
                                  .roomLeft;
                              if (roomLeft <= state.totalRoom) {
                                showDialog(
                                  context: context,
                                  builder: (builder) => const DialogError(
                                    message:
                                        'ห้องเต็มแล้ว ขออภัยในความไม่สะดวก',
                                  ),
                                );
                                return;
                              }
                              context.read<ResortBloc>().add(
                                    TotalRoomResortEvent(
                                      room: state.totalRoom + 1,
                                    ),
                                  );
                            },
                          ),
                        ),
                        Text(
                          state.totalRoom.toString(),
                          style: TextStyle(
                            color: AppConstant.colorText,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.remove_circle,
                              color: AppConstant.colorTextHeader,
                            ),
                            onPressed: state.totalRoom > 0
                                ? () {
                                    context.read<ResortBloc>().add(
                                          TotalRoomResortEvent(
                                            room: state.totalRoom - 1,
                                          ),
                                        );
                                  }
                                : null,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                BlocBuilder<ContactBloc, ContactState>(
                  builder: (context, stateContact) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextCustom(title: 'ข้อมูลติดต่อ'),
                        const ContactDetail(),
                        Container(
                          width: double.maxFinite,
                          margin: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            onPressed: () {
                              if (state.totalRoom <= 0) {
                                showDialog(
                                    context: context,
                                    builder: (builder) => const DialogError(
                                        message: 'กรุณาเลือกจำนวนห้องพัก'));
                                return;
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => CheckoutRoom(
                                    businessModel: widget.resort,
                                    accountNumber: widget.resort.paymentNumber,
                                    businessName: widget.resort.businessName,
                                    prepaidPrice: calTotalPrice(
                                          widget.room.price,
                                          state.totalRoom,
                                          state.checkInDate,
                                          state.checkOutDate,
                                        ) /
                                        2,
                                    totalPrice: calTotalPrice(
                                      widget.room.price,
                                      state.totalRoom,
                                      state.checkInDate,
                                      state.checkOutDate,
                                    ),
                                    qrcodeRef: widget.resort.qrcodeRef,
                                    typePayment: widget.resort.typePayment,
                                    user: widget.user,
                                    roomId: widget.room,
                                    checkIn: state.checkInDate,
                                    checkOut: state.checkOutDate,
                                    totalRoom: state.totalRoom,
                                    contactId: stateContact.myContact,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: AppConstant.themeApp,
                            ),
                            child: const TextCustom(title: 'จองห้องพัก'),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
