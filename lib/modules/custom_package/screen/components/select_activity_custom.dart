import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/custom_package/bloc/custom_package_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_activity/bloc/manage_activity_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/round_models.dart';
import 'package:chonburi_mobileapp/widget/data_empty.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectActivityCustom extends StatefulWidget {
  final String roundId;
  final String token;
  const SelectActivityCustom({
    Key? key,
    required this.roundId,
    required this.token,
  }) : super(key: key);

  @override
  State<SelectActivityCustom> createState() => _SelectActivityCustomState();
}

class _SelectActivityCustomState extends State<SelectActivityCustom> {
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
                      BlocBuilder<CustomPackageBloc, CustomPackageState>(
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
                                    context.read<CustomPackageBloc>().add(
                                          RemoveActivityCustomEvent(
                                            activityModel:
                                                state.activities[index],
                                            roundId: widget.roundId,
                                          ),
                                        );
                                  } else {
                                    context.read<CustomPackageBloc>().add(
                                          SelectActivityCustomEvent(
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
                                  color: isMatch
                                      ? AppConstant.bgTextFormField
                                      : Colors.white,
                                  margin: const EdgeInsets.all(6),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: width * 0.3,
                                        height: 100,
                                        child: ShowImageNetwork(
                                          pathImage: state.activities[index]
                                                  .imageRef.isNotEmpty
                                              ? state
                                                  .activities[index].imageRef[0]
                                              : "",
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.all(8),
                                        width: width * 0.6,
                                        child: Column(
                                          children: [
                                            Text(
                                              state.activities[index]
                                                  .activityName,
                                              softWrap: true,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: AppConstant.colorText,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            TextCustom(
                                              title:
                                                  '${state.activities[index].price} ฿',
                                            ),
                                            TextCustom(
                                              title:
                                                  '${state.activities[index].usageTime} ',
                                            ),
                                          ],
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
