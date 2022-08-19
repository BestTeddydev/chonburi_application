import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/location/screen/show_maps.dart';
import 'package:chonburi_mobileapp/modules/partner/bloc/manage_partner_bloc.dart';
import 'package:chonburi_mobileapp/modules/register_partner/models/partner_model.dart';
import 'package:chonburi_mobileapp/widget/dialog_comfirm.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/dialog_success.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PartnerDetail extends StatelessWidget {
  final String token;
  final PartnerModel partner;
  const PartnerDetail({Key? key, required this.partner, required this.token})
      : super(key: key);
  onApprove(BuildContext context) {
    context
        .read<ManagePartnerBloc>()
        .add(ApprovePartnerEvent(token: token, partner: partner));
  }

  onReject(BuildContext context) {
    context.read<ManagePartnerBloc>().add(
          RejectPartnerEvent(token: token, docId: partner.id),
        );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocListener<ManagePartnerBloc, ManagePartnerState>(
      listener: (context, state) {
        if (state.loaded) {
          showDialog(
            context: context,
            builder: (builder) => DialogSuccess(message: state.message),
          );
        }
        if (state.hasError) {
          showDialog(
            context: context,
            builder: (builder) => DialogError(message: state.message),
          );
        }
      },
      child: BlocBuilder<ManagePartnerBloc, ManagePartnerState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'สมัครผู้ประกอบการ',
                style: TextStyle(color: AppConstant.colorText),
              ),
              backgroundColor: AppConstant.themeApp,
              iconTheme: IconThemeData(color: AppConstant.colorText),
            ),
            backgroundColor: AppConstant.backgroudApp,
            body: SafeArea(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                behavior: HitTestBehavior.opaque,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Center(
                              child: Container(
                                width: width * 0.5,
                                height: height * 0.20,
                                margin: EdgeInsets.only(
                                  top: height * 0.08,
                                  bottom: height * 0.08,
                                ),
                                decoration: BoxDecoration(
                                  color: AppConstant.bgTextFormField,
                                  shape: BoxShape.circle,
                                ),
                                child: CircleAvatar(
                                  backgroundColor: AppConstant.bgTextFormField,
                                  radius: 16,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: ShowImageNetwork(
                                        pathImage: partner.profileRef),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    bottom: 6,
                                    right: 7,
                                  ),
                                  width: width * 0.34,
                                  child: TextCustom(title: partner.firstName),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 6),
                                  width: width * 0.34,
                                  child: TextCustom(title: partner.lastName),
                                ),
                              ],
                            ),
                            Container(
                              width: width * 0.7,
                              margin: const EdgeInsets.only(top: 6, bottom: 6),
                              child: TextCustom(title: partner.username),
                            ),
                            Container(
                              width: width * 0.7,
                              margin: const EdgeInsets.only(top: 6, bottom: 6),
                              child: TextCustom(title: partner.phoneNumber),
                            ),
                            Container(
                              width: width * 0.7,
                              margin: const EdgeInsets.only(top: 6, bottom: 6),
                              child: TextCustom(title: partner.address),
                            ),
                            Center(
                                child: ShowMap(
                              lat: partner.lat,
                              lng: partner.lng,
                            )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(16),
                                  width: width * 0.3,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      dialogConfirm(context, onApprove,
                                          'คุณแน่ใจที่จะยืนยันผู้ประกอบการรายนี้ใช่หรืิอไม่');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: AppConstant.bgbutton,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text('ยืนยัน'),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(16),
                                  width: width * 0.3,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      dialogConfirm(
                                        context,
                                        onReject,
                                        'คุณแน่ใจที่จะปฏิเสธผู้ประกอบการรายนี้ใช่หรืิอไม่',
                                      );
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: AppConstant.bgCancelActivity,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text('ปฏิเสธ'),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
