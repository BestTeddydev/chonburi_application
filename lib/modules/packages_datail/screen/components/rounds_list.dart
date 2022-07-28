import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/round_models.dart';
import 'package:chonburi_mobileapp/modules/packages_datail/bloc/package_bloc.dart';
import 'package:chonburi_mobileapp/modules/packages_datail/screen/components/activity_list.dart';
import 'package:flutter/material.dart';

import '../../../manage_package/models/package_tour_models.dart';

class RoundList extends StatelessWidget {
  final List<PackageRoundModel> rounds;
  final PackageState state;
  final double width;
  final PackageTourModel packageTour;
  final BuildContext context;
  final String packageID;
  final int totalPerson;
  const RoundList({
    Key? key,
    required this.context,
    required this.packageTour,
    required this.rounds,
    required this.state,
    required this.width,
    required this.packageID,
    required this.totalPerson,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: rounds.length,
      itemBuilder: (itemBuilder, indexRound) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                rounds[indexRound].round,
                style: TextStyle(
                  color: AppConstant.colorText,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ActivityListComponent(
              context: context,
              packageTour: packageTour,
              rounds: rounds,
              state: state,
              width: width,
              indexRound: indexRound,
              packageID: packageID,
              totalPerson: totalPerson,
            ),
          ],
        );
      },
    );
  }
}
