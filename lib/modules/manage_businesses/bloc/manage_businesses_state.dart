part of 'manage_businesses_bloc.dart';

class ManageBusinessesState extends Equatable {
  final List<PlaceModel> places;
  final List<File> imagePlaces;
  final PlaceModel place;
  final bool loading;
  final bool loaded;
  final bool hasError;
  final String message;
  ManageBusinessesState({
    this.places = const <PlaceModel>[],
    this.imagePlaces = const <File>[],
    this.loaded = false,
    this.loading = false,
    this.hasError = false,
    PlaceModel? place,
    this.message = '',
  }) : place = place ??
            PlaceModel(
              id: '',
              placeName: '',
              address: '',
              description: '',
              imageList: [],
              videoRef: '',
              ratingCount: 0,
              point: 0,
              lat: 0,
              lng: 0,
              ownerId: '',
              price: 0,
            );

  @override
  List<Object> get props =>
      [places, loading, loaded, hasError, imagePlaces, place, message];
}
