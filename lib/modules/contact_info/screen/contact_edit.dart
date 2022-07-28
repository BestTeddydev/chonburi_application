import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/contact_info/bloc/contact_bloc.dart';
import 'package:chonburi_mobileapp/modules/contact_info/models/contact_models.dart';
import 'package:chonburi_mobileapp/modules/location/bloc/location_bloc.dart';
import 'package:chonburi_mobileapp/modules/location/screen/show_maps.dart';
import 'package:chonburi_mobileapp/widget/dialog_comfirm.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/dialog_loading.dart';
import 'package:chonburi_mobileapp/widget/dialog_success.dart';
import 'package:chonburi_mobileapp/widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditContact extends StatefulWidget {
  final String userId;
  final String token;
  final ContactModel contact;
  const EditContact({
    Key? key,
    required this.token,
    required this.userId,
    required this.contact,
  }) : super(key: key);

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fullNameController.text = widget.contact.fullName;
    phoneController.text = widget.contact.phoneNumber;
    addressController.text = widget.contact.address;
  }

  void onDeleteContact(BuildContext context) {
    context.read<ContactBloc>().add(
          DeleteContactEvent(
            contactModel: widget.contact,
            token: widget.token,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocListener<ContactBloc, ContactState>(
      listener: (context, state) {
        if (state.loading) {
          showDialog(
            context: context,
            builder: (builder) => const DialogLoading(),
          );
        }
        if (state.loaded) {
          Navigator.pop(context);
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (builder) => DialogSuccess(message: state.message),
          );
        }
        if (state.hasError) {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (builder) => DialogError(message: state.message),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'แก้ไขข้อมูลติดต่อ',
            style: TextStyle(color: AppConstant.colorText),
          ),
          backgroundColor: AppConstant.themeApp,
          iconTheme: IconThemeData(
            color: AppConstant.colorText,
          ),
        ),
        backgroundColor: AppConstant.backgroudApp,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: BlocBuilder<ContactBloc, ContactState>(
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 16,
                                    left: width * 0.08,
                                    bottom: 12,
                                  ),
                                  child: Text(
                                    'ช่องทางติดต่อ',
                                    style: TextStyle(
                                      color: AppConstant.colorText,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.all(8),
                              width: width * 0.8,
                              height: 40,
                              child: TextFormFieldCustom(
                                controller: fullNameController,
                                requiredText: 'กรุณากรอกชื่อ - นามสกุล',
                                labelText: 'ชื่อ - นามสกุล',
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(8),
                              width: width * 0.8,
                              height: 40,
                              child: TextFormFieldCustom(
                                controller: phoneController,
                                requiredText: 'กรุณากรอกเบอร์โทรศัพท์',
                                labelText: 'เบอร์โทรศัพท์',
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                    left: width * 0.08,
                                    bottom: 10,
                                  ),
                                  child: Text(
                                    'ที่อยู่',
                                    style: TextStyle(
                                      color: AppConstant.colorText,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              width: width * 0.8,
                              height: height * 0.1,
                              child: TextFormFieldCustom(
                                controller: addressController,
                                requiredText: 'กรุณากรอกรายละเอียดที่อยู่',
                                labelText: 'รายละเอียดที่อยู่',
                              ),
                            ),
                            Center(
                              child: ShowMap(
                                lat: widget.contact.lat,
                                lng: widget.contact.lng,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    BlocBuilder<LocationBloc, LocationState>(
                      builder: (contextLocation, stateLocation) {
                        return Column(
                          children: [
                            ElevatedButton(
                              onPressed: () => dialogConfirm(
                                  context,
                                  onDeleteContact,
                                  'คุณแน่ใจแล้วที่จะลบข้อมูลติดต่อนี้ใช่หรือไม่'),
                              style: ElevatedButton.styleFrom(
                                primary: AppConstant.bgCancelActivity,
                              ),
                              child: const Text(
                                'ลบข้อมูล',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 1,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    ContactModel contactModel = ContactModel(
                                      userId: widget.userId,
                                      fullName: fullNameController.text,
                                      address: addressController.text,
                                      phoneNumber: phoneController.text,
                                      lat: stateLocation.curLat,
                                      lng: stateLocation.curLng,
                                      id: widget.contact.id,
                                    );
                                    context.read<ContactBloc>().add(
                                          UpdateContactEvent(
                                            contactModel: contactModel,
                                            token: widget.token,
                                          ),
                                        );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: AppConstant.themeApp,
                                ),
                                child: Text(
                                  'แก้ไขข้อมูลติดต่อ',
                                  style: TextStyle(
                                    color: AppConstant.colorText,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
