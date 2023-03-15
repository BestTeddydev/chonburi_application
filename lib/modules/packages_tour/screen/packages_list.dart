import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/modules/contact_admin/models/contact_admin_model.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/package_tour_models.dart';
import 'package:chonburi_mobileapp/modules/manage_package/screen/update_round.dart';
import 'package:chonburi_mobileapp/modules/packages_tour/bloc/package_bloc.dart';
import 'package:chonburi_mobileapp/modules/packages_tour/screen/package_detail.dart';
import 'package:chonburi_mobileapp/widget/dialog_comfirm.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PackageList extends StatefulWidget {
  const PackageList({Key? key}) : super(key: key);

  @override
  State<PackageList> createState() => _PackageListState();
}

class _PackageListState extends State<PackageList> {
  // List<ActivitySelectedModel> hasTag(
  //     List<ActivitySelectedModel> activities, List<PackageRoundModel> rounds) {
  //   List<ActivitySelectedModel> activitys = [];
  //   List<ActivityModel> roundActivity = [];
  //   for (var i = 0; i < rounds.length; i++) {
  //     PackageRoundModel round = rounds[i];
  //     for (var j = 0; j < round.activities.length; j++) {
  //       ActivityModel activityModel = round.activities[j];
  //       roundActivity.add(activityModel);
  //     }
  //   }
  //   for (ActivitySelectedModel activity in activities) {
  //     List<ActivityModel> haveTag =
  //         roundActivity.where((element) => element.id == activity.id).toList();
  //     if (haveTag.isNotEmpty && activity.selected) activitys.add(activity);
  //   }
  //   return activitys;
  // }
  @override
  void initState() {
    super.initState();
    fetchsPackages();
  }

  fetchsPackages() {
    context.read<PackageBloc>().add(FetchsPackagesEvent());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocBuilder<PackageBloc, PackageState>(
      builder: (context, state) {
        List<PackageTourModel> packages = state.packages;
        return Scaffold(
          backgroundColor: AppConstant.backgroudApp,
          appBar: AppBar(
            title: Text(
              'รายการแพ็คเกจ',
              style: TextStyle(
                color: AppConstant.colorTextHeader,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              BlocBuilder<UserBloc, UserState>(
                builder: (context, stateUser) {
                  return IconButton(
                    onPressed: () {
                      if (stateUser.user.token.isEmpty) {
                        dialogWarningLogin(context);
                        return;
                      }
                      PackageTourModel packageTourModel = PackageTourModel(
                        id: '',
                        packageName: 'custom',
                        dayTrips: '',
                        round: [],
                        dayForrent: [],
                        packageImage: '',
                        mark: '',
                        createdBy: stateUser.user.username,
                        price: 0,
                        introduce: '',
                        description: '',
                        contactAdmin: ContactAdminModel(
                          accountPayment: '',
                          address: '',
                          createdBy: '',
                          fullName: '',
                          id: '',
                          phoneNumber: '',
                          typePayment: '',
                          imagePayment: '',
                          profileRef: '',
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => UpdateRound(
                            token: stateUser.user.token,
                            packageTourModel: packageTourModel,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.manage_history),
                  );
                },
              ),
            ],
            backgroundColor: AppConstant.themeApp,
            iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: packages.length,
                itemBuilder: (context, index) {
                  // List<ActivitySelectedModel> activitiesHasTag =
                  //     hasTag(activities, packages[index].round);
                  PackageTourModel packageModel = packages[index];
                  String? tripsType =
                      AppConstant.tripsType[packageModel.dayTrips];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => PackageDetail(
                            packageID: packageModel.id,
                            packageName: packageModel.packageName,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.all(14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width * 1,
                            height: height * 0.2,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(14),
                                topRight: Radius.circular(14),
                              ),
                              child: ShowImageNetwork(
                                pathImage: packageModel.packageImage,
                                boxFit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextCustom(
                                title: packageModel.packageName,
                                maxLine: 2,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: width * 0.2,
                                margin: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppConstant.bgHasTaged,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: TextCustom(
                                    title: tripsType ?? "วันเดย์ทริป",
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.3,
                                child: TextCustom(
                                    title: '${packageModel.price}/ท่าน'),
                              )
                            ],
                          ),
                          // SizedBox(
                          //   height: 40,
                          //   child: ListView.builder(
                          //     shrinkWrap: true,
                          //     physics: const BouncingScrollPhysics(),
                          //     itemCount: activitiesHasTag.length,
                          //     scrollDirection: Axis.horizontal,
                          //     itemBuilder: (context, index) => Container(
                          //       width: width * 0.4,
                          //       margin: const EdgeInsets.all(4),
                          //       decoration: BoxDecoration(
                          //         color: AppConstant.bgHasTaged,
                          //         borderRadius: BorderRadius.circular(8),
                          //       ),
                          //       child: Center(
                          //         child: Text(
                          //           '# ${activitiesHasTag[index].activityName}',
                          //           maxLines: 1,
                          //           softWrap: true,
                          //           overflow: TextOverflow.ellipsis,
                          //           style: const TextStyle(
                          //             color: Colors.white,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
