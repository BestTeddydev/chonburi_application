import 'package:chonburi_mobileapp/modules/custom_package/models/order_custom.dart';
import 'package:chonburi_mobileapp/modules/manage_activity/screen/seller/order_detail.dart';
import 'package:chonburi_mobileapp/modules/order_package/bloc/order_package_bloc.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderActivityBusiness extends StatefulWidget {
  final String token;
  final String placeId;
  const OrderActivityBusiness({
    Key? key,
    required this.placeId,
    required this.token,
  }) : super(key: key);

  @override
  State<OrderActivityBusiness> createState() => _OrderActivityBusinessState();
}

class _OrderActivityBusinessState extends State<OrderActivityBusiness> {
  @override
  void initState() {
    context.read<OrderPackageBloc>().add(
          FetchsOrderCustomPackageEvent(
            token: widget.token,
            businessId: widget.placeId,
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
          List<OrderCustomModel> orders = state.orderCustomPackages;
          return ListView(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: orders.length,
                itemBuilder: (itemBuilder, index) {
                  OrderCustomModel order = orders[index];
                  return InkWell(
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => OrderDetail(
                                orderPackageModel: order,
                                businessId: widget.placeId,
                                token: widget.token,
                              ),
                            ),
                          ),
                      child: Card(
                        margin: const EdgeInsets.all(5),
                        child: TextCustom(
                          title: 'โดยคุณ ${order.contact.fullName}',
                          maxLine: 2,
                        ),
                      ));
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
