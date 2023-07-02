import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chonburi_mobileapp/modules/businesses/models/business_models.dart';
import 'package:chonburi_mobileapp/modules/category/models/category_model.dart';
import 'package:chonburi_mobileapp/modules/manage_room/models/room_left_models.dart';
import 'package:chonburi_mobileapp/modules/manage_room/models/room_models.dart';
import 'package:chonburi_mobileapp/utils/services/business_service.dart';
import 'package:chonburi_mobileapp/utils/services/category_service.dart';
import 'package:chonburi_mobileapp/utils/services/room_service.dart';
import 'package:equatable/equatable.dart';

part 'resort_event.dart';
part 'resort_state.dart';

class ResortBloc extends Bloc<ResortEvent, ResortState> {
  ResortBloc() : super(ResortState()) {
    on<FetchsResortsEvent>(_fetchsResorts);
    on<FetchsCategoryRoomEvent>(_fetchsCategories);
    on<FetchsRoomsEvent>(_fetchsRooms);
    on<SelectCheckInDate>(_selectCheckInDate);
    on<SelectCheckOutDate>(_selectCheckOutDate);
    on<TotalMemberResortEvent>(_selectMember);
    on<ChangeImageCoverRoom>(_changeImageCoverRoom);
    on<TotalRoomResortEvent>(_selectTotalRoom);
    on<FetchRoomsLeftEvent>(_fetchRoomsLeft);
    on<SelectPaymentImageEvent>(_selectImagePayment);
  }
  void _fetchsResorts(
    FetchsResortsEvent event,
    Emitter<ResortState> emitter,
  ) async {
    try {
      emitter(ResortState(
        resorts: state.resorts,
        loading: true,
        checkInDate: state.checkInDate,
        checkOutDate: state.checkOutDate,
        totalMember: state.totalMember,
      ));
      List<BusinessModel> resorts =
          await BusinessService.fetchBusiness(event.search, event.typeBusiness);
      emitter(
        ResortState(
          resorts: resorts,
          loading: false,
          loaded: true,
          isSearched: event.statusSearch,
          categories: state.categories,
          rooms: state.rooms,
          checkInDate: state.checkInDate,
          checkOutDate: state.checkOutDate,
          totalMember: state.totalMember,
          imageCoverRoom: state.imageCoverRoom,
          totalRoom: state.totalRoom,
        ),
      );
    } catch (e) {
      emitter(
        ResortState(
          resorts: state.resorts,
          hasError: true,
          message: 'เกิดเหตุขัดข้อง ขออภัยในความไม่สะดวก',
          categories: state.categories,
          rooms: state.rooms,
          checkInDate: state.checkInDate,
          checkOutDate: state.checkOutDate,
          totalMember: state.totalMember,
          imageCoverRoom: state.imageCoverRoom,
          totalRoom: state.totalRoom,
        ),
      );
    }
  }

  void _fetchsCategories(
    FetchsCategoryRoomEvent event,
    Emitter<ResortState> emitter,
  ) async {
    try {
      List<CategoryModel> categories =
          await CategoryService.fetchCategoryBusiness(event.businessId);
      emitter(
        ResortState(
          resorts: state.resorts,
          categories: categories,
          rooms: state.rooms,
          checkInDate: state.checkInDate,
          checkOutDate: state.checkOutDate,
          totalMember: state.totalMember,
          imageCoverRoom: state.imageCoverRoom,
          totalRoom: state.totalRoom,
          roomsLeft: state.roomsLeft,
        ),
      );
    } catch (e) {
      emitter(
        ResortState(
          resorts: state.resorts,
          hasError: true,
          message: 'เกิดเหตุขัดข้อง ขออภัยในความไม่สะดวก',
          rooms: state.rooms,
          checkInDate: state.checkInDate,
          checkOutDate: state.checkOutDate,
          totalMember: state.totalMember,
          imageCoverRoom: state.imageCoverRoom,
          totalRoom: state.totalRoom,
        ),
      );
    }
  }

  void _fetchsRooms(
    FetchsRoomsEvent event,
    Emitter<ResortState> emitter,
  ) async {
    try {
      List<RoomModel> rooms = await RoomService.fetchsRoom(event.businessId);
      emitter(
        ResortState(
          resorts: state.resorts,
          categories: state.categories,
          rooms: rooms,
          checkInDate: state.checkInDate,
          checkOutDate: state.checkOutDate,
          totalMember: state.totalMember,
          imageCoverRoom: state.imageCoverRoom,
          totalRoom: state.totalRoom,
          roomsLeft: state.roomsLeft,
        ),
      );
    } catch (e) {
      emitter(
        ResortState(
          resorts: state.resorts,
          hasError: true,
          message: 'เกิดเหตุขัดข้อง ขออภัยในความไม่สะดวก',
          categories: state.categories,
          checkInDate: state.checkInDate,
          checkOutDate: state.checkOutDate,
          totalMember: state.totalMember,
          imageCoverRoom: state.imageCoverRoom,
          totalRoom: state.totalRoom,
        ),
      );
    }
  }

