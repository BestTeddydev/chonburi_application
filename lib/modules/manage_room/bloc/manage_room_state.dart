part of 'manage_room_bloc.dart';

class ManageRoomState extends Equatable {
  final List<RoomModel> rooms;
  final File imageCoverRoom;
  final List<File> imagesDetail;
  final bool loading;
  final bool loaded;
  final bool hasError;
  final String message;
  ManageRoomState({
    required this.rooms,
    this.hasError = false,
    this.loaded = false,
    this.loading = false,
    this.message = '',
    File? imageCoverRoom,
    this.imagesDetail = const [],
  }) : imageCoverRoom = imageCoverRoom ?? File('');

  @override
  List<Object> get props => [
        rooms,
        loaded,
        loading,
        message,
        hasError,
        imageCoverRoom,
        imagesDetail,
      ];
}
