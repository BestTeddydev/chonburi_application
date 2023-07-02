import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/modules/booking_room/bloc/booking_room_bloc.dart';
import 'package:chonburi_mobileapp/modules/booking_room/models/booking_model.dart';
import 'package:chonburi_mobileapp/widget/dialog_booking.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingDetail extends StatefulWidget {
  final BookingModel booking;
  final bool isSeller;
  const BookingDetail({
    Key? key,
    required this.booking,
    required this.isSeller,
  }) : super(key: key);

  @override
  State<BookingDetail> createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
  List<DropdownMenuItem<String>> items = [
    AppConstant.approve,
    AppConstant.payPrePaid,
    AppConstant.reject,
    AppConstant.payedOrder,
  ].map<DropdownMenuItem<String>>((String value) {
    String? status = AppConstant.translateStatus[value];
    return DropdownMenuItem<String>(
      value: value,
      child: TextCustom(title: status!),
    );
  }).toList();

  @override
  void initState() {
    super.initState();
    setStatusbooking(widget.booking.status);
  }

  setStatusbooking(String status) {
    context
        .read<BookingRoomBloc>()
        .add(SetInitBookingStatusEvent(status: status));
  }

  onChangeStatusbooking(
      BuildContext context, BookingModel bookingModel, String token) {
    context.read<BookingRoomBloc>().add(UpdateBookingEvent(
          token: token,
          bookingModel: bookingModel,
        ));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: TextCustom(
          title: widget.booking.contactInfo.fullName,
          fontSize: 18,
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
      ),
      backgroundColor: AppConstant.backgroudApp,
      body: SafeArea(
        child: BlocBuilder<BookingRoomBloc, BookingRoomState>(
          builder: (context, state) {
            return ListView(
              shrinkWrap: true,
              children: [
                Card(
                  margin: const EdgeInsets.all(8),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.person_outline_outlined),
                            TextCustom(
                              title: widget.isSeller
                                  ? widget.booking.contactInfo.fullName
                                  : widget.booking.businessId.businessName,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.monetization_on_outlined),
                            TextCustom(
                              title:
                                  "จ่ายล่วงหน้า ${widget.booking.prepaidPrice} บาท",
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.monetization_on_outlined),
                            TextCustom(
                              title:
                                  "ราคาทั้งหมด ${widget.booking.totalPrice} บาท",
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.pin_drop_outlined),
                            TextCustom(
                              title: widget.booking.contactInfo.address,
                              maxLine: 3,
                            )
                          ],
                        ),
                        BlocBuilder<UserBloc, UserState>(
                          builder: (context, stateUser) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: TextCustom(title: "สถานะการจอว"),
                                    ),
                                    Container(
                                      width: width * .5,
                                      decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(color: Colors.white)
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          items: items,
                                          value: state.orderStatus,
                                          onChanged: (String? value) =>
                                              setStatusbooking(value!),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  child: widget.isSeller
                                      ? ElevatedButton(
                                          onPressed: () {
                                            widget.booking.status =
                                                state.orderStatus;
                                            dialogConfirmChangeStatusBooking(
                                              context,
                                              widget.booking,
                                              stateUser.user.token,
                                              onChangeStatusbooking,
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: AppConstant.bgbutton,
                                          ),
                                          child: Row(
                                            children: const [
                                              TextCustom(
                                                title: "อัพเดทสถานะ",
                                                fontColor: Colors.white,
                                              ),
                                              Icon(Icons.touch_app),
                                            ],
                                          ),
                                        )
                                      : null,
                                ),
                              ],
                            );
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: TextCustom(title: "รายการ"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextCustom(
                              title: " ${widget.booking.roomId.roomName}",
                            ),
                            TextCustom(
                                title: "จำนวน ${widget.booking.totalRoom} ห้อง")
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Center(
                  child: TextCustom(title: "รูปภาพยืนยันการชำระเงิน"),
                ),
                Container(
                    margin: const EdgeInsets.all(10),
                    height: height * 0.3,
                    child: ShowImageNetwork(
                      pathImage: widget.booking.imagePayment,
                    )
                    //  ListView.builder(
                    //   shrinkWrap: true,
                    //   physics: const BouncingScrollPhysics(),
                    //   scrollDirection: Axis.horizontal,
                    //   itemCount: widget.booking.imagePayment.length,
                    //   itemBuilder: (context, index) => Container(
                    //     width: width * 0.6,
                    //     alignment: Alignment.center,
                    //     child: ShowImageNetwork(
                    //       pathImage: widget.booking.imagePayment[index],
                    //     ),
                    //   ),
                    // ),
                    ),
              ],
            );
          },
        ),
      ),
    );
  }
}
