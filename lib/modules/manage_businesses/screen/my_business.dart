import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/businesses/bloc/businesses_bloc.dart';
import 'package:chonburi_mobileapp/modules/businesses/models/business_models.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/screen/home_business.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/screen/main_activity.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/screen/main_food.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/screen/main_product.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/screen/main_room.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/screen/setting_business.dart';
import 'package:chonburi_mobileapp/modules/notification/screen/notification.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBusinesses extends StatefulWidget {
  final String token, typeBusiness;
  const MyBusinesses({
    Key? key,
    required this.token,
    required this.typeBusiness,
  }) : super(key: key);

  @override
  State<MyBusinesses> createState() => _MyBusinessesState();
}

class _MyBusinessesState extends State<MyBusinesses> {
  @override
  void initState() {
    context.read<BusinessesBloc>().add(
          FetchBusinessOwnerEvent(
            token: widget.token,
            typeBusiness: widget.typeBusiness,
          ),
        );
    super.initState();
  }

  onSelectBusiness(BusinessModel businessModel, String token) {
    if (widget.typeBusiness == "restaurant") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (builder) => HomeBusiness(
            businessId: businessModel.id,
            itemTabs: [
              MainFood(
                businessId: businessModel.id,
                token: token,
              ),
              MainActivity(businessId: businessModel.id),
              MyNotification(recipientId: businessModel.id),
              SettingBusiness(
                token: token,
              ),
            ],
          ),
        ),
      );
    }
    if (widget.typeBusiness == "otop") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (builder) => HomeBusiness(
            businessId: businessModel.id,
            itemTabs: [
              MainProduct(
                businessId: businessModel.id,
                token: token,
              ),
              MainActivity(businessId: businessModel.id),
              MyNotification(recipientId: businessModel.id),
              SettingBusiness(
                token: token,
              ),
            ],
          ),
        ),
      );
    }

    if (widget.typeBusiness == "resort") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (builder) => HomeBusiness(
            businessId: businessModel.id,
            itemTabs: [
              MainRoom(
                businessId: businessModel.id,
                token: token,
              ),
              MainActivity(businessId: businessModel.id),
              MyNotification(recipientId: businessModel.id),
              SettingBusiness(
                token: token,
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.backgroudApp,
      body: BlocBuilder<BusinessesBloc, BusinessesState>(
        builder: (context, state) {
          return state.businesses.isNotEmpty
              ? SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: state.businesses.length,
                    itemBuilder: (itemBuilder, index) {
                      BusinessModel businessModel = state.businesses[index];
                      return InkWell(
                        onTap: () =>
                            onSelectBusiness(businessModel, widget.token),
                        child: Card(
                          margin: const EdgeInsets.only(top: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              top: 12,
                              bottom: 12,
                              right: 16,
                            ),
                            child: Text(
                              state.businesses[index].businessName,
                              style: TextStyle(
                                color: AppConstant.colorText,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      TextCustom(
                        title: 'ไม่มีข้อมูล',
                        fontSize: 16,
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
