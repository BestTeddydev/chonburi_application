import 'package:chonburi_mobileapp/constants/api_path.dart';
import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:flutter/material.dart';

import 'image_blank.dart';

class ShowImageNetwork extends StatelessWidget {
  final String pathImage;
  final BoxFit? boxFit;
  const ShowImageNetwork({
    Key? key,
    required this.pathImage,
    this.boxFit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return pathImage.isNotEmpty
        ? Image.network(
            '${APIRoute.hostImage}$pathImage',
            fit: boxFit ?? BoxFit.fitWidth,
            width: width * 0.99,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  color: AppConstant.themeApp,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder: (BuildContext buildImageError, object, stackthree) {
              return const ImageBlank();
            },
          )
        : const Center(child: ImageBlank());
  }
}
