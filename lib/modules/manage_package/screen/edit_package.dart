import 'dart:io';

import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/manage_package/bloc/manage_package_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/package_tour_models.dart';
import 'package:chonburi_mobileapp/modules/manage_package/screen/select_day.dart';
import 'package:chonburi_mobileapp/widget/dialog_camera.dart';
import 'package:chonburi_mobileapp/widget/dialog_comfirm.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/dialog_loading.dart';
import 'package:chonburi_mobileapp/widget/dialog_success.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPackage extends StatefulWidget {
  final PackageTourModel packageModel;
  final String token;
  const EditPackage({
    Key? key,
    required this.packageModel,
    required this.token,
  }) : super(key: key);

  @override
  State<EditPackage> createState() => _EditPackageState();
}

class _EditPackageState extends State<EditPackage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController packageNameController = TextEditingController();
  TextEditingController contactPhoneController = TextEditingController();
  TextEditingController contactNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController markController = TextEditingController();
  TextEditingController accountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  onSetImagePackage(File image) {
    context.read<ManagePackageBloc>().add(SelectImageEvent(image: image));
  }

  onSetImagePayment(File image) {
    context
        .read<ManagePackageBloc>()
        .add(SelectImagePaymentEvent(image: image));
  }

  onDeletePackage(BuildContext context) {
    context.read<ManagePackageBloc>().add(
          DeletePackageEvent(
            token: widget.token,
            docId: widget.packageModel.id,
          ),
        );
    Navigator.pop(context);
  }

  List<DropdownMenuItem<String>> items =
      ['zero', '1d', '2d1n'].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          AppConstant.tripsType[value]!,
          style: TextStyle(
            color: AppConstant.colorText,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }).toList();
  List<DropdownMenuItem<String>> itemsTypePayment = [
    'พร้อมเพย์',
    'ไทยพานิชย์',
    'กสิกรไทย',
    'กรุงไทย',
    'กรุงเทพ',
    'ทีทีบี',
    'ออมสิน',
    'กรุงศรี',
    'ธ.ก.ส.'
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
  @override
  void initState() {
    packageNameController.text = widget.packageModel.packageName;
    contactNameController.text = widget.packageModel.contactName;
    priceController.text = widget.packageModel.price.toString();
    contactPhoneController.text = widget.packageModel.contactPhone;
    markController.text = widget.packageModel.mark;
    accountController.text = widget.packageModel.accountPayment;
    descriptionController.text = widget.packageModel.description;
    context.read<ManagePackageBloc>().add(
          SetDataPackageEvent(
            tripsType: widget.packageModel.dayTrips,
            dayForrents: widget.packageModel.dayForrent,
            typePayment: widget.packageModel.typePayment,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Package Tour',
          style: TextStyle(color: AppConstant.colorTextHeader),
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(
          color: AppConstant.colorTextHeader,
        ),
      ),
      body: BlocListener<ManagePackageBloc, ManagePackageState>(
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
        child: BlocBuilder<ManagePackageBloc, ManagePackageState>(
          builder: (context, state) {
            return SingleChildScrollView(
                child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    width: width * 1,
                    height: height * 0.2,
                    child: InkWell(
                      onTap: () => dialogCamera(context, onSetImagePackage),
                      child: state.packageImage.path.isEmpty
                          ? ShowImageNetwork(
                              pathImage: widget.packageModel.packageImage,
                            )
                          : Image.file(
                              state.packageImage,
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(6),
                    width: width * 0.7,
                    child: TextFormFieldCustom(
                      controller: packageNameController,
                      labelText: 'ชื่อแพ็คเกจ',
                      requiredText: 'กรุณากรอกชื่อแพ็คเกจ',
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(6),
                    width: width * 0.7,
                    child: TextFormFieldCustom(
                      controller: descriptionController,
                      labelText: 'รายละเอียดแนะนำแพ็คเกจ',
                      requiredText: '',
                      maxLines: 6,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(6),
                    width: width * 0.7,
                    child: TextFormFieldCustom(
                      controller: priceController,
                      labelText: 'ราคา',
                      requiredText: 'กรุณากรอกราคา',
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(6),
                    width: width * 0.7,
                    child: TextFormFieldCustom(
                      controller: contactNameController,
                      labelText: 'ชื่อผู้ดูแล',
                      requiredText: 'กรุณากรอกชื่อผู้ชื่อผู้ดูแล',
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(6),
                    width: width * 0.7,
                    child: TextFormFieldCustom(
                      controller: contactPhoneController,
                      labelText: 'เบอร์ผู้ดูแล',
                      requiredText: 'กรุณากรอกเบอร์ผู้ชื่อผู้ดูแล',
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => const SelectDay(),
                      ),
                    ),
                    child: SizedBox(
                      width: width * 0.72,
                      child: Card(
                        color: AppConstant.bgTextFormField,
                        margin: const EdgeInsets.all(6),
                        child: state.dayForrents.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'เลือกวันที่เปิดขายแพ็คเกจ เช่น ส. อา.',
                                  style: TextStyle(
                                    color: AppConstant.colorText,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: state.dayForrents.length,
                                itemBuilder: (itemBuilder, index) => Text(
                                  AppConstant.day[state.dayForrents[index]]!,
                                  style: TextStyle(
                                    color: AppConstant.colorText,
                                  ),
                                ),
                              ),
                      ),
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
                        style: TextStyle(color: AppConstant.bgTextFormField),
                        value: state.dayType,
                        items: items,
                        onChanged: (String? value) {
                          if (value != null) {
                            context.read<ManagePackageBloc>().add(
                                  ChangeDayTripType(
                                    dayType: value,
                                  ),
                                );
                          }
                        },
                      ),
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
                        style: TextStyle(color: AppConstant.bgTextFormField),
                        value: state.typePayment,
                        items: itemsTypePayment,
                        onChanged: (String? value) {
                          if (value != null) {
                            context.read<ManagePackageBloc>().add(
                                ChangeTypePaymentEvent(typePayment: value));
                          }
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(6),
                    width: width * 0.7,
                    child: TextFormFieldCustom(
                      controller: accountController,
                      labelText: 'เลขบัญชี / พร้อมเพย์',
                      requiredText: 'กรุณากรอกเลขบัญชี / พร้อมเพย์',
                    ),
                  ),
                  SizedBox(
                    width: width * 0.66,
                    height: height * 0.2,
                    child: InkWell(
                      onTap: () => dialogCamera(context, onSetImagePayment),
                      child: state.imagePayment.path.isEmpty
                          ? ShowImageNetwork(
                              pathImage: widget.packageModel.imagePayment,
                            )
                          : Image.file(
                              state.imagePayment,
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(6),
                    width: width * 0.7,
                    child: TextFormFieldCustom(
                      controller: markController,
                      labelText: 'หมายเหตุ',
                      requiredText: '',
                      maxLines: 3,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => dialogConfirm(
                      context,
                      onDeletePackage,
                      'คุณแน่ใจแล้วที่จะลบแพ็คเกจนี้ใช่หรือไม่',
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: AppConstant.bgCancelActivity,
                    ),
                    child: const Text('ลบแพ็คเกจ'),
                  ),
                  SizedBox(
                    width: width * 1,
                    child: ElevatedButton(
                      onPressed: () {
                        PackageTourModel packageTourModel = PackageTourModel(
                          id: widget.packageModel.id,
                          packageName: packageNameController.text,
                          contactPhone: contactPhoneController.text,
                          contactName: contactNameController.text,
                          dayTrips: state.dayType,
                          round: [],
                          dayForrent: state.dayForrents,
                          packageImage: widget.packageModel.packageImage,
                          mark: markController.text,
                          createdBy: '',
                          price: double.parse(priceController.text),
                          introduce: '',
                          imagePayment: widget.packageModel.imagePayment,
                          typePayment: state.typePayment,
                          accountPayment: accountController.text,
                          description: descriptionController.text,
                        );
                        context.read<ManagePackageBloc>().add(
                              UpdatePackageEvent(
                                packageTourModel: packageTourModel,
                                token: widget.token,
                              ),
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: AppConstant.bgbutton,
                      ),
                      child: const Text('แก้ไขข้อมูล'),
                    ),
                  ),
                ],
              ),
            ));
          },
        ),
      ),
    );
  }
}
