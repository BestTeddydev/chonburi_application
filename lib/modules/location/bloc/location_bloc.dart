import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(const LocationState()) {
    on<InitLocationEvent>(initLocation);
    on<MoveCameraEvent>(_moveCamera);
  }

  initLocation(InitLocationEvent event, Emitter<LocationState> emitter) {
    emitter(
      LocationState(
        initLat: event.initLat,
        initLng: event.initLng,
        curLat: event.curLat,
        curLng: event.curLng,
        fetched: true,
      ),
    );
  }

  void _moveCamera(MoveCameraEvent event, Emitter<LocationState> emitter) {
    emitter(LocationState(
      initLat: state.initLat,
      initLng: state.initLng,
      curLat: event.curLat,
      curLng: event.curLng,
      fetched: true,
    ));
  }
}
