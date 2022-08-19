import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/partner/bloc/manage_partner_bloc.dart';
import 'package:chonburi_mobileapp/modules/partner/screen/partner_detail.dart';
import 'package:chonburi_mobileapp/modules/register_partner/models/partner_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PartnerList extends StatefulWidget {
  final String token;
  final bool status;
  const PartnerList({
    Key? key,
    required this.status,
    required this.token,
  }) : super(key: key);

  @override
  State<PartnerList> createState() => _PartnerListState();
}

class _PartnerListState extends State<PartnerList> {
  @override
  void initState() {
    context
        .read<ManagePartnerBloc>()
        .add(FetchPartnerEvent(token: widget.token, status: widget.status));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.backgroudApp,
      body: BlocBuilder<ManagePartnerBloc, ManagePartnerState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: state.partners.length,
              itemBuilder: (itemBuilder, index) {
                PartnerModel partner = state.partners[index];
                return InkWell(
                  onTap: () {
                    if (widget.status == false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => PartnerDetail(partner: partner,token: widget.token,),
                        ),
                      );
                    }
                  },
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
                        '${partner.firstName} ${partner.lastName}',
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
