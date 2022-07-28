// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/location/bloc/location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectMyLocation extends StatefulWidget {
  const SelectMyLocation({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectMyLocation> createState() => _SelectMyLocationState();
}

class _SelectMyLocationState extends State<SelectMyLocation> {
  final Completer<GoogleMapController> _controller = Completer();

  final MarkerId _currentMarker = const MarkerId('current_marker');
  Future<void> _goToCurrentPosition(double lat, lng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, lng),
      tilt: 59.440717697143555,
      zoom: 14.4746,
    )));
  }

  void onCameraMove(CameraPosition position) {
    context.read<LocationBloc>().add(
          MoveCameraEvent(
              curLat: position.target.latitude,
              curLng: position.target.longitude),
        );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        double lat = state.curLat;
        double lng = state.curLng;
        bool isSameLocation =
            state.curLat == state.initLat && state.curLng == state.initLng;
        return Scaffold(
          body: Stack(
            children: [
              GoogleMap(
                mapType: MapType.terrain,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    isSameLocation ? state.initLat : state.curLat,
                    isSameLocation ? state.initLng : state.curLng,
                  ),
                  zoom: 14.4746,
                ),
                onCameraMove: onCameraMove,
                circles: <Circle>{
                  Circle(
                    circleId: const CircleId('circle'),
                    center: LatLng(state.initLat, state.initLng),
                    fillColor: AppConstant.themeApp,
                    radius: 200,
                    strokeColor: AppConstant.bgTextFormField,
                    strokeWidth: 4,
                  )
                },
                markers: <Marker>{
                  Marker(
                    markerId: _currentMarker,
                    position: LatLng(lat, lng),
                    draggable: true,
                  ),
                },
              ),
              buildConfirmPosition(width, context)
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: AppConstant.themeApp,
            onPressed: () => _goToCurrentPosition(state.initLat, state.initLng),
            label: const Text('ตำแหน่งปัจจุบัน'),
            icon: const Icon(Icons.location_searching),
          ),
        );
      },
    );
  }

  Column buildConfirmPosition(double width, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 10,
            bottom: 16,
          ),
          width: width * 0.44,
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              primary: AppConstant.backgroudApp,
              shadowColor: Colors.black38,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              "ยืนยันตำแหน่ง",
              style: TextStyle(
                color: AppConstant.themeApp,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
