part of 'manage_businesses_bloc.dart';

abstract class ManageBusinessesEvent extends Equatable {
  const ManageBusinessesEvent();

  @override
  List<Object> get props => [];
}

class FetchsMyPlacesEvent extends ManageBusinessesEvent {
  final String token;
  const FetchsMyPlacesEvent({
    required this.token,
  });
}

class CreatePlaceEvent extends ManageBusinessesEvent {
  final String token;
  final PlaceModel placeModel;
  const CreatePlaceEvent({
    required this.token,
    required this.placeModel,
  });
}

class UpdatePlaceEvent extends ManageBusinessesEvent {
  final String token;
  final PlaceModel placeModel;
  const UpdatePlaceEvent({
    required this.token,
    required this.placeModel,
  });
}

class DeletePlaceEvent extends ManageBusinessesEvent {
  final String token;
  final String docId;
  const DeletePlaceEvent({
    required this.token,
    required this.docId,
  });
}

class SelectImagePlaceEvent extends ManageBusinessesEvent {
  final File image;
  const SelectImagePlaceEvent({
    required this.image,
  });
}

class RemoveImagePlaceEvent extends ManageBusinessesEvent {
  final int indexImage;
  const RemoveImagePlaceEvent({
    required this.indexImage,
  });
}

class ConvertImageUrlEvent extends ManageBusinessesEvent {
  final List<File> images;
  const ConvertImageUrlEvent({
    required this.images,
  });
}

class SetPlaceForUpdateEvent extends ManageBusinessesEvent {
  final PlaceModel place;
  const SetPlaceForUpdateEvent({
    required this.place,
  });
}
