import 'package:chonburi_mobileapp/modules/order_package/bloc/order_package_bloc.dart';
import 'package:chonburi_mobileapp/modules/order_package/models/order_package.dart';
import 'package:chonburi_mobileapp/modules/order_package/screen/components/card_order_package.dart';
import 'package:chonburi_mobileapp/modules/order_package/screen/order_detail_buyer.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPackageAdmin extends StatefulWidget {
  final String token;

  const OrderPackageAdmin({Key? key, required this.token}) : super(key: key);

  @override
  State<OrderPackageAdmin> createState() => _OrderPackageAdminState();
}

class _OrderPackageAdminState extends State<OrderPackageAdmin> {
  @override
  void initState() {
    context.read<OrderPackageBloc>().add(
          FetchsOrderPackageEvent(
            token: widget.token,
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
                          builder: (builder) => OrderDetailBuyer(
                              orderPackageModel: order, token: widget.token),),
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
