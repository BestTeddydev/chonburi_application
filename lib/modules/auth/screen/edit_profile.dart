// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/models/user_model.dart';
import 'package:chonburi_mobileapp/utils/services/user_service.dart';
import 'package:chonburi_mobileapp/widget/dialog_comfirm.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_bloc.dart';

class EditProfile extends StatefulWidget {
  final UserModel user;
  const EditProfile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    usernameController.text = widget.user.username;
    firstNameController.text = widget.user.firstName;
    lastNameController.text = widget.user.lastName;
  }

  Future<void> onDeleteAccount(BuildContext context) async {
    Navigator.pop(context);
    await UserService.deleteAccount(widget.user.userId, widget.user.token);
    UserModel userModel = UserModel(
      userId: '',
      username: '',
      firstName: '',
      lastName: '',
      roles: 'guest',
      token: '',
      tokenDevice: widget.user.tokenDevice,
      profileRef: '',
    );
    context.read<UserBloc>().add(
          UserLogoutEvent(userModel: userModel),
        );
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/buyerService',
      (Route<dynamic> route) => false,
    );
  }

  Future<void> onChangeProfile(BuildContext context) async {
    try {
      Navigator.pop(context);
      await UserService.deleteAccount(widget.user.userId, widget.user.token);
      UserModel user = UserModel(
        userId: widget.user.userId,
        username: usernameController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        roles: widget.user.roles,
        token: widget.user.token,
        tokenDevice: widget.user.tokenDevice,
        profileRef: widget.user.profileRef,
      );
      context.read<UserBloc>().add(
            ChangeProfileEvent(
              user: user,
              password: passwordController.text.isNotEmpty
                  ? passwordController.text
                  : null,
            ),
          );

    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('แก้ไขข้อมูลส่วนตัว'),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
      ),
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width * 0.21,
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ShowImageNetwork(
                    pathImage: widget.user.profileRef,
                  ),
                ),
                Container(
                  width: width * 0.8,
                  margin: const EdgeInsets.all(10),
                  child: TextFormFieldCustom(
                    controller: usernameController,
                    labelText: "ชื่อผู้ใช้งาน",
                    requiredText: "",
                  ),
                ),
                Container(
                  width: width * 0.8,
                  margin: const EdgeInsets.all(10),
                  child: TextFormFieldCustom(
                    controller: firstNameController,
                    labelText: "ชื่อ",
                    requiredText: "",
                  ),
                ),
                Container(
                  width: width * 0.8,
                  margin: const EdgeInsets.all(10),
                  child: TextFormFieldCustom(
                    controller: lastNameController,
                    labelText: "นามสกุล",
                    requiredText: "",
                  ),
                ),
                Container(
                  width: width * 0.8,
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: AppConstant.bgTextFormField,
                      filled: true,
                      labelStyle: TextStyle(color: AppConstant.colorText),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppConstant.bgTextFormField),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppConstant.bgTextFormField),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: TextStyle(
                      color: AppConstant.colorText,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(6),
                      child: ElevatedButton(
                        onPressed: () {
                          dialogConfirm(
                            context,
                            onChangeProfile,
                            "คุณยืนยันที่จะแก้ไขข้อมูลใช่หรือไม่",
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppConstant.bgbutton,
                        ),
                        child: const Text("แก้ไขข้อมูล"),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(6),
                      child: ElevatedButton(
                        onPressed: () {
                          dialogConfirm(
                            context,
                            onDeleteAccount,
                            "คุณแน่ใจที่จะลบบัญชีใช่หรือไม่",
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppConstant.bgCancelActivity,
                        ),
                        child: const Text("ลบบัญชี"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
