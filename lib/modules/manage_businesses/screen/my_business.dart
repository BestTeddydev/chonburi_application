import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/businesses/bloc/businesses_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/screen/home_business.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.backgroudApp,
      body: BlocBuilder<BusinessesBloc, BusinessesState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: state.businesses.length,
              itemBuilder: (itemBuilder, index) {
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => HomeBusiness(
                        businessId: state.businesses[index].id,
                      ),
                    ),
                  ),
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
          );
        },
      ),
    );
  }
}
