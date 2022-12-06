import 'package:chonburi_mobileapp/modules/businesses/models/business_models.dart';
import 'package:chonburi_mobileapp/modules/restaurant/screen/restaurant_detail.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';

class ListRestaurant extends StatelessWidget {
  final List<BusinessModel> restaurants;
  const ListRestaurant({
    Key? key,
    required this.restaurants,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          BusinessModel restaurant = restaurants[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onTap: () {
                if (!restaurant.statusOpen) {
                  showDialog(
                    context: context,
                    builder: (builder) => const DialogError(
                      message:
                          'ร้านอาหารไม่พร้อมเปิดให้บริการ ณ ขณะนี้ กรุณาลองใหม่ภายหลัง',
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RestaurantDetail(
                        restaurant: restaurant,
                      ),
                    ),
                  );
                }
              },
              child: SizedBox(
                height: height * .25,
                width: width * 1,
                child: Column(
                  children: [
                    SizedBox(
                      width: width * 7,
                      height: height * 0.18,
                      child: Stack(
                        children: [
                          ShowImageNetwork(
                            pathImage: restaurant.imageRef,
                          ),
                          Container(
                            width: double.maxFinite,
                            height: double.maxFinite,
                            decoration: BoxDecoration(
                              color: !restaurant.statusOpen
                                  ? Colors.black54
                                  : Colors.transparent,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: !restaurant.statusOpen
                                  ? const [
                                      TextCustom(
                                        title: "ร้านปิดอยู่",
                                      ),
                                    ]
                                  : [],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 20, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextCustom(
                              title: restaurant.businessName,
                              fontSize: 20,
                            ),
                          ),
                          Row(
                            children: [
                              TextCustom(
                                title: 'ราคาเฉลี่ย (${restaurant.ratePrice}) ฿',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
