import 'package:chonburi_mobileapp/modules/manage_activity/screen/seller/order_detail.dart';
import 'package:chonburi_mobileapp/modules/order_package/bloc/order_package_bloc.dart';
import 'package:chonburi_mobileapp/modules/order_package/models/order_package.dart';
import 'package:chonburi_mobileapp/modules/order_package/screen/components/card_order_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderActivityBusiness extends StatefulWidget {
  final String token;
  final String businessId;
  const OrderActivityBusiness({
    Key? key,
    required this.businessId,
    required this.token,
  }) : super(key: key);

  @override
  State<OrderActivityBusiness> createState() => _OrderActivityBusinessState();
}

class _OrderActivityBusinessState extends State<OrderActivityBusiness> {
  @override
  void initState() {
    context.read<OrderPackageBloc>().add(
          FetchsOrderPackageEvent(
            token: widget.token,
            businessId: widget.businessId,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocBuilder<OrderPackageBloc, OrderPackageState>(
        builder: (context, state) {
          List<OrderPackageModel> orders = state.ordersPackages;
          return ListView(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: orders.length,
                itemBuilder: (itemBuilder, index) {
                  OrderPackageModel order = orders[index];
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => OrderDetail(
                          orderPackageModel: order,
                          businessId: widget.businessId,
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
          );
        },
      ),
    );
  }
}
