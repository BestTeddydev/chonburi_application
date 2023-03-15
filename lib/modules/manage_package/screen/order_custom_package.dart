import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/custom_package/models/order_custom.dart';
import 'package:chonburi_mobileapp/modules/home/screen/order_detail.dart';
import 'package:chonburi_mobileapp/modules/manage_package/screen/order_detail_admin.dart';
import 'package:chonburi_mobileapp/modules/order_package/bloc/order_package_bloc.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class OrderCustomPackage extends StatefulWidget {
  final String token;
  const OrderCustomPackage({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<OrderCustomPackage> createState() => _OrderCustomPackageState();
}

class _OrderCustomPackageState extends State<OrderCustomPackage> {
  @override
  void initState() {
    context.read<OrderPackageBloc>().add(
          FetchsOrderCustomPackageEvent(
            token: widget.token,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const TextCustom(title: 'คัสตอมแพ็คเกจ'),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(
          color: AppConstant.colorTextHeader,
        ),
      ),
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
                    onTap: () {
                      if (order.receiptImage.isEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => OrderDetailAdmin(
                              orderPackageModel: order,
                              token: widget.token,
                            ),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => OrderCustomDetail(
                              order: order,
                            ),
                          ),
                        );
                      }
                    },
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: AppConstant.bgOrderCard,
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              left: 20,
                              bottom: 25,
                            ),
                            width: width * 0.4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    bottom: 8,
                                  ),
                                  child: Text(
                                    'ราคา : ${order.totalPrice} ฿',
                                    style: TextStyle(
                                      color: AppConstant.colorText,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Text(
                                  order.status,
                                  style: TextStyle(
                                    color:
                                        AppConstant.statusColor[order.status],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextCustom(
                                        title: DateFormat('dd/MM/yyyy')
                                            .format(order.checkIn),
                                        fontSize: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
