import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/booking_room/bloc/booking_room_bloc.dart';
import 'package:chonburi_mobileapp/modules/booking_room/models/booking_model.dart';
import 'package:chonburi_mobileapp/modules/booking_room/screen/booking_detail.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBookingRoom extends StatefulWidget {
  final String token;
  final String businessId;
  const MyBookingRoom({
    Key? key,
    required this.businessId,
    required this.token,
  }) : super(key: key);

  @override
  State<MyBookingRoom> createState() => _MyBookingRoomState();
}

class _MyBookingRoomState extends State<MyBookingRoom> {
  @override
  void initState() {
    fetchBookings();
    super.initState();
  }

  fetchBookings() {
    context.read<BookingRoomBloc>().add(
          FetchMyBookingEvent(
            token: widget.token,
            typeQuery: 'businessId',
            queryValue: widget.businessId,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppConstant.backgroudApp,
      body: BlocBuilder<BookingRoomBloc, BookingRoomState>(
        builder: (context, state) {
          return SafeArea(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: state.bookings.length,
              itemBuilder: (context, index) {
                BookingModel booking = state.bookings[index];
                String status =
                    AppConstant.translateStatus[booking.status] ?? "";
                return SizedBox(
                  child: Card(
                    margin: const EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => BookingDetail(
                            booking: booking,
                            isSeller: true,
                          ),
                        ),
                      ),
                      child: SizedBox(
                        height: height * 0.16,
                        child: Row(
                          children: [
                            Container(
                              width: width * 0.26,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: ShowImageNetwork(
                                  pathImage: booking.imagePayment,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 16),
                              width: width * 0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextCustom(
                                    title: "${booking.contactInfo.fullName} ",
                                    maxLine: 2,
                                  ),
                                  TextCustom(
                                    title:
                                        "ราคาทั้งหมด ${booking.totalPrice} บาท",
                                    fontSize: 12,
                                  ),
                                  TextCustom(
                                    title:
                                        "จ่ายล่วงหน้า ${booking.prepaidPrice} บาท",
                                    fontSize: 12,
                                  ),
                                  TextCustom(
                                    title: "จำนวน ${booking.totalRoom} ห้อง",
                                    fontSize: 12,
                                  ),
                                  TextCustom(
                                    title: "สถานะ: $status",
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
