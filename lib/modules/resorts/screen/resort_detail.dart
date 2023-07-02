import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/businesses/models/business_models.dart';
import 'package:chonburi_mobileapp/modules/resorts/bloc/resort_bloc.dart';
import 'package:chonburi_mobileapp/modules/resorts/screen/components/list_room.dart';
import 'package:chonburi_mobileapp/modules/restaurant/screen/restaurant_about.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResortDetail extends StatefulWidget {
  final BusinessModel resort;
  final DateTime checkIn;
  final DateTime checkOut;
  const ResortDetail({
    Key? key,
    required this.resort,
    required this.checkIn,
    required this.checkOut,
  }) : super(key: key);

  @override
  State<ResortDetail> createState() => _ResortDetailState();
}

class _ResortDetailState extends State<ResortDetail> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() {
    // context
    //     .read<ResortBloc>()
    //     .add(FetchsCategoryRoomEvent(businessId: widget.resort.id));
    context
        .read<ResortBloc>()
        .add(FetchsRoomsEvent(businessId: widget.resort.id));
    context.read<ResortBloc>().add(
          FetchRoomsLeftEvent(
            businessId: widget.resort.id,
            checkIn: widget.checkIn,
            checkOut: widget.checkOut,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppConstant.backgroudApp,
      body: BlocBuilder<ResortBloc, ResortState>(
        builder: (context, state) {
          return ListView(
            children: [
              Stack(
                children: [
                  Container(
                    width: width * 1,
                    height: height * 0.25,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white54,
                          blurRadius: 5,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ShowImageNetwork(
                      pathImage: widget.resort.imageRef,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: AppConstant.backgroudApp,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppConstant.colorTextHeader,
                      ),
                    ),
                  ),
                ],
              ),
              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      width: width * 0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextCustom(
                            title: widget.resort.businessName,
                            maxLine: 2,
                            fontSize: 16,
                          ),
                          TextCustom(
                            title: 'ที่อยู่ ${widget.resort.address}',
                            maxLine: 3,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width * 0.2,
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => RestaurantAbout(
                                restaurant: widget.resort,
                              ),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.info,
                          color: AppConstant.colorText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListRooms(
                  rooms: state.rooms,
                  roomsLeft: state.roomsLeft,
                  resort: widget.resort,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
