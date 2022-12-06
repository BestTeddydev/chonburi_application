import 'package:chonburi_mobileapp/modules/businesses/models/business_models.dart';
import 'package:chonburi_mobileapp/modules/otop/screen/otop_detail.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';

class ListOtops extends StatelessWidget {
  final List<BusinessModel> otops;
  final BuildContext buildContext;
  const ListOtops({Key? key, required this.otops,required this.buildContext,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: otops.length,
        itemBuilder: (context, index) {
          BusinessModel otop = otops[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onTap: () {
                if (!otop.statusOpen) {
                  showDialog(
                    context: context,
                    builder: (builder) => const DialogError(
                      message:
                          'ร้านอาหารไม่พร้อมเปิดให้บริการ ณ ขณะนี้ กรุณาลองใหม่ภายหลัง',
                    ),
                  );
                } else {
                  Navigator.push(
                    buildContext,
                    MaterialPageRoute(
                      builder: (context) => OtopDetail(
                        businessId: otop.id,
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
                            pathImage: otop.imageRef,
                          ),
                          Container(
                            width: double.maxFinite,
                            height: double.maxFinite,
                            decoration: BoxDecoration(
                              color: !otop.statusOpen
                                  ? Colors.black54
                                  : Colors.transparent,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: !otop.statusOpen
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
                              title: otop.businessName,
                              fontSize: 20,
                            ),
                          ),
                          Row(
                            children: [
                              TextCustom(
                                title: 'ราคาเฉลี่ย (${otop.ratePrice}) ฿',
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
