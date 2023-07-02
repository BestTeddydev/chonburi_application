part of 'booking_room_bloc.dart';

class BookingRoomState extends Equatable {
  final List<BookingModel> bookings;
  final String orderStatus;
  final bool loading;
  final bool loaded;
  final bool hasError;
  final String message;
  const BookingRoomState({
    required this.bookings,
    this.loading = false,
    this.hasError = false,
    this.loaded = false,
    this.message = '',
    this.orderStatus = "PAY_PREPAID",
  });

  @override
  List<Object> get props =>
      [bookings, loaded, loading, hasError, message, orderStatus];
}
