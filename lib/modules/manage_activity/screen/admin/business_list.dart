import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/businesses/bloc/businesses_bloc.dart';
import 'package:chonburi_mobileapp/modules/businesses/models/business_name_models.dart';
import 'package:chonburi_mobileapp/modules/manage_activity/bloc/manage_activity_bloc.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusinessList extends StatefulWidget {
  final BusinessNameModel businessNameModel;
  const BusinessList({Key? key, required this.businessNameModel})
      : super(key: key);

  @override
  State<BusinessList> createState() => _BusinessListState();
}

class _BusinessListState extends State<BusinessList> {
  @override
  void initState() {
    context
        .read<ManageActivityBloc>()
        .add(SelectBusinessEvent(businessNameModel: widget.businessNameModel));
    context.read<BusinessesBloc>().add(
          const FetchBusinesses(
            businessName: '',
            typeBusiness: '',
          ),
        );

    super.initState();
  }

  Map<String, Color> typeBusinessColor = {
    "otop": AppConstant.colorText,
    "resort": AppConstant.bgCancelActivity,
    "restaurant": AppConstant.bgChooseActivity,
  };

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ธุรกิจทั้งหมด',
          style: TextStyle(color: AppConstant.colorTextHeader),
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
      ),
      body: BlocBuilder<BusinessesBloc, BusinessesState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: BlocBuilder<ManageActivityBloc, ManageActivityState>(
              builder: (context, stateActivity) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: state.businesses.length,
                  itemBuilder: (itemBuilder, index) {
                    bool isMatch = state.businesses[index].id ==
                        stateActivity.business.businessId;
                    return InkWell(
                      onTap: () {
                        if (!isMatch) {
                          BusinessNameModel businessNameModel =
                              BusinessNameModel(
                            businessId: state.businesses[index].id,
                            businessName: state.businesses[index].businessName,
                          );
                          context.read<ManageActivityBloc>().add(
                                SelectBusinessEvent(
                                  businessNameModel: businessNameModel,
                                ),
                              );
                        }
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(12),
                              width: width * 0.2,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                                child: ShowImageNetwork(
                                  pathImage: state.businesses[index].imageRef,
                                  boxFit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(8),
                                  width: width * 0.4,
                                  child: Text(
                                    state.businesses[index].businessName,
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: AppConstant.colorText,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: width * 0.2,
                                      decoration: BoxDecoration(
                                        color: typeBusinessColor[state
                                            .businesses[index].typeBusiness],
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(6),
                                          bottomRight: Radius.circular(6),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Center(
                                          child: Text(
                                            state
                                                .businesses[index].typeBusiness,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      isMatch
                                          ? Icons.check_circle_outline
                                          : null,
                                      color: AppConstant.bgChooseActivity,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
