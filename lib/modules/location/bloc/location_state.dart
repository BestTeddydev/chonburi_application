part of 'location_bloc.dart';

class LocationState extends Equatable {
  final double initLat;
  final double initLng;
  final double curLat;
  final double curLng;
  final bool fetched;
  const LocationState({
    this.curLat = 0,
    this.curLng = 0,
    this.initLat = 0,
    this.initLng = 0,
    this.fetched = false,
  });
  
  @override
  List<Object> get props => [initLat,initLng,curLat,curLng];
}

