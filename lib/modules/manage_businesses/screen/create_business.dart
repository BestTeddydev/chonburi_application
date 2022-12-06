import 'dart:io';

import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/businesses/bloc/businesses_bloc.dart';
import 'package:chonburi_mobileapp/modules/businesses/models/business_models.dart';
import 'package:chonburi_mobileapp/modules/location/bloc/location_bloc.dart';
import 'package:chonburi_mobileapp/modules/location/screen/show_maps.dart';
import 'package:chonburi_mobileapp/widget/dialog_camera.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/dialog_loading.dart';
import 'package:chonburi_mobileapp/widget/dialog_success.dart';
import 'package:chonburi_mobileapp/widget/form_field_phone.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:chonburi_mobileapp/widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateBusiness extends StatefulWidget {
  final String typeBusiness;
  final String sellerId;
  final String token;
  const CreateBusiness({
    Key? key,
    required this.typeBusiness,
    required this.sellerId,
    required this.token,
  }) : super(key: key);

  @override
  State<CreateBusiness> createState() => _CreateBusinessState();
}

class _CreateBusinessState extends State<CreateBusiness> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController paymentController = TextEditingController();
  TextEditingController ratePriceController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  List<DropdownMenuItem<String>> itemsTypePayment = [
    'พร้อมเพย์',
    'ธนาคารไทยพานิชย์',
    'ธนาคารกสิกรไทย',
    'ธนาคารกรุงไทย',
    'ธนาคารกรุงเทพ',
    'ธนาคารทหารไทยธนชาต',
    'ธนาคารออมสิน',
    'ธนาคารกรุงศรี',
    'ธนาคารธ.ก.ส.'
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Text(
          value,
          style: TextStyle(
            color: AppConstant.colorText,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }).toList();

  onSelectImageCover(File image) {
    context
        .read<BusinessesBloc>()
        .add(SelectImageCoverEvent(coverImage: image));
  }

  onSelectImageQrcode(File image) {
    context
        .read<BusinessesBloc>()
        .add(SelectImageQRcodeEvent(qrcodeImage: image));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppConstant.backgroudApp,
      appBar: AppBar(
        title: const TextCustom(
          title: 'สร้างธุรกิจ',
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
      ),
      body: BlocListener<BusinessesBloc, BusinessesState>(
        listener: (context, state) {
          if (state.loading) {
            showDialog(
              context: context,
              builder: (builder) => const DialogLoading(),
            );
          }
          if (state.loaded) {
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
        child: BlocBuilder<BusinessesBloc, BusinessesState>(
          builder: (context, state) {
            return SafeArea(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                behavior: HitTestBehavior.opaque,
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () =>
                                dialogCamera(context, onSelectImageCover),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 14),
                              width: width * 1,
                              height: height * 0.2,
                              decoration: BoxDecoration(
                                color: AppConstant.bgTextFormField,
                              ),
                              child: state.coverImage.path.isNotEmpty
                                  ? Image.file(
                                      state.coverImage,
                                      fit: BoxFit.fill,
                                    )
                                  : Center(
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        color: AppConstant.colorText,
                                        size: 40,
                                      ),
                                    ),
                            ),
                          ),
                          Container(
                            width: width * 0.7,
                            margin: const EdgeInsets.all(8.0),
                            child: TextFormFieldCustom(
                              controller: businessNameController,
                              labelText: 'ชื่อธุรกิจ',
                              requiredText: 'กรุณากรอกชื่อธุรกิจ',
                            ),
                          ),
                          Container(
                            width: width * 0.7,
                            margin: const EdgeInsets.all(8.0),
                            child: TextFormPhone(
                              controller: phoneController,
                              labelText: 'เบอร์โทร',
                              requiredText: 'กรุณากรอกเบอร์โทร',
                            ),
                          ),
                          Container(
                            width: width * 0.7,
                            margin: const EdgeInsets.all(8.0),
                            child: TextFormFieldCustom(
                              controller: ratePriceController,
                              labelText: 'ราคาเฉลี่ยของสินค้า',
                              requiredText: 'กรุณากรอกราคาเฉลี่ยของสินค้า',
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            width: width * 0.7,
                            decoration: BoxDecoration(
                              color: AppConstant.bgTextFormField,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                style: TextStyle(
                                    color: AppConstant.bgTextFormField),
                                value: state.typePayment,
                                items: itemsTypePayment,
                                onChanged: (String? value) {
                                  if (value != null) {
                                    context.read<BusinessesBloc>().add(
                                          ChangeTypePaymentBusinessEvent(
                                            value: value,
                                          ),
                                        );
                                  }
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: width * 0.7,
                            margin: const EdgeInsets.all(8.0),
                            child: TextFormFieldCustom(
                              controller: paymentController,
                              labelText: 'เลขบัญชี / พร้อมเพย์',
                              requiredText: 'กรุณากรอกเลขบัญชี / พร้อมเพย์',
                            ),
                          ),
                          Container(
                            width: width * 0.7,
                            margin: const EdgeInsets.all(8.0),
                            child: TextFormFieldCustom(
                              controller: addressController,
                              labelText: 'ที่ตั้งธุรกิจ',
                              requiredText: 'กรุณากรอกที่ตั้งธุรกิจ',
                              maxLines: 3,
                            ),
                          ),
                          const Center(
                            child: ShowMap(),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 14),
                            width: width * 0.66,
                            height: height * 0.2,
                            decoration: BoxDecoration(
                              color: AppConstant.bgTextFormField,
                            ),
                            child: state.qrcodeRef.path.isNotEmpty
                                ? Image.file(
                                    state.qrcodeRef,
                                    fit: BoxFit.fill,
                                  )
                                : Center(
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      color: AppConstant.colorText,
                                      size: 40,
                                    ),
                                  ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            width: width * 0.4,
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () =>
                                  dialogCamera(context, onSelectImageQrcode),
                              style: ElevatedButton.styleFrom(
                                primary: AppConstant.bgTextFormField,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.add_a_photo_outlined,
                                      color: AppConstant.colorText,
                                      size: 15,
                                    ),
                                  ),
                                  Text(
                                    'เพิ่มรูปภาพ QR Code',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: AppConstant.colorText,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      BlocBuilder<LocationBloc, LocationState>(
                        builder: (context, locationState) {
                          return ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  state.coverImage.path.isNotEmpty &&
                                  state.qrcodeRef.path.isNotEmpty) {
                                BusinessModel business = BusinessModel(
                                  id: '',
                                  businessName: businessNameController.text,
                                  sellerId: widget.sellerId,
                                  address: addressController.text,
                                  latitude: locationState.curLat,
                                  longitude: locationState.curLng,
                                  statusOpen: true,
                                  ratingCount: 0,
                                  point: 0,
                                  paymentNumber: paymentController.text,
                                  qrcodeRef: '',
                                  phoneNumber: phoneController.text,
                                  imageRef: '',
                                  ratePrice:
                                      double.parse(ratePriceController.text),
                                  typeBusiness: widget.typeBusiness,
                                  typePayment: state.typePayment,
                                  introduce: '',
                                );
                                context.read<BusinessesBloc>().add(
                                      CreateBusinessEvent(
                                        token: widget.token,
                                        business: business,
                                      ),
                                    );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (builder) => const DialogError(
                                    message: 'กรุณากรอกข้อมูลและแนบรูปให้ครบ',
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: AppConstant.themeApp,
                            ),
                            child: const TextCustom(
                              title: 'สร้างธุรกิจ',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
