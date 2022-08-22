import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_room/models/room_models.dart';
import 'package:chonburi_mobileapp/utils/services/room_service.dart';
import 'package:chonburi_mobileapp/utils/services/upload_file_service.dart';
import 'package:equatable/equatable.dart';

part 'manage_room_event.dart';
part 'manage_room_state.dart';

class ManageRoomBloc extends Bloc<ManageRoomEvent, ManageRoomState> {
  ManageRoomBloc() : super(ManageRoomState(rooms: const [])) {
    on<FetchsRoomEvent>(_fetchRooms);
    on<CreateRoomEvent>(_createRoom);
    on<UpdateRoomEvent>(_editRoom);
    on<DeleteRoomEvent>(_deleteRoom);
    on<SelectImageRoomEvent>(_selectImageRoom);
    on<SelectImageDetailRoomEvent>(_selectImageDetailRoom);
    on<DeleteImageDetailRoomEvent>(_deleteImageDetailRoom);
    on<SetImageDetailRoomEvent>(_setImageDetailRoom);
  }
  void _fetchRooms(
      FetchsRoomEvent event, Emitter<ManageRoomState> emitter) async {
    try {
      List<RoomModel> rooms = await RoomService.fetchsRoom(event.businessId);
      emitter(ManageRoomState(rooms: rooms));
    } catch (e) {
      emitter(
        ManageRoomState(rooms: state.rooms, hasError: true),
      );
    }
  }

  void _createRoom(
      CreateRoomEvent event, Emitter<ManageRoomState> emitter) async {
    try {
      emitter(
        ManageRoomState(
          rooms: state.rooms,
          loading: true,
          imageCoverRoom: state.imageCoverRoom,
          imagesDetail: state.imagesDetail,
        ),
      );
      if (state.imageCoverRoom.path.isNotEmpty) {
        String imageRef =
            await UploadService.singleFile(state.imageCoverRoom.path);
        event.roomModel.imageCover = imageRef;
      }
      if (state.imagesDetail.isNotEmpty) {
        List<String> files = [];
        for (int i = 0; i < state.imagesDetail.length; i++) {
          files.add(state.imagesDetail[i].path);
        }
        List<String> imageDetailURL = await UploadService.multipleFile(files);
        event.roomModel.listImageDetail = imageDetailURL;
      }
      RoomModel room =
          await RoomService.createRoom(event.token, event.roomModel);

      emitter(
        ManageRoomState(
          rooms: List.from(state.rooms)..add(room),
          loaded: true,
          message: 'บันทึกข้อมูลห้องพักเรียบร้อย',
          loading: false,
        ),
      );
    } catch (e) {
      emitter(
        ManageRoomState(
          rooms: state.rooms,
          hasError: true,
          message: 'บันทึกข้อมูลห้องพักล้มเหลว',
        ),
      );
    }
  }

  void _editRoom(
      UpdateRoomEvent event, Emitter<ManageRoomState> emitter) async {
    try {
      emitter(
        ManageRoomState(
          rooms: state.rooms,
          imageCoverRoom: state.imageCoverRoom,
          imagesDetail: state.imagesDetail,
          loading: true,
        ),
      );
      if (state.imageCoverRoom.path.isNotEmpty) {
        String imageRef =
            await UploadService.singleFile(state.imageCoverRoom.path);
        event.roomModel.imageCover = imageRef;
      }
      if (state.imagesDetail.isNotEmpty) {
        List<String> files = [];
        for (int i = 0; i < state.imagesDetail.length; i++) {
          files.add(state.imagesDetail[i].path);
        }
        List<String> imageDetailURL = await UploadService.multipleFile(files);
        event.roomModel.listImageDetail = imageDetailURL;
      }
      await RoomService.editRoom(event.token, event.roomModel);
      int index = List<RoomModel>.from(state.rooms).indexWhere(
        (element) => element.id == event.roomModel.id,
      );
      List<RoomModel> allProducts = List<RoomModel>.from(state.rooms)
        ..removeWhere(
          (element) => element.id == event.roomModel.id,
        );
      allProducts.insert(index, event.roomModel);
      emitter(
        ManageRoomState(
          rooms: allProducts,
          imageCoverRoom: state.imageCoverRoom,
          imagesDetail: state.imagesDetail,
          loaded: true,
          message: 'แก้ไขข้อมูลห้องพักเรียบร้อย',
          loading: false,
        ),
      );
    } catch (e) {
      emitter(
        ManageRoomState(
          rooms: state.rooms,
          hasError: true,
          message: 'แก้ไขข้อมูลห้องพักล้มเหลว',
          loading: false,
        ),
      );
    }
  }

  void _deleteRoom(
      DeleteRoomEvent event, Emitter<ManageRoomState> emitter) async {
    try {
      await RoomService.deleteRoom(event.token, event.roomModel.id);
      emitter(
        ManageRoomState(
          rooms: List.from(state.rooms)
            ..removeWhere(
              (element) => element.id == event.roomModel.id,
            ),
          loaded: true,
          message: 'ลบข้อมูลห้องพักเรียบร้อย',
        ),
      );
    } catch (e) {
      emitter(
        ManageRoomState(
          rooms: state.rooms,
          hasError: true,
          message: 'ลบข้อมูลห้องพักล้มเหลว',
        ),
      );
    }
  }

  void _selectImageRoom(
    SelectImageRoomEvent event,
    Emitter<ManageRoomState> emitter,
  ) {
    emitter(
      ManageRoomState(
        rooms: state.rooms,
        imageCoverRoom: event.imageRef,
        imagesDetail: state.imagesDetail,
      ),
    );
  }

  void _selectImageDetailRoom(
    SelectImageDetailRoomEvent event,
    Emitter<ManageRoomState> emitter,
  ) {
    emitter(
      ManageRoomState(
        rooms: state.rooms,
        imageCoverRoom: state.imageCoverRoom,
        imagesDetail: List.from(state.imagesDetail)..add(event.imageRef),
      ),
    );
  }

  void _deleteImageDetailRoom(
    DeleteImageDetailRoomEvent event,
    Emitter<ManageRoomState> emitter,
  ) {
    emitter(
      ManageRoomState(
        rooms: state.rooms,
        imageCoverRoom: state.imageCoverRoom,
        imagesDetail: List.from(state.imagesDetail)..removeAt(event.index),
      ),
    );
  }

  void _setImageDetailRoom(
    SetImageDetailRoomEvent event,
    Emitter<ManageRoomState> emitter,
  ) {
    emitter(
      ManageRoomState(
        rooms: state.rooms,
        imageCoverRoom: state.imageCoverRoom,
        imagesDetail: event.files,
      ),
    );
  }
}
