import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/models/user_model.dart';
import 'package:chonburi_mobileapp/modules/contact_admin/bloc/contact_admin_bloc.dart';
import 'package:chonburi_mobileapp/modules/contact_admin/models/contact_admin_model.dart';
import 'package:chonburi_mobileapp/modules/contact_admin/screen/contacts_admin.dart';
import 'package:chonburi_mobileapp/modules/contact_info/models/contact_models.dart';
import 'package:chonburi_mobileapp/modules/custom_package/bloc/custom_package_bloc.dart';
import 'package:chonburi_mobileapp/modules/custom_package/models/order_custom.dart';
import 'package:chonburi_mobileapp/modules/custom_package/screen/components/booking_custom_package.dart';
import 'package:chonburi_mobileapp/modules/custom_package/screen/components/select_activity_custom.dart';
import 'package:chonburi_mobileapp/modules/manage_activity/models/activity_model.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/round_models.dart';
import 'package:chonburi_mobileapp/modules/order_package/models/order_activity.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomPackagePage extends StatefulWidget {
  final DateTime checkIn;
  final DateTime checkOut;
  final int totalPerson;
  final UserModel user;
  const CustomPackagePage({
    Key? key,
    required this.checkIn,
    required this.checkOut,
    required this.totalPerson,
    required this.user,
  }) : super(key: key);

  @override
  State<CustomPackagePage> createState() => _CustomPackagePageState();
}

class _CustomPackagePageState extends State<CustomPackagePage> {
  _addFieldRound(id, dayType) {
    PackageRoundModel roundModel = PackageRoundModel(
      round: '',
      dayType: dayType,
      activities: [],
      id: id,
    );
    context.read<CustomPackageBloc>().add(
          AddRoundCustomEvent(roundModel: roundModel),
        );
  }

  _deleteRound(PackageRoundModel roundModel) {
    context.read<CustomPackageBloc>().add(
          RemoveRoundCustomEvent(roundModel: roundModel),
        );
  }

  _updateRound(PackageRoundModel roundModel, String value) {
    context
        .read<CustomPackageBloc>()
        .add(UpdateRoundNameCustomEvent(roundModel: roundModel, value: value));
  }

