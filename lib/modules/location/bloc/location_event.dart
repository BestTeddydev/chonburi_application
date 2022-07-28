part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class InitLocationEvent extends LocationEvent {
  final double initLat;
  final double initLng;
  final double curLat;
  final double curLng;
  const InitLocationEvent({
    required this.initLat,
    required this.initLng,
    required this.curLat,
    required this.curLng,
  });
}

class MoveCameraEvent extends LocationEvent {
  final double curLat;
  final double curLng;
  const MoveCameraEvent({
    required this.curLat,
    required this.curLng,
  });
}
