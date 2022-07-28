import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/custom_activity/bloc/activity_bloc.dart';
import 'package:chonburi_mobileapp/modules/custom_activity/models/activity_selected_model.dart';
import 'package:chonburi_mobileapp/modules/manage_activity/models/activity_model.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/package_tour_models.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/round_models.dart';
import 'package:chonburi_mobileapp/modules/packages_datail/screen/package_detail.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PackageList extends StatefulWidget {
  const PackageList({Key? key}) : super(key: key);

  @override
  State<PackageList> createState() => _PackageListState();
}

class _PackageListState extends State<PackageList> {
  List<ActivitySelectedModel> hasTag(
      List<ActivitySelectedModel> activities, List<PackageRoundModel> rounds) {
    List<ActivitySelectedModel> activitys = [];
    List<ActivityModel> roundActivity = [];
    for (var i = 0; i < rounds.length; i++) {
      PackageRoundModel round = rounds[i];
      for (var j = 0; j < round.activities.length; j++) {
        ActivityModel activityModel = round.activities[j];
        roundActivity.add(activityModel);
      }
    }
    for (ActivitySelectedModel activity in activities) {
      List<ActivityModel> haveTag =
          roundActivity.where((element) => element.id == activity.id).toList();
      if (haveTag.isNotEmpty && activity.selected) activitys.add(activity);
    }
    return activitys;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocBuilder<ActivityBloc, ActivityState>(
      builder: (context, state) {
        List<PackageTourModel> packages = state.packages;
        List<ActivitySelectedModel> activities = state.activities;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'รายการแพ็คเกจ',
              style: TextStyle(
                color: AppConstant.colorTextHeader,
                fontWeight: FontWeight.w600,
              ),
            ),
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
                  List<ActivitySelectedModel> activitiesHasTag =
                      hasTag(activities, packages[index].round);
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => PackageDetail(
                            packageID: packages[index].id,
                            packageName: packages[index].packageName,
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
                                pathImage: packages[index].packageImage,
                                boxFit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              packages[index].packageName,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                color: AppConstant.colorText,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: activitiesHasTag.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Container(
                                width: width * 0.4,
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppConstant.bgHasTaged,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    '# ${activitiesHasTag[index].activityName}',
                                    maxLines: 1,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
