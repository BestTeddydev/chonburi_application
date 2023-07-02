part of 'resort_bloc.dart';

class ResortState extends Equatable {
  final List<BusinessModel> resorts;
  final List<CategoryModel> categories;
  final List<RoomModel> rooms;
  final List<RoomLeftModel> roomsLeft;
  final bool loading;
  final bool loaded;
  final bool hasError;
  final String message;
  final bool isSearched;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int totalMember;
  final int totalRoom;
  final String imageCoverRoom;
  final File imagePayment;
  ResortState({
    this.resorts = const [],
    this.roomsLeft = const [],
    this.categories = const [],
    this.rooms = const [],
    this.hasError = false,
    this.loaded = false,
    this.loading = false,
    this.message = '',
    this.isSearched = false,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    this.imageCoverRoom = '',
    this.totalMember = 0,
    this.totalRoom = 0,
    File? imagePayment,
  })  : checkInDate = checkInDate ?? DateTime.now(),
        checkOutDate = checkOutDate ?? DateTime.now(),
        imagePayment = imagePayment ?? File('');

  @override
  List<Object> get props => [
        resorts,
        categories,
        rooms,
        isSearched,
        loaded,
        loading,
        hasError,
        message,
        checkInDate,
        checkOutDate,
        totalMember,
        imageCoverRoom,
        totalRoom,
        roomsLeft,
        imagePayment,
      ];
}
