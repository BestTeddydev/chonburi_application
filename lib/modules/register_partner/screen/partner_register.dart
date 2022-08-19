import 'dart:io';

import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/modules/location/bloc/location_bloc.dart';
import 'package:chonburi_mobileapp/modules/location/screen/show_maps.dart';
import 'package:chonburi_mobileapp/modules/register_partner/bloc/register_partner_bloc.dart';
import 'package:chonburi_mobileapp/modules/register_partner/models/partner_model.dart';
import 'package:chonburi_mobileapp/widget/dialog_camera.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/dialog_loading.dart';
import 'package:chonburi_mobileapp/widget/dialog_success.dart';
import 'package:chonburi_mobileapp/widget/form_field_phone.dart';
import 'package:chonburi_mobileapp/widget/text_form_field.dart';
import 'package:chonburi_mobileapp/widget/text_form_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PartnerRegister extends StatefulWidget {
  const PartnerRegister({Key? key}) : super(key: key);

  @override
  State<PartnerRegister> createState() => _PartnerRegisterState();
}

class _PartnerRegisterState extends State<PartnerRegister> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firtNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  onSetProfile(File image) async {
    context
        .read<RegisterPartnerBloc>()
        .add(SelectProfileRefEvent(profileRef: image));
  }

  onShowPassword() {
    context.read<RegisterPartnerBloc>().add(ShowPasswordEvent());
  }

  onSubmit(double lat, double lng, String tokenDevice) {
    PartnerModel partnerModel = PartnerModel(
      id: '',
      firstName: firtNameController.text,
      lastName: lastNameController.text,
      username: usernameController.text,
      phoneNumber: phoneController.text,
      password: passwordController.text,
      role: '',
      profileRef: '',
      lat: lat,
      lng: lng,
      address: addressController.text,
      isAccept: false,
      tokenDevice: tokenDevice,
    );
    context.read<RegisterPartnerBloc>().add(
          PartnerRegisterEvent(
            partnerModel: partnerModel,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocListener<RegisterPartnerBloc, RegisterPartnerState>(
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
      child: BlocBuilder<RegisterPartnerBloc, RegisterPartnerState>(
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Center(
                                child: InkWell(
                                  onTap: () =>
                                      dialogCamera(context, onSetProfile),
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Container(
                                        width: width * 0.5,
                                        height: height * 0.18,
                                        margin: EdgeInsets.only(
                                          top: height * 0.08,
                                          bottom: height * 0.08,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppConstant.bgTextFormField,
                                          shape: BoxShape.circle,
                                        ),
                                        child: state.profileRef.path.isNotEmpty
                                            ? CircleAvatar(
                                                backgroundColor:
                                                    AppConstant.bgTextFormField,
                                                radius: 16,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(60),
                                                  child: Image.file(
                                                    state.profileRef,
                                                    fit: BoxFit.fill,
                                                    width: width * 0.32,
                                                    height: height * 0.2,
                                                  ),
                                                ),
                                              )
                                            : Center(
                                                child: Text(
                                                  'เลือกรูปภาพ',
                                                  style: TextStyle(
                                                    color:
                                                        AppConstant.colorText,
                                                  ),
                                                ),
                                              ),
                                      ),
                                      Container(
                                        width: 34,
                                        height: 34,
                                        margin: EdgeInsets.only(
                                          top: height * 0.13,
                                          left: width * 0.21,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppConstant.bgbutton,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.camera_alt_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
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
                                    child: TextFormFieldCustom(
                                      controller: firtNameController,
                                      labelText: 'ชื่อ',
                                      requiredText: 'กรุณากรอกชื่อ',
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 6),
                                    width: width * 0.34,
                                    child: TextFormFieldCustom(
                                      controller: lastNameController,
                                      labelText: 'นามสกุล',
                                      requiredText: 'กรุณากรอกนามสกุล',
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: width * 0.7,
                                margin:
                                    const EdgeInsets.only(top: 6, bottom: 6),
                                child: TextFormFieldCustom(
                                  controller: usernameController,
                                  labelText: 'ชื่อผู้ใข้งาน',
                                  requiredText: 'กรุณากรอกชื่อผู้ใข้งาน',
                                ),
                              ),
                              Container(
                                width: width * 0.7,
                                margin:
                                    const EdgeInsets.only(top: 6, bottom: 6),
                                child: TextFormPassword(
                                  eyesPassword: state.eyePassword,
                                  controller: passwordController,
                                  onPressedEye: onShowPassword,
                                  labelText: 'รหัสผ่าน',
                                  requiredText: 'กรุณากรอกรหัสผ่าน',
                                ),
                              ),
                              Container(
                                width: width * 0.7,
                                margin:
                                    const EdgeInsets.only(top: 6, bottom: 6),
                                child: TextFormPhone(
                                  controller: phoneController,
                                  labelText: 'เบอร์โทร',
                                  requiredText: 'กรุณากรอกเบอร์โทร',
                                ),
                              ),
                              Container(
                                width: width * 0.7,
                                margin:
                                    const EdgeInsets.only(top: 6, bottom: 6),
                                child: TextFormFieldCustom(
                                  controller: addressController,
                                  labelText: 'ที่อยู่',
                                  requiredText: 'กรุณากรอกที่อยู่',
                                  maxLines: 3,
                                ),
                              ),
                              const Center(child: ShowMap()),
                              BlocBuilder<LocationBloc, LocationState>(
                                builder: (context, stateLocation) {
                                  return Container(
                                    margin: const EdgeInsets.all(16),
                                    width: width * 0.5,
                                    child: BlocBuilder<UserBloc, UserState>(
                                      builder: (context, stateUser) {
                                        return ElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                    .validate() &&
                                                state.profileRef.path
                                                    .isNotEmpty) {
                                              onSubmit(
                                                stateLocation.curLat,
                                                stateLocation.curLng,
                                                stateUser.user.tokenDevice,
                                              );
                                            } else {
                                              showDialog(
                                                context: context,
                                                builder: (builder) =>
                                                    const DialogError(
                                                  message:
                                                      'กรุณากรอกข้อมูลและแนบรูปให้ครบ',
                                                ),
                                              );
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: AppConstant.bgbutton,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text('สมัครสมาชิก'),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: RichText(
                          text: TextSpan(
                            text: 'มีบัญชีผู้ใช้อยู่แล้ว? ',
                            style: TextStyle(color: AppConstant.colorText),
                            children: [
                              TextSpan(
                                text: 'ล็อกอิน',
                                style: TextStyle(
                                  color: AppConstant.colorTextHeader,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
