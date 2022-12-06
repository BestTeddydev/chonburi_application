import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/businesses/models/business_models.dart';
import 'package:chonburi_mobileapp/widget/maps_launcher.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RestaurantAbout extends StatelessWidget {
  final BusinessModel restaurant;
  const RestaurantAbout({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: TextCustom(
          title: restaurant.businessName,
          fontSize: 18,
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
        toolbarHeight: 80,
      ),
      backgroundColor: AppConstant.backgroudApp,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: width * 1,
              height: height * 0.24,
              child: GoogleMap(
                zoomGesturesEnabled: true,
                myLocationEnabled: false,
                mapType: MapType.terrain,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    restaurant.latitude,
                    restaurant.longitude,
                  ),
                  zoom: 18,
                ),
                markers: <Marker>{
                  Marker(
                    markerId: const MarkerId("position"),
                    position: LatLng(
                      restaurant.latitude,
                      restaurant.longitude,
                    ),
                  ),
                },
              ),
            ),
            Card(
              margin: const EdgeInsets.only(top: 14),
              color: AppConstant.bgTextFormField,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppConstant.bgbutton,
                        ),
                        SizedBox(
                          width: width * 0.7,
                          child: TextCustom(
                            title: restaurant.address,
                            maxLine: 3,
                          ),
                        ),
                      ],
                    ),
                    UrlLauncherMap(
                      lat: restaurant.latitude,
                      lng: restaurant.longitude,
                      businessName: restaurant.businessName,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.contact_phone, color: AppConstant.bgbutton),
                ),
                TextCustom(title: restaurant.phoneNumber),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
