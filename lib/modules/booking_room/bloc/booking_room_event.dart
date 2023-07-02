part of 'booking_room_bloc.dart';

abstract class BookingRoomEvent extends Equatable {
  const BookingRoomEvent();

  @override
  List<Object> get props => [];
}

class UpdateBookingEvent extends BookingRoomEvent {
  final BookingModel bookingModel;
  final String token;
  const UpdateBookingEvent({
    required this.bookingModel,
    required this.token,
  });
}

class CreateBookingEvent extends BookingRoomEvent {
  final BookingModel bookingModel;
  final String token;
  final File imagePayment;
  const CreateBookingEvent({
    required this.bookingModel,
    required this.token,
    required this.imagePayment,
  });
}

class FetchMyBookingEvent extends BookingRoomEvent {
  final String token;
  final String typeQuery;
  final String queryValue;
  const FetchMyBookingEvent({
    required this.token,
    required this.typeQuery,
    required this.queryValue,
  });
}

class SetInitBookingStatusEvent extends BookingRoomEvent {
  final String status;
  const SetInitBookingStatusEvent({
    required this.status,
  });
}
