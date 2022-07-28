import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/manage_activity/bloc/manage_activity_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_activity/models/activity_model.dart';
import 'package:chonburi_mobileapp/widget/dialog_comfirm.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityBusiness extends StatefulWidget {
  final String token, businessId;
  final bool accepted;
  const ActivityBusiness({
    Key? key,
    required this.businessId,
    required this.token,
    required this.accepted,
  }) : super(key: key);

  @override
  State<ActivityBusiness> createState() => _ActivityBusinessState();
}

class _ActivityBusinessState extends State<ActivityBusiness> {
  @override
  void initState() {
    context.read<ManageActivityBloc>().add(
          FetchActivityBusiness(
            token: widget.token,
            businessId: widget.businessId,
            accepted: widget.accepted,
          ),
        );
    super.initState();
  }

  onApproveActivity(
    BuildContext context,
    ActivityModel activityModel,
    String packageId, // รับเพราะ ใช้ dialogConfirm ร่วมกับ package
  ) {
    context.read<ManageActivityBloc>().add(
          PartnerApproveActivityEvent(
            activityModel: activityModel,
            token: widget.token,
          ),
        );
  }

  onRejectActivity(
    BuildContext context,
    ActivityModel activityModel,
    String packageId, // รับเพราะ ใช้ dialogConfirm ร่วมกับ package
  ) {
    context.read<ManageActivityBloc>().add(
          PartnerRejectActivityEvent(
            activityModel: activityModel,
            token: widget.token,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocBuilder<ManageActivityBloc, ManageActivityState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: state.activities.length,
              itemBuilder: (itemBuilder, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: widget.accepted ? width * 0.26 : width * 0.22,
                        height: height * .1,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          child: ShowImageNetwork(
                            pathImage:
                                state.activities[index].imageRef.isNotEmpty
                                    ? state.activities[index].imageRef.first
                                    : '',
                            boxFit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        width: width * 0.4,
                        child: Text(
                          state.activities[index].activityName,
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
                        width: widget.accepted ? width * 0.2 : width * 0.26,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: widget.accepted
                              ? [
                                  Text(
                                    '${state.activities[index].price} ฿',
                                    softWrap: true,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: AppConstant.colorText,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ]
                              : [
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          ActivityModel activity =
                                              ActivityModel(
                                            id: state.activities[index].id,
                                            activityName: state
                                                .activities[index].activityName,
                                            price:
                                                state.activities[index].price,
                                            unit: state.activities[index].unit,
                                            imageRef: state
                                                .activities[index].imageRef,
                                            minPerson: state
                                                .activities[index].minPerson,
                                            businessId: state
                                                .activities[index].businessId,
                                            accepted: true,
                                          );
                                          dialogApproveActivity(
                                            context,
                                            activity,
                                            'คุณแน่ใจที่จะเข้าร่วมกิจกรรมนี้ใช่หรือไม่',
                                            onApproveActivity,
                                            '',
                                          );
                                        },
                                        icon: Icon(
                                          Icons.check_circle_outline,
                                          size: 20,
                                          color: AppConstant.bgChooseActivity,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          ActivityModel activity =
                                              ActivityModel(
                                            id: state.activities[index].id,
                                            activityName: state
                                                .activities[index].activityName,
                                            price:
                                                state.activities[index].price,
                                            unit: state.activities[index].unit,
                                            imageRef: state
                                                .activities[index].imageRef,
                                            minPerson: state
                                                .activities[index].minPerson,
                                            businessId: '',
                                            accepted: false,
                                          );
                                          dialogApproveActivity(
                                            context,
                                            activity,
                                            'คุณแน่ใจที่จะปฏิเสธกิจกรรมนี้ใช่หรือไม่',
                                            onRejectActivity,
                                            '',
                                          );
                                        },
                                        icon: Icon(
                                          Icons.highlight_off,
                                          size: 20,
                                          color: AppConstant.bgCancelActivity,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
        );
      },
    );
  }
}
