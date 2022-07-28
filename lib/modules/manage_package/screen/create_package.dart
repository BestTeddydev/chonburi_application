import 'dart:io';

import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_package/bloc/manage_package_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/package_tour_models.dart';
import 'package:chonburi_mobileapp/modules/manage_package/screen/select_day.dart';
import 'package:chonburi_mobileapp/widget/dialog_camera.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/dialog_loading.dart';
import 'package:chonburi_mobileapp/widget/dialog_success.dart';
import 'package:chonburi_mobileapp/widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePackage extends StatefulWidget {
  final String token;
  const CreatePackage({Key? key, required this.token}) : super(key: key);

  @override
  State<CreatePackage> createState() => _CreatePackageState();
}

class _CreatePackageState extends State<CreatePackage> {
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
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'สร้างข้อมูลแพ็คเกจ',
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
              child: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                behavior: HitTestBehavior.opaque,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => dialogCamera(context, onSetImagePackage),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          width: width * 1,
                          height: height * 0.2,
                          decoration: BoxDecoration(
                            color: AppConstant.bgTextFormField,
                          ),
                          child: state.packageImage.path.isNotEmpty
                              ? Image.file(
                                  state.packageImage,
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
                                      AppConstant
                                          .day[state.dayForrents[index]]!,
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
                            style:
                                TextStyle(color: AppConstant.bgTextFormField),
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
                            style:
                                TextStyle(color: AppConstant.bgTextFormField),
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
                      InkWell(
                        onTap: () => dialogCamera(context, onSetImagePayment),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          width: width * 0.66,
                          height: height * 0.2,
                          decoration: BoxDecoration(
                            color: AppConstant.bgTextFormField,
                          ),
                          child: state.imagePayment.path.isNotEmpty
                              ? Image.file(
                                  state.imagePayment,
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
                        margin: const EdgeInsets.all(6),
                        width: width * 0.7,
                        child: TextFormFieldCustom(
                          controller: markController,
                          labelText: 'หมายเหตุ',
                          requiredText: '',
                          maxLines: 2,
                        ),
                      ),
                      BlocBuilder<UserBloc, UserState>(
                        builder: (context, stateUser) {
                          return SizedBox(
                            width: width * 1,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                    state.dayForrents.isNotEmpty &&
                                    state.dayType != 'zero') {
                                  if (state.packageImage.path.isEmpty ||
                                      state.imagePayment.path.isEmpty) {
                                    showDialog(
                                      context: context,
                                      builder: (builder) => const DialogError(
                                        message: 'กรุณาแนบรูปภาพ',
                                      ),
                                    );
                                    return;
                                  }
                                  PackageTourModel packageTourModel =
                                      PackageTourModel(
                                    id: '',
                                    packageName: packageNameController.text,
                                    contactPhone: contactPhoneController.text,
                                    contactName: contactNameController.text,
                                    dayTrips: state.dayType,
                                    round: [],
                                    dayForrent: state.dayForrents,
                                    packageImage: '',
                                    mark: markController.text,
                                    createdBy: '',
                                    price: double.parse(priceController.text),
                                    introduce: '',
                                    imagePayment: '',
                                    accountPayment: accountController.text,
                                    typePayment: state.typePayment,
                                    description: descriptionController.text,
                                  );
                                  context.read<ManagePackageBloc>().add(
                                        CreatePackageEvent(
                                          packageTourModel: packageTourModel,
                                          token: stateUser.user.token,
                                        ),
                                      );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (builder) => const DialogError(
                                      message: 'กรุณากรอกข้อมูลให้ครบ',
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: AppConstant.bgbutton,
                              ),
                              child: const Text('สร้างแพ็คเกจ'),
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
