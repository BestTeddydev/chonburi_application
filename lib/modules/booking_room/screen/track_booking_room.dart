import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/booking_room/bloc/booking_room_bloc.dart';
import 'package:chonburi_mobileapp/modules/booking_room/models/booking_model.dart';
import 'package:chonburi_mobileapp/modules/booking_room/screen/booking_detail.dart';
import 'package:chonburi_mobileapp/modules/home/services/buyer_service.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackBookingRoom extends StatefulWidget {
  final String token;
  final String userId;
  const TrackBookingRoom({Key? key, required this.token, required this.userId})
      : super(key: key);

  @override
  State<TrackBookingRoom> createState() => _TrackBookingRoomState();
}

class _TrackBookingRoomState extends State<TrackBookingRoom> {
  @override
  void initState() {
    fetchBookings();
    super.initState();
  }

  fetchBookings() {
    context.read<BookingRoomBloc>().add(
          FetchMyBookingEvent(
            token: widget.token,
            typeQuery: 'userId',
            queryValue: widget.userId,
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
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(color: AppConstant.themeApp),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => const BuyerService(
                              token: '',
                            ),
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: AppConstant.colorText,
                        ),
                      ),
                      const TextCustom(
                        title: "รายการจองห้องพัก",
                        fontSize: 16,
                      )
                    ],
                  ),
                ),
                ListView.builder(
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
                        child: Column(
                          children: [
                            SizedBox(
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
                                        pathImage: booking.businessId.imageRef,
                                        boxFit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 16),
                                    width: width * 0.6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TextCustom(
                                          title:
                                              booking.businessId.businessName,
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
                                          title:
                                              "จำนวน ${booking.totalRoom} ห้อง",
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
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    width: 0.2,
                                    color: AppConstant.colorText,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // TextButton(
                                    //   onPressed: () => Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (builder) => ResortDetail(
                                    //         resort: booking.businessId.id,
                                    //       ),
                                    //     ),
                                    //   ),
                                    //   style: TextButton.styleFrom(
                                    //     backgroundColor: AppConstant.themeApp,
                                    //   ),
                                    //   child: const TextCustom(
                                    //     title: 'เยี่ยมชมร้านค้า >',
                                    //     fontWeight: FontWeight.bold,
                                    //   ),
                                    // ),
                                    TextButton(
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (builder) => BookingDetail(
                                            booking: booking,
                                            isSeller: false,
                                          ),
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        backgroundColor: AppConstant.themeApp,
                                      ),
                                      child: const TextCustom(
                                        title: 'รายละเอียก ',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
