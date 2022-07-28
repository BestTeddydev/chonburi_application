// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/register/bloc/register_bloc.dart';
import 'package:chonburi_mobileapp/modules/register/models/user_register_model.dart';
import 'package:chonburi_mobileapp/widget/dialog_camera.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/dialog_loading.dart';
import 'package:chonburi_mobileapp/widget/dialog_success.dart';
import 'package:chonburi_mobileapp/widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({Key? key}) : super(key: key);

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firtNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  onSetProfile(File image) async {
    context.read<RegisterBloc>().add(SelectProfileRefEvent(profileRef: image));
  }

  onSubmit(String? pathName) {
    if (_formKey.currentState!.validate()) {
      UserRegisterModel userRegisterModel = UserRegisterModel(
        username: usernameController.text,
        firstName: firtNameController.text,
        lastName: lastNameController.text,
        password: passwordController.text,
        roles: 'buyer',
        tokenDevice: '',
        profileRef: '',
      );
      context.read<RegisterBloc>().add(
            RegisterUserEvent(
              pathName: pathName,
              userRegisterModel: userRegisterModel,
            ),
          );
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocListener<RegisterBloc, RegisterState>(
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
            builder: (builder) => DialogSuccess(
              message: state.message,
            ),
          );
        }
        if (state.hasError) {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (builder) => DialogError(
              message: state.message,
            ),
          );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'สมัครสมาชิก',
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
                                    height: 40,
                                    child: TextFormFieldCustom(
                                      controller: firtNameController,
                                      labelText: 'ชื่อ',
                                      requiredText: 'กรุณากรอกชื่อ',
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 6),
                                    width: width * 0.34,
                                    height: 40,
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
                                height: 40,
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
                                height: 40,
                                margin:
                                    const EdgeInsets.only(top: 6, bottom: 6),
                                child: TextFormFieldCustom(
                                  controller: passwordController,
                                  labelText: 'รหัสผ่าน',
                                  requiredText: 'กรุณากรอกรหัสผ่าน',
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(16),
                                width: width * 0.5,
                                child: ElevatedButton(
                                  onPressed: () => onSubmit(
                                    state.profileRef.path.isNotEmpty
                                        ? state.profileRef.path
                                        : null,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: AppConstant.bgbutton,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text('สมัครสมาชิก'),
                                ),
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
