import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/home/services/buyer_service.dart';
import 'package:chonburi_mobileapp/modules/order_package/bloc/order_package_bloc.dart';
import 'package:chonburi_mobileapp/modules/order_package/models/order_package.dart';
import 'package:chonburi_mobileapp/modules/order_package/screen/components/card_order_package.dart';
import 'package:chonburi_mobileapp/modules/order_package/screen/order_detail_buyer.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackingPackage extends StatefulWidget {
  final String token, userId;
  const TrackingPackage({
    Key? key,
    required this.token,
    required this.userId,
  }) : super(key: key);

  @override
  State<TrackingPackage> createState() => _TrackingPackageState();
}

class _TrackingPackageState extends State<TrackingPackage> {
  @override
  void initState() {
    context.read<OrderPackageBloc>().add(FetchsOrderPackageEvent(
          token: widget.token,
          id: widget.userId,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<OrderPackageBloc, OrderPackageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const TextCustom(title: 'สถานะแพ็คเกจของฉัน'),
            backgroundColor: AppConstant.themeApp,
            iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
            actions: [
              IconButton(
                onPressed: () => {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => BuyerService(
                        token: widget.token,
                      ),
                    ),
                    (route) => false,
                  )
                },
                icon: const Icon(Icons.home),
              )
            ],
          ),
          backgroundColor: AppConstant.backgroudApp,
          body: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.ordersPackages.length,
                  itemBuilder: (itemBuilder, index) {
                    OrderPackageModel order = state.ordersPackages[index];
                    return InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => OrderDetailBuyer(
                            orderPackageModel: order,
                            token: widget.token,
                          ),
                        ),
                      ),
                      child: CardOrderPackage(
                        width: width,
                        height: height,
                        order: order,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