  OrderCustomModel summaryBooking(List<PackageRoundModel> rounds,
      int totalMember, ContactAdminModel contactAdminModel, UserModel user) {
    OrderCustomModel orderCustomModel = OrderCustomModel(
      id: '',
      contactAdmin: contactAdminModel,
      status: AppConstant.waitingStatus,
      totalMember: totalMember,
      totalPrice: 0,
      checkIn: widget.checkIn,
      checkOut: widget.checkOut,
      contact: ContactModel(
          address: '',
          fullName: '',
          id: '',
          lat: 0,
          lng: 0,
          phoneNumber: '',
          userId: ''),
      orderActivities: [],
      user: user,
      receiptImage: '',
    );

    for (PackageRoundModel round in rounds) {
      for (int i = 0; i < round.activities.length; i++) {
        ActivityModel activityModel = round.activities[i];
        OrderActivityModel orderActivity = OrderActivityModel(
          id: activityModel.id,
          activityName: activityModel.activityName,
          price: activityModel.price,
          imageRef: activityModel.imageRef,
          totalPerson: totalMember,
          businessId: activityModel.businessId,
          status: AppConstant.waitingStatus,
          roundId: round.id,
          roundName: round.round,
          dayName: 'วันที่${round.dayType}',
        );
        orderCustomModel.totalPrice += activityModel.price;
        orderCustomModel.orderActivities.add(orderActivity);
      }
    }
    return orderCustomModel;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<CustomPackageBloc, CustomPackageState>(
      builder: (context, state) {
        List<PackageRoundModel> roundModel = state.rounds;
        return BlocBuilder<ContactAdminBloc, ContactAdminState>(
          builder: (context, stateContact) {
            ContactAdminModel contactAdminModel = stateContact.selectContact;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: AppConstant.themeApp,
                title:
                    TextCustom(title: 'ปรับแต่งแพ็คเกจ ${widget.totalPerson}'),
                iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (contactAdminModel.id.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (builder) => const DialogError(
                              message: "กรุณาเลือกผู้ดูแลแพ็คเกจ"),
                        );
                        return;
                      }
                      if (roundModel.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (builder) =>
                              const DialogError(message: "กรุณาเลือกกิจกรรม"),
                        );
                        return;
                      }
                      OrderCustomModel order = summaryBooking(
                          roundModel,
                          widget.totalPerson,
                          stateContact.selectContact,
                          widget.user);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => BookingCustomPackage(
                            orderPackageModel: order,
                            token: widget.user.token,
                            userId: widget.user.userId,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        const TextCustom(title: 'สรุปรายการ'),
                        Icon(
                          Icons.list_alt,
                          color: AppConstant.colorTextHeader,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              backgroundColor: AppConstant.backgroudApp,
              body: SafeArea(
                child: ListView(
                  children: [
                    Card(
                      color: AppConstant.bgTextFormField,
                      child: InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => const ContactAdminList(),
                          ),
                        ),
                        child: Row(
                          children: contactAdminModel.id.isNotEmpty
                              ? [
                                  SizedBox(
                                    width: width * 0.3,
                                    child: ShowImageNetwork(
                                        pathImage:
                                            contactAdminModel.profileRef),
                                  ),
                                  Container(
                                    width: width * 0.6,
                                    height: height * 0.1,
                                    margin: const EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextCustom(
                                          title:
                                              "ชื่อ: ${contactAdminModel.fullName}",
                                        ),
                                        TextCustom(
                                          title:
                                              "เบอร์ติดต่อ: ${contactAdminModel.phoneNumber}",
                                        ),
                                        TextCustom(
                                          title:
                                              "การชำระเงิน: ${contactAdminModel.typePayment}",
                                        ),
                                      ],
                                    ),
                                  ),
                                ]
                              : [
                                  Container(
                                    width: width * 0.6,
                                    height: height * 0.1,
                                    margin: const EdgeInsets.all(8),
                                    child: const Center(
                                      child: TextCustom(
                                        title: "เลือกผู้ดูแลแพ็คเกจ(คลิ๊ก)",
                                      ),
                                    ),
                                  ),
                                ],
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount:
                          widget.checkOut.difference(widget.checkIn).inDays,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextCustom(title: 'วันที่ ${index + 1}'),
                            ),
                            Card(
                              child: Column(
                                children: [
                                  buildCreateOption(
                                    'เพิ่มรอบกิจกรรมวันที่ ${index + 1}',
                                    _addFieldRound,
                                    index + 1,
                                  ),
                                  buildRoundForm(
                                      width, height, roundModel, index + 1),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Container buildRoundForm(double width, double height,
      List<PackageRoundModel> roundModels, int dayType) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: width * .8,
      height: dayType == 1 ? height * 0.74 : height * .45,
      child: roundModels.isNotEmpty
          ? listViewRound(width, height, roundModels, dayType)
          : null,
    );
  }

  Container buildCreateOption(
    String titleOption,
    Function addFieldOption,
    int dayType,
  ) {
    return Container(
      margin: const EdgeInsets.only(left: 35),
      child: Row(
        children: [
          Text(
            titleOption,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppConstant.colorText,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15),
            child: ElevatedButton(
              onPressed: () {
                addFieldOption(UniqueKey().toString(), dayType);
              },
              style: ElevatedButton.styleFrom(
                primary: AppConstant.bgbutton,
              ),
              child: const Icon(
                Icons.add,
              ),
            ),
          )
        ],
      ),
    );
  }

  ListView listViewRound(double width, double height,
      List<PackageRoundModel> roundModels, int dayType) {
    List<PackageRoundModel> roundWithDayType =
        roundModels.where((element) => element.dayType == dayType).toList();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: roundWithDayType.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildDismissible(
              index,
              width,
              height,
              roundWithDayType[index],
            ),
          ],
        );
      },
    );
  }

  Dismissible buildDismissible(
    int index,
    double width,
    double height,
    PackageRoundModel roundModel,
  ) {
    return Dismissible(
      key: Key(roundModel.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        _deleteRound(roundModel);
      },
      background: Container(
        color: Colors.red,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: fieldOption(width, height, roundModel),
    );
  }

  SizedBox fieldOption(
    double width,
    double height,
    PackageRoundModel roundModel,
  ) {
    return SizedBox(
      width: width * 0.8,
      child: Column(
        children: [
          TextFormField(
            initialValue: roundModel.round,
            onChanged: (value) {
              _updateRound(roundModel, value);
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "กรุณากรอกรอบกิจกรรม";
              }
              return null;
            },
            decoration: InputDecoration(
              fillColor: AppConstant.backgroudApp,
              filled: true,
              labelText: 'รอบกิจกรรม เช่น 9.00 น. - 10.00 น.',
              labelStyle: TextStyle(color: Colors.grey[600]),
              prefix: Icon(Icons.add_alarm, color: AppConstant.colorText),
            ),
            style: TextStyle(
              color: AppConstant.colorText,
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(6),
            height: height * 0.32,
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) => SelectActivityCustom(
                    token: widget.user.token,
                    roundId: roundModel.id,
                  ),
                ),
              ),
              child: Card(
                color: AppConstant.themeApp,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: roundModel.activities.length,
                  itemBuilder: (itemBuilder, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        '- ${roundModel.activities[index].activityName}',
                        style: TextStyle(
                          color: AppConstant.colorText,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Divider(
            color: AppConstant.themeApp,
            height: 20,
            thickness: 3.0,
          )
        ],
      ),
    );
  }
}