  void _fetchRoomsLeft(
    FetchRoomsLeftEvent event,
    Emitter<ResortState> emitter,
  ) async {
    try {
      List<RoomLeftModel> roomsLeft = await RoomService.fetchsRoomLeft(
          event.businessId, event.checkIn, event.checkOut);
      emitter(
        ResortState(
          resorts: state.resorts,
          categories: state.categories,
          rooms: state.rooms,
          checkInDate: state.checkInDate,
          checkOutDate: state.checkOutDate,
          totalMember: state.totalMember,
          imageCoverRoom: state.imageCoverRoom,
          totalRoom: state.totalRoom,
          roomsLeft: roomsLeft,
        ),
      );
    } catch (e) {
      emitter(
        ResortState(
          resorts: state.resorts,
          hasError: true,
          message: 'เกิดเหตุขัดข้อง ขออภัยในความไม่สะดวก',
          categories: state.categories,
          checkInDate: state.checkInDate,
          checkOutDate: state.checkOutDate,
          totalMember: state.totalMember,
          imageCoverRoom: state.imageCoverRoom,
          totalRoom: state.totalRoom,
        ),
      );
    }
  }

  void _selectCheckInDate(
      SelectCheckInDate event, Emitter<ResortState> emitter) {
    emitter(
      ResortState(
        resorts: state.resorts,
        checkInDate: event.date,
        rooms: state.rooms,
        totalMember: state.totalMember,
        checkOutDate: state.checkOutDate,
        categories: state.categories,
        imageCoverRoom: state.imageCoverRoom,
        totalRoom: state.totalRoom,
        roomsLeft: state.roomsLeft,
      ),
    );
  }

  void _selectCheckOutDate(
      SelectCheckOutDate event, Emitter<ResortState> emitter) {
    // event คือตัวที่รับค่าใหม่มา
    // state คือตัวที่เก็บค่าเก่าไว้
    emitter(
      ResortState(
        resorts: state.resorts,
        checkInDate: state.checkInDate,
        rooms: state.rooms,
        totalMember: state.totalMember,
        checkOutDate: event.date,
        categories: state.categories,
        imageCoverRoom: state.imageCoverRoom,
        totalRoom: state.totalRoom,
        roomsLeft: state.roomsLeft,
      ),
    );
  }

  void _selectMember(
      TotalMemberResortEvent event, Emitter<ResortState> emitter) {
    emitter(
      ResortState(
        resorts: state.resorts,
        checkInDate: state.checkInDate,
        rooms: state.rooms,
        totalMember: event.member,
        checkOutDate: state.checkOutDate,
        categories: state.categories,
        imageCoverRoom: state.imageCoverRoom,
        totalRoom: state.totalRoom,
      ),
    );
  }

  void _selectTotalRoom(
      TotalRoomResortEvent event, Emitter<ResortState> emitter) {
    emitter(
      ResortState(
        resorts: state.resorts,
        checkInDate: state.checkInDate,
        rooms: state.rooms,
        totalMember: state.totalMember,
        checkOutDate: state.checkOutDate,
        categories: state.categories,
        imageCoverRoom: state.imageCoverRoom,
        totalRoom: event.room,
        roomsLeft: state.roomsLeft,
        imagePayment: state.imagePayment,
      ),
    );
  }

  void _changeImageCoverRoom(
      ChangeImageCoverRoom event, Emitter<ResortState> emitter) {
    emitter(
      ResortState(
        resorts: state.resorts,
        checkInDate: state.checkInDate,
        rooms: state.rooms,
        totalMember: state.totalMember,
        checkOutDate: state.checkOutDate,
        categories: state.categories,
        imageCoverRoom: event.imageURL,
        totalRoom: state.totalRoom,
        roomsLeft: state.roomsLeft,
        imagePayment: state.imagePayment,
      ),
    );
  }

  void _selectImagePayment(
    SelectPaymentImageEvent event,
    Emitter<ResortState> emitter,
  ) {
    emitter(
      ResortState(
        resorts: state.resorts,
        checkInDate: state.checkInDate,
        rooms: state.rooms,
        totalMember: state.totalMember,
        checkOutDate: state.checkOutDate,
        categories: state.categories,
        imageCoverRoom: state.imageCoverRoom,
        totalRoom: state.totalRoom,
        roomsLeft: state.roomsLeft,
        imagePayment: event.image,
      ),
    );
  }
}
