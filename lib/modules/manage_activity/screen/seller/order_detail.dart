import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/custom_package/models/order_custom.dart';
import 'package:chonburi_mobileapp/modules/manage_activity/bloc/manage_activity_bloc.dart';
import 'package:chonburi_mobileapp/modules/order_package/models/order_activity.dart';
import 'package:chonburi_mobileapp/widget/dialog_comfirm.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetail extends StatefulWidget {
  final OrderCustomModel orderPackageModel;
  final String businessId;
  final String token;
  const OrderDetail({
    Key? key,
    required this.orderPackageModel,
    required this.businessId,
    required this.token,
  }) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  void initState() {
    context.read<ManageActivityBloc>().add(
          SetMyOrderActivityEvent(
            ordersActivity: widget.orderPackageModel.orderActivities,
            businessId: widget.businessId,
          ),
        );
    super.initState();
  }

  onAcceptOrder(BuildContext context) {
    context.read<ManageActivityBloc>().add(ActionOrderActivityEvent(
          token: widget.token,
          businessId: widget.businessId,
          status: AppConstant.acceptStatus,
          docId: widget.orderPackageModel.id,
        ));
  }

  onRejecttOrder(BuildContext context) {
    context.read<ManageActivityBloc>().add(
          ActionOrderActivityEvent(
            token: widget.token,
            businessId: widget.businessId,
            status: AppConstant.rejectStatus,
            docId: widget.orderPackageModel.id,
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
          'รายละเอียดออเดอร์',
          style: TextStyle(
            color: AppConstant.colorTextHeader,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(
          color: AppConstant.colorTextHeader,
        ),
      ),
      backgroundColor: AppConstant.backgroudApp,
      body: BlocBuilder<ManageActivityBloc, ManageActivityState>(
        builder: (context, state) {
          List<OrderActivityModel> orderActivities =
              state.orderActivityBusiness;
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.82,
                  child: ListView(
                    children: [
                      // CardOrderPackage(
                      //   width: width,
                      //   height: height,
                      //   order: widget.orderPackageModel,
                      // ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: orderActivities.length,
                        itemBuilder: (itemBuilder, index) {
                          OrderActivityModel orderActivityModel =
                              orderActivities[index];
                          return Card(
                            margin: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                              left: 30,
                              right: 30,
                            ),
                            color: AppConstant.bgOrderCard,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: width * 0.46,
                                    margin: const EdgeInsets.all(8),
                                    child: Text(
                                      orderActivityModel.activityName,
                                      style: TextStyle(
                                        color: AppConstant.colorText,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      softWrap: true,
                                    ),
                                  ),
                                  Text(
                                    '${orderActivityModel.price} x ${orderActivityModel.totalPerson}',
                                    style: TextStyle(
                                      color: AppConstant.colorText,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    orderActivityModel.status,
                                    style: TextStyle(
                                      color: AppConstant.statusColor[
                                          orderActivityModel.status],
                                      fontWeight: FontWeight.w600,
                                    ),
                                    softWrap: true,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: width * 0.5,
                      child: ElevatedButton(
                        onPressed: () {
                          if (orderActivities.first.status !=
                              AppConstant.waitingStatus) {
                            showDialog(
                              context: context,
                              builder: (builder) => const DialogError(
                                message:
                                    'ไม่สามารถอนุมัติได้ เนื่องจากกิจกรรมไม่ได้อยู่ในสถานะ รออนุมัติ',
                              ),
                            );
                            return;
                          }
                          dialogConfirm(
                            context,
                            onAcceptOrder,
                            'คุณแน่ใจแล้วใช่หรือไม่ที่จะอนุมัติกิจกรรมในออเดอร์นี้',
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppConstant.bgChooseActivity,
                          padding: const EdgeInsets.all(16.0),
                        ),
                        child: const Text(
                          'อนุมัติ',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.5,
                      child: ElevatedButton(
                        onPressed: () {
                          if (orderActivities.first.status !=
                              AppConstant.waitingStatus) {
                            showDialog(
                              context: context,
                              builder: (builder) => const DialogError(
                                message:
                                    'ไม่สามารถปฏิเสธได้ เนื่องจากกิจกรรมไม่ได้อยู่ในสถานะ รออนุมัติ',
                              ),
                            );
                            return;
                          }
                          dialogConfirm(
                            context,
                            onRejecttOrder,
                            'คุณแน่ใจแล้วใช่หรือไม่ที่จะปฏิเสธกิจกรรมในออเดอร์นี้',
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppConstant.bgCancelActivity,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'ปฏิเสธ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
