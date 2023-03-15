import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/contact_info/bloc/contact_bloc.dart';
import 'package:chonburi_mobileapp/modules/contact_info/screen/contact_detail.dart';
import 'package:chonburi_mobileapp/modules/custom_package/bloc/custom_package_bloc.dart';
import 'package:chonburi_mobileapp/modules/custom_package/models/order_custom.dart';
import 'package:chonburi_mobileapp/modules/custom_package/screen/components/brief.dart';
import 'package:chonburi_mobileapp/modules/custom_package/screen/tracking_custom.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/round_models.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/dialog_success.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingCustomPackage extends StatefulWidget {
  final OrderCustomModel orderPackageModel;
  final String token;
  final String userId;
  const BookingCustomPackage({
    Key? key,
    required this.orderPackageModel,
    required this.token,
    required this.userId,
  }) : super(key: key);

  @override
  State<BookingCustomPackage> createState() => _BookingCustomPackageState();
}

class _BookingCustomPackageState extends State<BookingCustomPackage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'สรุปรายการกิจกรรม',
          style: TextStyle(color: AppConstant.colorText),
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(color: AppConstant.colorText),
      ),
      backgroundColor: AppConstant.backgroudApp,
      body: BlocListener<CustomPackageBloc, CustomPackageState>(
        listener: (context, customListener) {
          if (customListener.loaded) {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (builder) => TrackingCustom(
                    token: widget.token,
                    userId: widget.userId,
                  ),
                ),
                (route) => false);
            showDialog(
              context: context,
              builder: (builder) =>
                  const DialogSuccess(message: 'ชำระเงินเรียบร้อย '),
            );
          }
          if (customListener.hasError) {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (builder) => const DialogError(
                message: 'เกิดเหตุขัดข้องขออภัยในความไม่สะดวก',
              ),
            );
          }
        },
        child: BlocBuilder<CustomPackageBloc, CustomPackageState>(
          builder: (context, state) {
            List<PackageRoundModel> rounds = state.rounds;
            return SafeArea(
              child: ListView(
                children: [
                  const ContactDetail(),
                  SizedBox(
                    height: height * 0.7,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: rounds.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextCustom(
                                title:
                                    '${rounds[index].round}(${rounds[index].dayType})',
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: rounds[index].activities.length,
                                  itemBuilder: (context, i) {
                                    return Card(
                                      // color: AppConstant.bgChooseActivity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: width * 0.6,
                                              child: TextCustom(
                                                  title: rounds[index]
                                                      .activities[i]
                                                      .activityName),
                                            ),
                                            SizedBox(
                                              width: width * 0.2,
                                              child: TextCustom(
                                                title:
                                                    "${rounds[index].activities[i].price} ฿",
                                              ),
                                            ),
                                            SizedBox(
                                              width: width * 0.1,
                                              child: IconButton(
                                                onPressed: () {
                                                  context
                                                      .read<CustomPackageBloc>()
                                                      .add(
                                                        RemoveActivityCustomEvent(
                                                          activityModel: rounds[
                                                                  index]
                                                              .activities[i],
                                                          roundId:
                                                              rounds[index].id,
                                                        ),
                                                      );
                                                },
                                                icon: Icon(
                                                  Icons.delete_forever,
                                                  color: AppConstant
                                                      .bgCancelActivity,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  BlocBuilder<ContactBloc, ContactState>(
                    builder: (context, stateContact) {
                      return Column(
                        children: [
                          BriefCustomPackage(
                            orderPackageModel: widget.orderPackageModel,
                          ),
                          SizedBox(
                            child: ElevatedButton(
                              onPressed: () {
                                if (stateContact.myContact.id.isEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (builder) => const DialogError(
                                        message: "กรุณาเลือกที่อยู่ของท่าน"),
                                  );
                                  return;
                                }
                                widget.orderPackageModel.contact =
                                    stateContact.myContact;
                                print(widget.orderPackageModel.toMap());
                                context.read<CustomPackageBloc>().add(
                                      CreateOrderCustomEvent(
                                        orderCustomModel:
                                            widget.orderPackageModel,
                                        token: widget.token,
                                      ),
                                    );
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white),
                              child: const TextCustom(title: 'ยืนยันการจอง'),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
