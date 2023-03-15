import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/custom_package/models/order_custom.dart';
import 'package:chonburi_mobileapp/modules/order_package/bloc/order_package_bloc.dart';
import 'package:chonburi_mobileapp/modules/order_package/models/order_activity.dart';
import 'package:chonburi_mobileapp/widget/dialog_comfirm.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class OrderDetailAdmin extends StatefulWidget {
  final OrderCustomModel orderPackageModel;
  final String token;
  const OrderDetailAdmin({
    Key? key,
    required this.orderPackageModel,
    required this.token,
  }) : super(key: key);

  @override
  State<OrderDetailAdmin> createState() => _OrderDetailAdminState();
}

class _OrderDetailAdminState extends State<OrderDetailAdmin> {
  onAcceptOrderPackage(BuildContext context) {
    context.read<OrderPackageBloc>().add(
          UpdateOrderPackageEvent(
            token: widget.token,
            status: AppConstant.pay,
            docId: widget.orderPackageModel.id,
          ),
        );
  }

  onRejectOrderPackage(BuildContext context) {
    context.read<OrderPackageBloc>().add(
          UpdateOrderPackageEvent(
            token: widget.token,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.82,
              child: ListView(
                children: [
                  Card(
                    margin: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: AppConstant.bgOrderCard,
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            left: 20,
                            bottom: 25,
                          ),
                          width: width * 0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   widget.orderPackageModel.packageName,
                              //   style: TextStyle(
                              //     color: AppConstant.colorTextHeader,
                              //     fontWeight: FontWeight.w600,
                              //     fontSize: 14,
                              //   ),
                              //   softWrap: true,
                              //   maxLines: 2,
                              //   overflow: TextOverflow.ellipsis,
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 8,
                                ),
                                child: Text(
                                  'ราคา : ${widget.orderPackageModel.totalPrice} ฿',
                                  style: TextStyle(
                                    color: AppConstant.colorText,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Text(
                                widget.orderPackageModel.status,
                                style: TextStyle(
                                  color: AppConstant.statusColor[
                                      widget.orderPackageModel.status],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextCustom(
                                      title: DateFormat('dd/MM/yyyy').format(
                                          widget.orderPackageModel.checkIn),
                                      fontSize: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: widget.orderPackageModel.orderActivities.length,
                    itemBuilder: (itemBuilder, index) {
                      OrderActivityModel orderActivityModel =
                          widget.orderPackageModel.orderActivities[index];
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  color: AppConstant
                                      .statusColor[orderActivityModel.status],
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
                      // bool checkAlready = widget
                      //     .orderPackageModel.orderActivities
                      //     .where((element) =>
                      //         element.status != AppConstant.acceptStatus)
                      //     .isNotEmpty;
                      // if (checkAlready) {
                      //   showDialog(
                      //     context: context,
                      //     builder: (builder) => const DialogError(
                      //       message:
                      //           'ไม่สามารถอนุมัติได้ เนื่องจากกิจกรรมยังไม่ถูกอนุมัติทั้งหมด',
                      //     ),
                      //   );
                      //   return;
                      // }
                      dialogConfirm(
                        context,
                        onAcceptOrderPackage,
                        'คุณแน่ใจแล้วใช่หรือไม่ที่จะอนุมัติแพ็คเกจนี้',
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
                      dialogConfirm(
                        context,
                        onRejectOrderPackage,
                        'คุณแน่ใจแล้วใช่หรือไม่ที่จะปฏิเสธแพ็คเกจนี้',
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: AppConstant.bgCancelActivity,
                      padding: const EdgeInsets.all(16.0),
                    ),
                    child: const Text(
                      'ปฏิเสธ',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
