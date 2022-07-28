import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/package_tour_models.dart';
import 'package:chonburi_mobileapp/widget/album_picture.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:flutter/material.dart';
class AlbumActivity extends StatelessWidget {
  const AlbumActivity({
    Key? key,
    required this.width,
    required this.packageTour,
    required this.height,
    required this.imagesActivity,
  }) : super(key: key);

  final double width;
  final PackageTourModel packageTour;
  final double height;
  final List<String> imagesActivity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: width * 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              packageTour.packageName,
              style: TextStyle(
                color: AppConstant.colorTextHeader,
                fontSize: 16,
              ),
            ),
          ),
          Text(
            packageTour.introduce,
            softWrap: true,
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppConstant.colorText,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            width: width * 1,
            height: height * 0.14,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: imagesActivity.length > 3
                  ? 4
                  : imagesActivity.length,
              itemBuilder: (itemBuilder, index) {
                return Container(
                  margin: const EdgeInsets.all(5.0),
                  width: width * 0.21,
                  child: index == 3
                      ? InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => AlbumPicture(
                                  images: imagesActivity,
                                  title: 'รูปภาพกิจกรรมทั้งหมด',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppConstant.bgActivityName,
                              borderRadius:
                                  BorderRadius.circular(14),
                            ),
                            child: Center(
                                child: Text(
                              'ดูเพิ่มเติม',
                              style: TextStyle(
                                color: AppConstant.colorText,
                              ),
                            )),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(14.0),
                          child: ShowImageNetwork(
                            pathImage: imagesActivity[index],
                            boxFit: BoxFit.fill,
                          ),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}