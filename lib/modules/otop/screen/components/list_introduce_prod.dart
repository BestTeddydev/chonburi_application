import 'package:chonburi_mobileapp/modules/product/models/product_models.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';

class ListIntroductProducts extends StatelessWidget {
  const ListIntroductProducts({
    Key? key,
    required this.width,
    required this.height,
    required this.introducesProds,
  }) : super(key: key);
  final List<ProductModel> introducesProds;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: introducesProds.length,
      itemBuilder: (context, index) {
        ProductModel product = introducesProds[index];
        return SizedBox(
          width: width * 0.3,
          child: Card(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: height * 0.1,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                    child: ShowImageNetwork(
                      pathImage: product.imageRef,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextCustom(
                    title: product.productName,
                    fontSize: 12,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
