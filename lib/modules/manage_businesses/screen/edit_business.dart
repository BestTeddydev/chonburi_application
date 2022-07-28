import 'dart:io';

import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/businesses/models/business_models.dart';
import 'package:chonburi_mobileapp/modules/home/screen/home_seller.dart';
import 'package:chonburi_mobileapp/modules/location/bloc/location_bloc.dart';
import 'package:chonburi_mobileapp/modules/location/screen/show_maps.dart';
import 'package:chonburi_mobileapp/widget/dialog_camera.dart';
import 'package:chonburi_mobileapp/widget/dialog_comfirm.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/dialog_loading.dart';
import 'package:chonburi_mobileapp/widget/dialog_success.dart';
import 'package:chonburi_mobileapp/widget/form_field_phone.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:chonburi_mobileapp/widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../businesses/bloc/businesses_bloc.dart';

class EditBusiness extends StatefulWidget {
  final BusinessModel business;
  final String token;
  const EditBusiness({
    Key? key,
    required this.token,
    required this.business,
  }) : super(key: key);

  @override
  State<EditBusiness> createState() => _EditBusinessState();
}

class _EditBusinessState extends State<EditBusiness> {
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

  onDeleteBusiness(BuildContext context) {
    Navigator.pop(context);
    context.read<BusinessesBloc>().add(
          DeleteBusinessEvent(token: widget.token, docId: widget.business.id),
        );
  }

  @override
  void initState() {
    businessNameController.text = widget.business.businessName;
    phoneController.text = widget.business.phoneNumber;
    paymentController.text = widget.business.paymentNumber;
    ratePriceController.text = widget.business.ratePrice.toString();
    addressController.text = widget.business.address;
    context.read<BusinessesBloc>().add(
          ChangeTypePaymentBusinessEvent(value: widget.business.typePayment),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppConstant.backgroudApp,
      appBar: AppBar(
        title: const TextCustom(
          title: 'แก้ไขข้อมูลธุรกิจ',
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
            BusinessModel businessModel = state.businessModel;
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
                                  : ShowImageNetwork(
                                      pathImage: businessModel.imageRef,
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
                                  color: AppConstant.bgTextFormField,
                                ),
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
                                : ShowImageNetwork(
                                    pathImage: businessModel.qrcodeRef,
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
                          Container(
                            width: width * 0.4,
                            margin: const EdgeInsets.all(10),
                            child: ElevatedButton(
                              onPressed: () {
                                dialogConfirm(
                                  context,
                                  onDeleteBusiness,
                                  'คุณแน่ใจแล้วที่จะลบข้อมูลธุรกิจแห่งนี้ ใช่หรือไม่',
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (builder) =>
                                        const HomeSellerService(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: AppConstant.bgCancelActivity,
                              ),
                              child: const TextCustom(
                                title: 'ลบข้อมูลธุรกิจ',
                                fontSize: 16,
                                fontColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      BlocBuilder<LocationBloc, LocationState>(
                        builder: (context, locationState) {
                          return ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                BusinessModel business = BusinessModel(
                                  id: businessModel.id,
                                  businessName: businessNameController.text,
                                  sellerId: businessModel.sellerId,
                                  address: addressController.text,
                                  latitude: locationState.curLat,
                                  longitude: locationState.curLng,
                                  statusOpen: businessModel.statusOpen,
                                  ratingCount: businessModel.ratingCount,
                                  point: businessModel.point,
                                  paymentNumber: paymentController.text,
                                  qrcodeRef: businessModel.qrcodeRef,
                                  phoneNumber: phoneController.text,
                                  imageRef: businessModel.imageRef,
                                  ratePrice:
                                      double.parse(ratePriceController.text),
                                  typeBusiness: businessModel.typeBusiness,
                                  typePayment: state.typePayment,
                                  introduce: businessModel.introduce,
                                );
                                context.read<BusinessesBloc>().add(
                                      UpdateBusinessEvent(
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
                              title: 'แก้ไขข้อมูลธุรกิจ',
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
