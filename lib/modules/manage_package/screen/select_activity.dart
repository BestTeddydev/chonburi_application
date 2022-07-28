import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/manage_activity/bloc/manage_activity_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_package/bloc/manage_package_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/round_models.dart';
import 'package:chonburi_mobileapp/widget/data_empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectActivity extends StatefulWidget {
  final String token;
  // final List<ActivityModel> activityInRound;
  final String roundId;
  const SelectActivity({
    Key? key,
    required this.token,
    // required this.activityInRound,
    required this.roundId,
  }) : super(key: key);

  @override
  State<SelectActivity> createState() => _SelectActivityState();
}

class _SelectActivityState extends State<SelectActivity> {
  @override
  void initState() {
    context.read<ManageActivityBloc>().add(
          FetchActivityManage(
            token: widget.token,
            accepted: true,
          ),
        );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'กิจกรรมทั้งหมด',
          style: TextStyle(color: AppConstant.colorTextHeader),
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
      ),
      backgroundColor: AppConstant.backgroudApp,
      body: BlocBuilder<ManageActivityBloc, ManageActivityState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: state.activities.isNotEmpty
                  ? [
                      BlocBuilder<ManagePackageBloc, ManagePackageState>(
                        builder: (context, statePackage) {
                          PackageRoundModel rounds = statePackage.rounds
                              .where((element) => element.id == widget.roundId)
                              .first;
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: state.activities.length,
                            itemBuilder: (context, index) {
                              bool isMatch = rounds.activities
                                  .where(
                                    (element) =>
                                        element.id ==
                                        state.activities[index].id,
                                  )
                                  .isNotEmpty;

                              return InkWell(
                                onTap: () {
                                  if (isMatch) {
                                    context.read<ManagePackageBloc>().add(
                                          RemoveActivityEvent(
                                            activityModel:
                                                state.activities[index],
                                            roundId: widget.roundId,
                                          ),
                                        );
                                  } else {
                                    context.read<ManagePackageBloc>().add(
                                          SelectActivityEvent(
                                            activityModel:
                                                state.activities[index],
                                            roundId: widget.roundId,
                                          ),
                                        );
                                  }
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  margin: const EdgeInsets.all(6),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(8),
                                        width: width * 0.7,
                                        child: Text(
                                          '${state.activities[index].activityName} (${state.activities[index].price} ฿)',
                                          softWrap: true,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: AppConstant.colorText,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 8),
                                        width: width * 0.2,
                                        child: Icon(
                                          isMatch ? Icons.check : null,
                                          color: AppConstant.colorText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ]
                  : [
                      const Center(
                        child: DataEmpty(),
                      )
                    ],
            ),
          );
        },
      ),
    );
  }
}
