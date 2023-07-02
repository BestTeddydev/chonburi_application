import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chonburi_mobileapp/modules/booking_room/models/booking_model.dart';
import 'package:chonburi_mobileapp/utils/services/booking_service.dart';
import 'package:chonburi_mobileapp/utils/services/upload_file_service.dart';
import 'package:equatable/equatable.dart';

part 'booking_room_event.dart';
part 'booking_room_state.dart';

class BookingRoomBloc extends Bloc<BookingRoomEvent, BookingRoomState> {
  BookingRoomBloc() : super(const BookingRoomState(bookings: [])) {
    on<UpdateBookingEvent>(updateBooking);
    on<FetchMyBookingEvent>(fetchsBooking);
    on<SetInitBookingStatusEvent>(setInitBookingStatus);
    on<CreateBookingEvent>(createBooking);
  }

  void createBooking(
    CreateBookingEvent event,
    Emitter<BookingRoomState> emitter,
  ) async {
    try {
      emitter(BookingRoomState(
        bookings: state.bookings,
        loading: true,
      ));
      if (event.imagePayment.path.isNotEmpty) {
        String imageUrl =
            await UploadService.singleFile(event.imagePayment.path);
        event.bookingModel.imagePayment = imageUrl;
      }
      await BookingService.createBooking(
        event.token,
        event.bookingModel,
      );
      emitter(
        BookingRoomState(
          bookings: state.bookings,
          orderStatus: event.bookingModel.status,
          loaded: true,
          loading: false,
          message: "จองที่พักเรียบร้อย",
        ),
      );
    } catch (e) {
      emitter(BookingRoomState(
        bookings: state.bookings,
        hasError: true,
        loading: false,
        message: "จองที่พักล้มเหลว",
      ));
    }
  }

  void updateBooking(
    UpdateBookingEvent event,
    Emitter<BookingRoomState> emitter,
  ) async {
    try {
      emitter(BookingRoomState(bookings: state.bookings, loading: true));

      await BookingService.editBooking(
        '/booking/${event.bookingModel.id}',
        event.token,
        event.bookingModel,
      );
      emitter(
        BookingRoomState(
          bookings: state.bookings,
          orderStatus: event.bookingModel.status,
          loaded: true,
          loading: false,
          message: "อัพเดทสถานะเรียบร้อย",
        ),
      );
    } catch (e) {
      emitter(BookingRoomState(
        bookings: state.bookings,
        hasError: true,
        loading: false,
        message: "อัพเดทสถานะล้มเหลว",
      ));
    }
  }

  void fetchsBooking(
    FetchMyBookingEvent event,
    Emitter<BookingRoomState> emitter,
  ) async {
    try {
      List<BookingModel> bookings = await BookingService.fetchsBooking(
          event.queryValue, event.token, event.typeQuery);
      emitter(
        BookingRoomState(
          bookings: bookings,
        ),
      );
    } catch (e) {
      print(e);
      emitter(
        BookingRoomState(
          bookings: state.bookings,
          hasError: true,
          message: "เกิดเหตุขัดข้อง ขออภัยในความไม่สะดวก",
        ),
      );
    }
  }

  void setInitBookingStatus(
      SetInitBookingStatusEvent event, Emitter<BookingRoomState> emitter) {
    emitter(
      BookingRoomState(
        bookings: state.bookings,
        orderStatus: event.status,
      ),
    );
  }
}
