import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/models/place_model.dart';
import 'package:chonburi_mobileapp/utils/services/place_service.dart';
import 'package:chonburi_mobileapp/utils/services/upload_file_service.dart';
import 'package:equatable/equatable.dart';

part 'manage_businesses_event.dart';
part 'manage_businesses_state.dart';

class ManageBusinessesBloc
    extends Bloc<ManageBusinessesEvent, ManageBusinessesState> {
  ManageBusinessesBloc() : super(ManageBusinessesState()) {
    on<FetchsMyPlacesEvent>(_fetchsMyPlaces);
    on<CreatePlaceEvent>(_createPlace);
    on<UpdatePlaceEvent>(_updatePlace);
    on<DeletePlaceEvent>(_deletePlace);
    on<SelectImagePlaceEvent>(_selectImagePlace);
    on<RemoveImagePlaceEvent>(_removeImagePlace);
    on<ConvertImageUrlEvent>(_convertImageUrl);
    on<SetPlaceForUpdateEvent>(_setDataPlace);
  }
  void _fetchsMyPlaces(
      FetchsMyPlacesEvent event, Emitter<ManageBusinessesState> emitter) async {
    try {
      List<PlaceModel> places = await PlaceService.fetchsMyPlaces(event.token);
      emitter(
        ManageBusinessesState(places: places),
      );
    } catch (e) {
      log(e.toString());
      emitter(
        ManageBusinessesState(places: const []),
      );
    }
  }

  void _createPlace(
      CreatePlaceEvent event, Emitter<ManageBusinessesState> emitter) async {
    try {
      emitter(
        ManageBusinessesState(places: state.places, loading: true),
      );
      if (event.placeModel.imageList.isNotEmpty) {
        List<String> imageListUrl =
            await UploadService.multipleFile(event.placeModel.imageList);
        event.placeModel.imageList = imageListUrl;
      }
      PlaceModel place =
          await PlaceService.createPlace(event.token, event.placeModel);
      List<PlaceModel> allPlace = List.from(state.places)..add(place);
      emitter(
        ManageBusinessesState(
          places: allPlace,
          loaded: true,
          loading: false,
          message: 'สร้างข้อมูลสถานที่ท่องเที่ยวเรียบร้อยแล้ว',
        ),
      );
    } catch (e) {
      log(e.toString());
      emitter(
        ManageBusinessesState(
            places: state.places,
            hasError: true,
            loading: false,
            message: 'สร้างข้อมูลสถานที่ท่องเที่ยวล้มเหลว'),
      );
    }
  }

  void _updatePlace(
      UpdatePlaceEvent event, Emitter<ManageBusinessesState> emitter) async {
    try {
      emitter(
        ManageBusinessesState(
          places: state.places,
          loading: true,
          place: state.place,
        ),
      );
      if (event.placeModel.imageList.isNotEmpty) {
        List<String> imageListUrl =
            await UploadService.multipleFile(event.placeModel.imageList);
        event.placeModel.imageList = imageListUrl;
      }
      await PlaceService.updatePlace(event.token, event.placeModel);
      int index = List.from(state.places).indexWhere(
        (element) => element.id == event.placeModel.id,
      );
      List<PlaceModel> allPlace = List.from(state.places)
        ..removeWhere(
          (element) => element.id == event.placeModel.id,
        );
      allPlace.insert(index, event.placeModel);
      emitter(
        ManageBusinessesState(
            places: allPlace,
            loaded: true,
            loading: false,
            place: event.placeModel,
            imagePlaces: state.imagePlaces,
            message: 'แก้ไขข้อมูลสถานที่ท่องเที่ยวเรียบร้อย'),
      );
    } catch (e) {
      emitter(
        ManageBusinessesState(
            places: state.places,
            hasError: true,
            loading: false,
            place: state.place,
            message: 'แก้ไขข้อมูลสถานที่ท่องเที่ยวล้มเหลว'),
      );
    }
  }

  void _deletePlace(
      DeletePlaceEvent event, Emitter<ManageBusinessesState> emitter) async {
    try {
      emitter(
        ManageBusinessesState(places: state.places, loading: true),
      );

      await PlaceService.deletePlace(event.token, event.docId);
      List<PlaceModel> allPlace = List.from(state.places)
        ..removeWhere(
          (element) => element.id == event.docId,
        );
      emitter(
        ManageBusinessesState(
            places: allPlace,
            loaded: true,
            loading: false,
            message: 'ลบข้อมูลสถานที่ท่องเที่ยวเรียบร้อย'),
      );
    } catch (e) {
      emitter(
        ManageBusinessesState(
            places: state.places,
            hasError: true,
            loading: false,
            message: 'ลบข้อมูลสถานที่ท่องเที่ยวล้มเหลว'),
      );
    }
  }

  void _selectImagePlace(
      SelectImagePlaceEvent event, Emitter<ManageBusinessesState> emitter) {
    List<File> allImages = List.from(state.imagePlaces)..add(event.image);
    emitter(
      ManageBusinessesState(
        places: state.places,
        imagePlaces: allImages,
        place: state.place,
      ),
    );
  }

  void _removeImagePlace(
      RemoveImagePlaceEvent event, Emitter<ManageBusinessesState> emitter) {
    List<File> allImages = List.from(state.imagePlaces)
      ..removeAt(event.indexImage);
    emitter(
      ManageBusinessesState(
        places: state.places,
        imagePlaces: allImages,
        place: state.place,
      ),
    );
  }

  void _setDataPlace(
      SetPlaceForUpdateEvent event, Emitter<ManageBusinessesState> emitter) {
    emitter(
      ManageBusinessesState(
        places: state.places,
        imagePlaces: state.imagePlaces,
        place: event.place,
      ),
    );
  }

  void _convertImageUrl(
      ConvertImageUrlEvent event, Emitter<ManageBusinessesState> emitter) {
    emitter(
      ManageBusinessesState(
        places: state.places,
        imagePlaces: event.images,
        place: state.place,
      ),
    );
  }
}
