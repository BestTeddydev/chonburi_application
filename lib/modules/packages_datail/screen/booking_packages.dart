import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/modules/auth/models/user_model.dart';
import 'package:chonburi_mobileapp/modules/contact_info/bloc/contact_bloc.dart';
import 'package:chonburi_mobileapp/modules/contact_info/models/contact_models.dart';
import 'package:chonburi_mobileapp/modules/contact_info/screen/contact_detail.dart';
import 'package:chonburi_mobileapp/modules/custom_activity/bloc/activity_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/package_tour_models.dart';
import 'package:chonburi_mobileapp/modules/order_package/bloc/order_package_bloc.dart';
import 'package:chonburi_mobileapp/modules/order_package/models/order_activity.dart';
import 'package:chonburi_mobileapp/modules/order_package/models/order_package.dart';
import 'package:chonburi_mobileapp/modules/packages_datail/bloc/package_bloc.dart';
import 'package:chonburi_mobileapp/modules/packages_datail/screen/components/book_card_activity.dart';
import 'package:chonburi_mobileapp/modules/packages_datail/screen/components/brief_list.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/dialog_loading.dart';
import 'package:chonburi_mobileapp/widget/dialog_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingPackages extends StatefulWidget {
  final int totalMember;
  final DateTime checkIn;
  const BookingPackages({
    Key? key,
    required this.totalMember,
    required this.checkIn,
  }) : super(key: key);

  @override
  State<BookingPackages> createState() => _BookingPackagesState();
}

class _BookingPackagesState extends State<BookingPackages> {
  double sumPrice(List<OrderActivityModel> buyActivity) {
    double totalPrice = 0;
    for (OrderActivityModel activity in buyActivity) {
      totalPrice += activity.price;
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ยืนยันคำสั่งซื้อ',
          style: TextStyle(color: AppConstant.colorText),
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(color: AppConstant.colorText),
      ),
      backgroundColor: AppConstant.backgroudApp,
      body: SafeArea(
        child: BlocListener<OrderPackageBloc, OrderPackageState>(
          listener: (context, state) {
            if (state.loading) {
              showDialog(
                context: context,
                builder: (builder) => const DialogLoading(),
              );
            }
            if (state.loaded) {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (builder) => DialogSuccess(message: state.message),
              );
            }
            if (state.hasError) {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (builder) => DialogError(message: state.message),
              );
            }
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ContactDetail(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'สรุปคำสั่งซื้อ',
                    style: TextStyle(
                      color: AppConstant.colorText,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                BlocBuilder<PackageBloc, PackageState>(
                  builder: (context, state) {
                    double totalPrice = sumPrice(state.buyActivity);
                    return SizedBox(
                      width: width * 1,
                      height: height * 0.8,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: state.buyActivity.length,
                              itemBuilder: (context, index) {
                                return BookCardActivity(
                                  context: context,
                                  height: height,
                                  index: index,
                                  state: state,
                                  width: width,
                                );
                              },
                            ),
                          ),
                          Card(
                            color: AppConstant.bgTextFormField,
                            child: BlocBuilder<ActivityBloc, ActivityState>(
                              builder: (context, stateActivity) {
                                return BriefList(
                                  state: state,
                                  stateActivity: stateActivity,
                                  totalPrice: totalPrice,
                                );
                              },
                            ),
                          ),
                          BlocBuilder<ContactBloc, ContactState>(
                            builder: (context, stateContact) {
                              return BlocBuilder<UserBloc, UserState>(
                                builder: (context, stateUser) {
                                  ContactModel contactModel =
                                      stateContact.myContact;
                                  UserModel userModel = stateUser.user;
                                  PackageTourModel packageTourModel =
                                      state.packagesTour;
                                  return buildBookingButton(
                                    width,
                                    contactModel,
                                    context,
                                    totalPrice,
                                    state,
                                    userModel,
                                    packageTourModel,
                                  );
                                },
                              );
                            },
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildBookingButton(
      double width,
      ContactModel contactModel,
      BuildContext context,
      double totalPrice,
      PackageState state,
      UserModel userModel,
      PackageTourModel packageTourModel) {
    return SizedBox(
      width: width * 1,
      child: ElevatedButton(
        onPressed: () {
          if (contactModel.userId.isEmpty) {
            showDialog(
              context: context,
              builder: (builder) => const DialogError(
                message: 'กรุณาเพิ่มข้อมูลการติดต่อ',
              ),
            );
            return;
          }
          OrderPackageModel orderPackageModel = OrderPackageModel(
            id: '',
            package: packageTourModel,
            status: AppConstant.waitingStatus,
            totalMember: widget.totalMember,
            totalPrice:
                (totalPrice + state.packagesTour.price) * widget.totalMember,
            checkIn: widget.checkIn,
            checkOut: state.packagesTour.dayTrips == '1d'
                ? widget.checkIn
                : DateTime(
                    widget.checkIn.year,
                    widget.checkIn.month,
                    widget.checkIn.day + 1,
                  ),
            contact: contactModel,
            orderActivities: state.buyActivity,
            userId: userModel.userId,
            receiptImage: '',
          );
          context.read<OrderPackageBloc>().add(
                CreateOrderPackageEvent(
                  orderPackageModel: orderPackageModel,
                  token: userModel.token,
                ),
              );
          context.read<PackageBloc>().add(
                ClearBuyActivityEvent(),
              );
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(primary: AppConstant.themeApp),
        child: Text(
          'ยืนยันคำสั่งซื้อ',
          style: TextStyle(
            color: AppConstant.colorText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
