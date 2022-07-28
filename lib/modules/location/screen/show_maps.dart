// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/location/bloc/location_bloc.dart';
import 'package:chonburi_mobileapp/modules/location/screen/select_my_location.dart';
import 'package:chonburi_mobileapp/utils/helper/geolocator.dart';
import 'package:chonburi_mobileapp/widget/alert_service.dart';
import 'package:chonburi_mobileapp/widget/dialog_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class ShowMap extends StatefulWidget {
  final double? lat, lng;
  const ShowMap({
    Key? key,
    this.lat,
    this.lng,
  }) : super(key: key);

  @override
  State<ShowMap> createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    checkPermission();
    super.initState();
  }

  void checkPermission() async {
    try {
      if (widget.lat != null && widget.lng != null) {
        context.read<LocationBloc>().add(
              InitLocationEvent(
                initLat: widget.lat!,
                initLng: widget.lng!,
                curLat: widget.lat!,
                curLng: widget.lng!,
              ),
            );
        return;
      }
      Position position = await determinePosition();

      context.read<LocationBloc>().add(
            InitLocationEvent(
              initLat: position.latitude,
              initLng: position.longitude,
              curLat: position.latitude,
              curLng: position.longitude,
            ),
          );
    } catch (e) {
      PermissionStatus locationStatus = await Permission.location.status;
      if (locationStatus.isPermanentlyDenied || locationStatus.isDenied) {
        alertService(
          context,
          'ไม่อนุญาติแชร์ Location',
          'โปรดแชร์ Location',
        );
      }
    }
  }

  Future<void> centerScreen(double lat, lng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          tilt: 59.440717697143555,
          zoom: 14.4746,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocListener<LocationBloc, LocationState>(
      listenWhen: (previous, current) =>
          previous.curLat != current.curLat &&
          previous.curLng != current.curLng,
      listener: (context, stateListener) {
        centerScreen(stateListener.curLat, stateListener.curLng);
      },
      child: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          return state.fetched
              ? Column(
                  children: [
                    SizedBox(
                      width: width * 0.8,
                      height: height * 0.2,
                      child: GoogleMap(
                        zoomGesturesEnabled: true,
                        myLocationEnabled: true,
                        mapType: MapType.terrain,
                        onMapCreated: (GoogleMapController controller) async {
                          _controller.complete(controller);
                        },
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            state.curLat,
                            state.curLng,
                          ),
                          zoom: 18,
                        ),
                        markers: <Marker>{
                          Marker(
                            markerId: const MarkerId("position"),
                            position: LatLng(
                              state.curLat,
                              state.curLng,
                            ),
                          ),
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => const SelectMyLocation(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: AppConstant.bgTextFormField,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'เลือกตำแหน่ง',
                        style: TextStyle(
                          color: AppConstant.colorText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                )
              : const DialogLoading();
        },
      ),
    );
  }
}
