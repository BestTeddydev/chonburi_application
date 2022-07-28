import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/package_tour_models.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/round_models.dart';
import 'package:chonburi_mobileapp/modules/packages_datail/bloc/package_bloc.dart';
import 'package:flutter/material.dart';

import 'rounds_list.dart';

class DayListComponent extends StatelessWidget {
  final PackageState state;
  final double width;
  final PackageTourModel packageTour;
  final BuildContext context;
  final String packageID;
  final int roundLength;
  final int totalPerson;
  const DayListComponent({
    Key? key,
    required this.context,
    required this.packageTour,
    required this.state,
    required this.width,
    required this.packageID,
    required this.roundLength,
    required this.totalPerson,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: roundLength,
      itemBuilder: (itemBuilder, index) {
        List<PackageRoundModel> rounds = packageTour.round
            .where(
              (element) => element.dayType == index + 1,
            )
            .toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                index == 0 ? 'วันแรก' : 'วันที่สอง',
                style: TextStyle(
                  color: AppConstant.colorText,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            RoundList(
              context: context,
              packageTour: packageTour,
              rounds: rounds,
              state: state,
              width: width,
              packageID: packageID,
              totalPerson: totalPerson,
            ),
          ],
        );
      },
    );
  }
}
