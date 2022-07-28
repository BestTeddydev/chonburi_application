import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/manage_activity/models/activity_model.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/package_tour_models.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/round_models.dart';
import 'package:chonburi_mobileapp/modules/order_package/models/order_activity.dart';
import 'package:chonburi_mobileapp/modules/packages_datail/bloc/package_bloc.dart';
import 'package:chonburi_mobileapp/widget/dialog_comfirm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityListComponent extends StatelessWidget {
  final List<PackageRoundModel> rounds;
  final PackageState state;
  final double width;
  final PackageTourModel packageTour;
  final BuildContext context;
  final int indexRound;
  final String packageID;
  final int totalPerson;
  const ActivityListComponent({
    Key? key,
    required this.context,
    required this.packageTour,
    required this.rounds,
    required this.state,
    required this.width,
    required this.indexRound,
    required this.packageID,
    required this.totalPerson,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    onClearActiviy(
      BuildContext context,
      OrderActivityModel orderActivityModel,
      String packageID,
    ) {
      context.read<PackageBloc>().add(ClearBuyActivityEvent());
      context.read<PackageBloc>().add(
            BuyActivityEvent(
              activityModel: orderActivityModel,
              packageID: packageID,
            ),
          );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: rounds[indexRound].activities.length,
      itemBuilder: (itemBuilder, indexActivity) {
        ActivityModel activityModel =
            rounds[indexRound].activities[indexActivity];
        String roundId = rounds[indexRound].id;
        bool buyed = state.buyActivity
                .where(
                  (activity) =>
                      activity.id == activityModel.id &&
                      activity.roundId == roundId,
                )
                .toList()
                .isNotEmpty &&
            state.packageId == packageID;
        return Card(
          margin: const EdgeInsets.all(10),
          color: const Color.fromRGBO(216, 230, 237, 1),
          child: Container(
            margin: const EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * 0.4,
                  child: Text(
                    activityModel.activityName,
                    softWrap: true,
                    style: TextStyle(
                      color: AppConstant.colorText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  '${activityModel.price} ฿',
                  style: TextStyle(
                    color: AppConstant.colorText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: width * 0.2,
                  child: ElevatedButton(
                    onPressed: () {
                      OrderActivityModel orderActivityModel =
                          OrderActivityModel(
                        id: activityModel.id,
                        activityName: activityModel.activityName,
                        price: activityModel.price,
                        imageRef: activityModel.imageRef,
                        totalPerson: totalPerson,
                        businessId: activityModel.businessId,
                        status: AppConstant.waitingStatus,
                        roundId: roundId,
                        roundName: rounds[indexRound].round,
                        dayName: rounds[indexRound].dayType == 1
                            ? 'วันแรก'
                            : 'วันที่สอง',
                      );
                      if (state.packageId.isNotEmpty &&
                          state.packageId != packageTour.id) {
                        dialogConfirmActivity(
                          context,
                          orderActivityModel,
                          "คุณมีรายการที่จองไว้ในตะกร้า คุณแน่ใจที่จะเปลี่ยนแพ็คเกจใช่หรือไม่",
                          onClearActiviy,
                          packageTour.id,
                        );
                        return;
                      }

                      if (buyed) {
                        context.read<PackageBloc>().add(
                              CancelActivityEvent(
                                activityModel: orderActivityModel,
                                roundId: roundId,
                              ),
                            );
                      } else {
                        context.read<PackageBloc>().add(
                              BuyActivityEvent(
                                activityModel: orderActivityModel,
                                packageID: packageTour.id,
                              ),
                            );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: buyed
                          ? AppConstant.bgCancelActivity
                          : AppConstant.bgChooseActivity,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(buyed ? 'ยกเลิก' : 'เลือก'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
