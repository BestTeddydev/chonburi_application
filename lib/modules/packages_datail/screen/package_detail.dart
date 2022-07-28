import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/modules/auth/models/user_model.dart';
import 'package:chonburi_mobileapp/modules/auth/screen/login.dart';
import 'package:chonburi_mobileapp/modules/custom_activity/bloc/activity_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_activity/models/activity_model.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/package_tour_models.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/round_models.dart';
import 'package:chonburi_mobileapp/modules/packages_datail/bloc/package_bloc.dart';
import 'package:chonburi_mobileapp/modules/packages_datail/screen/booking_packages.dart';
import 'package:chonburi_mobileapp/modules/packages_datail/screen/components/album_activity.dart';
import 'package:chonburi_mobileapp/modules/packages_datail/screen/components/days_list.dart';
import 'package:chonburi_mobileapp/widget/dialog_comfirm.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PackageDetail extends StatefulWidget {
  final String packageID;
  final String packageName;
  const PackageDetail({
    Key? key,
    required this.packageID,
    required this.packageName,
  }) : super(key: key);

  @override
  State<PackageDetail> createState() => _PackageDetailState();
}

class _PackageDetailState extends State<PackageDetail> {
  @override
  void initState() {
    context.read<PackageBloc>().add(
          FetchPackageEvent(packageID: widget.packageID),
        );
    super.initState();
  }

  List<String> photosActivity(List<PackageRoundModel> rounds) {
    List<String> images = [];
    for (PackageRoundModel round in rounds) {
      for (ActivityModel activity in round.activities) {
        images.addAll(activity.imageRef);
      }
    }
    return images.toSet().toList();
  }

  goToLogin(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => const AuthenLogin(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.packageName,
          style: TextStyle(color: AppConstant.colorText),
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(color: AppConstant.colorText),
      ),
      body: BlocBuilder<PackageBloc, PackageState>(
        builder: (context, state) {
          PackageTourModel packageTour = state.packagesTour;
          List<String> imagesActivity = photosActivity(packageTour.round);
          int roundLength = state.packagesTour.dayTrips == '1d' ? 1 : 2;
          return BlocBuilder<ActivityBloc, ActivityState>(
            builder: (context, stateActivity) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: width * 1,
                      height: height * 0.26,
                      child: ShowImageNetwork(
                        pathImage: packageTour.packageImage,
                      ),
                    ),
                    AlbumActivity(
                      width: width,
                      packageTour: packageTour,
                      height: height,
                      imagesActivity: imagesActivity,
                    ),
                    // BlocBuilder<ActivityBloc, ActivityState>(
                    // builder: (context, stateActivity) {
                    //   return
                    DayListComponent(
                      context: context,
                      packageTour: packageTour,
                      state: state,
                      width: width,
                      packageID: widget.packageID,
                      roundLength: roundLength,
                      totalPerson: stateActivity.totalMember,
                    ),
                    //   },
                    // ),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, stateUser) {
                        UserModel userModel = stateUser.user;
                        return SizedBox(
                          width: width * 1,
                          child: ElevatedButton(
                            onPressed: state.packageId != widget.packageID
                                ? null
                                : () {
                                    if (userModel.token.isEmpty) {
                                      dialogWarningLogin(
                                        context,
                                        goToLogin,
                                      );
                                      return;
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (builder) => BookingPackages(
                                          checkIn: stateActivity.checkDate,
                                          totalMember:
                                              stateActivity.totalMember,
                                        ),
                                      ),
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                                primary: AppConstant.themeApp),
                            child: Text(
                              'สั่งซื้อ',
                              style: TextStyle(
                                color: AppConstant.colorText,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
