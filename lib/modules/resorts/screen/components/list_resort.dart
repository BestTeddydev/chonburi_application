import 'package:chonburi_mobileapp/modules/businesses/models/business_models.dart';
import 'package:chonburi_mobileapp/modules/resorts/screen/resort_detail.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';

class ListResorts extends StatelessWidget {
  final List<BusinessModel> resorts;
  final DateTime checkIn;
  final DateTime checkOut;
  const ListResorts({
    Key? key,
    required this.resorts,
    required this.checkIn,
    required this.checkOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: resorts.length,
        itemBuilder: (context, index) {
          BusinessModel resort = resorts[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onTap: () {
                if (!resort.statusOpen) {
                  showDialog(
                    context: context,
                    builder: (builder) => const DialogError(
                      message:
                          'บ้านพักไม่พร้อมเปิดให้บริการ ณ ขณะนี้ กรุณาลองใหม่ภายหลัง',
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResortDetail(
                        resort: resort,
                        checkIn: checkIn,
                        checkOut: checkOut,
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
                            pathImage: resort.imageRef,
                          ),
                          Container(
                            width: double.maxFinite,
                            height: double.maxFinite,
                            decoration: BoxDecoration(
                              color: !resort.statusOpen
                                  ? Colors.black54
                                  : Colors.transparent,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: !resort.statusOpen
                                  ? const [
                                      TextCustom(
                                        title: "บ้านพักปิดอยู่",
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
                              title: resort.businessName,
                              fontSize: 20,
                            ),
                          ),
                          Row(
                            children: [
                              TextCustom(
                                title: 'ราคาเฉลี่ย (${resort.ratePrice}) ฿',
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
