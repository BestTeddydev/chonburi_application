import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:flutter/material.dart';

class AlbumPicture extends StatelessWidget {
  final List<String> images;
  final String title;
  const AlbumPicture({
    Key? key,
    required this.images,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: AppConstant.colorText),
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(color: AppConstant.colorText),
      ),
      body: Container(
        width: width * 1,
        margin: const EdgeInsets.all(30),
        child: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 15,
            mainAxisExtent: height * 0.16,
          ),
          children: List.generate(
            images.length,
            (index) => SizedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ShowImageNetwork(
                  pathImage: images[index],
                  boxFit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
