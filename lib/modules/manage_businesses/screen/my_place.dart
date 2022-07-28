import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/bloc/manage_businesses_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/models/place_model.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/screen/home_place.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyPlace extends StatefulWidget {
  final String token;
  const MyPlace({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<MyPlace> createState() => _MyPlaceState();
}

class _MyPlaceState extends State<MyPlace> {
  @override
  void initState() {
    context.read<ManageBusinessesBloc>().add(
          FetchsMyPlacesEvent(token: widget.token),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.backgroudApp,
      body: BlocBuilder<ManageBusinessesBloc, ManageBusinessesState>(
        builder: (context, state) {
          List<PlaceModel> places = state.places;
          return places.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      TextCustom(
                        title: 'ไม่มีข้อมูล',
                        fontSize: 16,
                      )
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: places.length,
                    itemBuilder: (itemBuilder, index) {
                      return InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => HomePlace(
                              placeModel: places[index],
                            ),
                          ),
                        ),
                        child: Card(
                          margin: const EdgeInsets.only(top: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              top: 12,
                              bottom: 12,
                              right: 16,
                            ),
                            child: Text(
                              places[index].placeName,
                              style: TextStyle(
                                color: AppConstant.colorText,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
