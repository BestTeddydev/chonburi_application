import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/packages_tour/bloc/package_bloc.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookCardActivity extends StatelessWidget {
  final double width;
  final double height;
  final PackageState state;
  final int index;
  final BuildContext context;
  const BookCardActivity({
    Key? key,
    required this.context,
    required this.height,
    required this.index,
    required this.state,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width * 0.26,
            height: height * .1,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  child: ShowImageNetwork(
                    pathImage: state.buyActivity[index].imageRef.first,
                    boxFit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppConstant.bgTextFormField,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                  ),
                  child: Text(
                    state.buyActivity[index].dayName,
                    style: TextStyle(
                      color: AppConstant.colorText,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            width: width * 0.4,
            child: Text(
              state.buyActivity[index].activityName,
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
            width: width * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${state.buyActivity[index].price} ฿',
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppConstant.colorText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.read<PackageBloc>().add(
                          CancelActivityEvent(
                            activityModel: state.buyActivity[index],
                            roundId: state.buyActivity[index].roundId,
                          ),
                        );
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    size: 18,
                    color: AppConstant.bgCancelActivity,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
