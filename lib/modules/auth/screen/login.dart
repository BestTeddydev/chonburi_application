import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/constants/asset_path.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/modules/register/screen/register.dart';
import 'package:chonburi_mobileapp/modules/register_partner/screen/partner_register.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/dialog_loading.dart';
import 'package:chonburi_mobileapp/widget/text_form_field.dart';
import 'package:chonburi_mobileapp/widget/text_form_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenLogin extends StatefulWidget {
  const AuthenLogin({Key? key}) : super(key: key);

  @override
  State<AuthenLogin> createState() => _AuthenLoginState();
}

class _AuthenLoginState extends State<AuthenLogin> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  onPressedEye() {
    context.read<UserBloc>().add(PressPasswordEvent());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppConstant.backgroudApp,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Form(
            key: _formKey,
            child: BlocListener<UserBloc, UserState>(
              listener: (context, stateListener) {
                if (stateListener.loading) {
                  showDialog(
                    context: context,
                    builder: (builder) => const DialogLoading(),
                  );
                }

                if (stateListener.user.token.isNotEmpty) {
                  Navigator.pop(context);
                  if (stateListener.user.roles == 'buyer') {
                    Navigator.pop(context);
                    return;
                  }
                  if (stateListener.user.roles == 'admin') {
                    Navigator.pushNamed(context, AppConstant.aminService);
                    return;
                  }
                  if (stateListener.user.roles == 'seller') {
                    Navigator.pushNamed(context, AppConstant.sellerService);
                    return;
                  }
                }
                if (stateListener.hasError) {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (builder) => const DialogError(
                      message: 'เข้าสู่ระบบล้มเหลว กรุณาลองใหม่อีกครั้ง',
                    ),
                  );
                }
              },
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppConstantAssets.bgLogin),
                        fit: BoxFit.cover,
                        opacity: 160,
                        colorFilter: ColorFilter.mode(
                          AppConstant.blurLogin,
                          BlendMode.colorBurn,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    bottom: 8,
                                  ),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(10),
                                width: width * 0.8,
                                height: 50,
                                child: TextFormFieldCustom(
                                  controller: userName,
                                  labelText: 'อีเมล,ชื่อผู้ใช้งาน',
                                  requiredText: 'กรุณากรอกอีเมล,ชื่อผู้ใช้งาน',
                                  background:
                                      const Color.fromRGBO(255, 255, 255, 0.5),
                                  fontColor: AppConstant.colorTextLogin,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(10),
                                width: width * 0.8,
                                height: 50,
                                child: TextFormPassword(
                                  controller: password,
                                  labelText: 'รหัสผ่าน',
                                  requiredText: 'กรุณากรอกรหัสผ่าน',
                                  eyesPassword: state.eyesPassword,
                                  onPressedEye: onPressedEye,
                                  background:
                                      const Color.fromRGBO(255, 255, 255, 0.5),
                                  fontColor: AppConstant.colorTextLogin,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<UserBloc>().add(
                                            UserLoginEvent(
                                              username: userName.text,
                                              password: password.text,
                                            ),
                                          );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                    side: const BorderSide(
                                      color: Color.fromRGBO(255, 255, 255, 0.8),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    shadowColor: Colors.white,
                                  ),
                                  child: Text(
                                    'เข้าสู่ระบบ',
                                    style: TextStyle(
                                      color: AppConstant.colorTextLogin,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'ยังไม่มีบัญชีผู้ใช้งาน? ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        // fullscreenDialog: true,
                                        builder: (builder) =>
                                            const RegisterUser(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'สร้างบัญชี',
                                    style: TextStyle(
                                      color: Color.fromRGBO(22, 79, 121, 1),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (builder) =>
                                        const PartnerRegister(),
                                  ),
                                );
                              },
                              child: RichText(
                                text: const TextSpan(
                                  text: 'เข้าร่วมกับเรา? ',
                                  children: [
                                    TextSpan(
                                      text: ' สมัครที่นี่',
                                      style: TextStyle(
                                        color: Color.fromRGBO(22, 79, 121, 1),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
