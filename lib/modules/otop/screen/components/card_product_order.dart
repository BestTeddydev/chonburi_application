import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/otop/models/product_cart_model.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';

class CardProductOrder extends StatelessWidget {
  const CardProductOrder({
    Key? key,
    required this.width,
    required this.product,
    required this.removeProduct,
  }) : super(key: key);

  final double width;
  final ProductCartModel product;
  final Function removeProduct;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width * 0.24,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ShowImageNetwork(
                pathImage: product.imageURL,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            width: width * 0.46,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCustom(
                  title: product.productName,
                  maxLine: 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                  ),
                  child: TextCustom(
                    title: '${product.price} x ${product.amount}',
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {
                  ProductCartModel newModels =
                      product; // set amout = 0 for remove but add again
                  newModels.amount = 0;
                  removeProduct(newModels);
                },
                icon: Icon(
                  Icons.delete_outline,
                  size: 18,
                  color: AppConstant.bgCancelActivity,
                ),
              ),
              TextCustom(
                title: '${product.price * product.amount} ฿',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
