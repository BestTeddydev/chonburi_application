part of 'resort_bloc.dart';

abstract class ResortEvent extends Equatable {
  const ResortEvent();

  @override
  List<Object> get props => [];
}

class FetchsResortsEvent extends ResortEvent {
  final String search;
  final String typeBusiness;
  final bool statusSearch;
  const FetchsResortsEvent({
    required this.search,
    required this.typeBusiness,
    required this.statusSearch,
  });
}

class FetchsCategoryRoomEvent extends ResortEvent {
  final String businessId;
  const FetchsCategoryRoomEvent({
    required this.businessId,
  });
}

class FetchsRoomsEvent extends ResortEvent {
  final String businessId;
  const FetchsRoomsEvent({
    required this.businessId,
  });
}

class SelectPaymentImageEvent extends ResortEvent {
  final File image;
  const SelectPaymentImageEvent({
    required this.image,
  });
}

class FetchRoomsLeftEvent extends ResortEvent {
  final String businessId;
  final DateTime checkIn;
  final DateTime checkOut;
  const FetchRoomsLeftEvent({
    required this.businessId,
    required this.checkIn,
    required this.checkOut,
  });
}

class SelectCheckInDate extends ResortEvent {
  final DateTime date;
  const SelectCheckInDate({required this.date});
}

class SelectCheckOutDate extends ResortEvent {
  final DateTime date;
  const SelectCheckOutDate({required this.date});
}

class TotalMemberResortEvent extends ResortEvent {
  final int member;
  const TotalMemberResortEvent({
    required this.member,
  });
}

class TotalRoomResortEvent extends ResortEvent {
  final int room;
  const TotalRoomResortEvent({
    required this.room,
  });
}

class ChangeImageCoverRoom extends ResortEvent {
  final String imageURL;
  const ChangeImageCoverRoom({
    required this.imageURL,
  });
}
