part of 'manage_room_bloc.dart';

abstract class ManageRoomEvent extends Equatable {
  const ManageRoomEvent();

  @override
  List<Object> get props => [];
}
class FetchsRoomEvent extends ManageRoomEvent {
  final String businessId;
  const FetchsRoomEvent({
    required this.businessId,
  });
}

class CreateRoomEvent extends ManageRoomEvent {
  final String token;
  final RoomModel roomModel;
  const CreateRoomEvent({
    required this.token,
    required this.roomModel,
  });
}

class UpdateRoomEvent extends ManageRoomEvent {
  final String token;
  final RoomModel roomModel;
  const UpdateRoomEvent({
    required this.token,
    required this.roomModel,
  });
}

class DeleteRoomEvent extends ManageRoomEvent {
  final String token;
  final RoomModel roomModel;
  const DeleteRoomEvent({
    required this.token,
    required this.roomModel,
  });
}

class SelectImageRoomEvent extends ManageRoomEvent {
  final File imageRef;
  const SelectImageRoomEvent({
    required this.imageRef,
  });
}

class SelectImageDetailRoomEvent extends ManageRoomEvent {
  final File imageRef;
  const SelectImageDetailRoomEvent({
    required this.imageRef,
  });
}

class DeleteImageDetailRoomEvent extends ManageRoomEvent {
  final int index;
  const DeleteImageDetailRoomEvent({
    required this.index,
  });
}

class SetImageDetailRoomEvent extends ManageRoomEvent {
  final List<File> files;
  const SetImageDetailRoomEvent({
    required this.files,
  });
}
