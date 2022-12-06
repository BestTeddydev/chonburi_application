import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

class UrlLauncherMap extends StatelessWidget {
  double lat, lng;
  String businessName;
  UrlLauncherMap(
      {Key? key,
      required this.lat,
      required this.lng,
      required this.businessName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        MapsLauncher.launchCoordinates(lat, lng, businessName);
      },
      child: Row(
        children: [
          Icon(
            Icons.directions,
            color: AppConstant.colorText,
          ),
        ],
      ),
    );
  }
}
