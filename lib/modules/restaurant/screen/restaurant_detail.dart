import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/businesses/models/business_models.dart';
import 'package:chonburi_mobileapp/modules/restaurant/bloc/restaurant_bloc.dart';
import 'package:chonburi_mobileapp/modules/restaurant/screen/components/list_foods.dart';
import 'package:chonburi_mobileapp/modules/restaurant/screen/restaurant_about.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaurantDetail extends StatefulWidget {
  final BusinessModel restaurant;
  const RestaurantDetail({Key? key, required this.restaurant})
      : super(key: key);

  @override
  State<RestaurantDetail> createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() {
    context
        .read<RestaurantBloc>()
        .add(FetchsCategoryEvent(businessId: widget.restaurant.id));
    context
        .read<RestaurantBloc>()
        .add(FetchsFoodsEvent(businessId: widget.restaurant.id));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocBuilder<RestaurantBloc, RestaurantState>(
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
                      pathImage: widget.restaurant.imageRef,
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
                            title: widget.restaurant.businessName,
                            maxLine: 2,
                            fontSize: 16,
                          ),
                          TextCustom(
                            title: 'ที่อยู่ ${widget.restaurant.address}',
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
                                restaurant: widget.restaurant,
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
              ListFoods(
                categories: state.categories,
                foods: state.foods,
              ),
            ],
          );
        },
      ),
    );
  }
}
