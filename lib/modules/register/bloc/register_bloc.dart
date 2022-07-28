// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chonburi_mobileapp/modules/register/models/user_register_model.dart';
import 'package:chonburi_mobileapp/utils/services/upload_file_service.dart';
import 'package:chonburi_mobileapp/utils/services/user_service.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState()) {
    on<RegisterUserEvent>(_registerUser);
    on<SelectProfileRefEvent>(_selectProfileRef);
  }

  void _selectProfileRef(
      SelectProfileRefEvent event, Emitter<RegisterState> emitter) {
    emitter(RegisterState(profileRef: event.profileRef));
  }

  void _registerUser(
      RegisterUserEvent event, Emitter<RegisterState> emitter) async {
    try {
      emitter(RegisterState(loading: true));
      if (event.pathName != null) {
        String fileName = await UploadService.singleFile(
            event.pathName!);
        event.userRegisterModel.profileRef = fileName;
      }

      try {
        await UserService.registerUser(event.userRegisterModel);
        emitter(
          RegisterState(
            loading: false,
            hasError: false,
            loaded: true,
            message: 'สมัครสมาชิกเรียบร้อย',
          ),
        );
      } catch (e) {
        emitter(
          RegisterState(
            loading: false,
            hasError: true,
            message: 'มีผู้ใช้งานนี้แล้ว กรุณาลองใหม่อีกครั้ง',
          ),
        );
      }
    } catch (e) {
      emitter(
        RegisterState(
          loading: false,
          hasError: true,
          message: 'อัพโหลดรูปภาพล้มเหลว',
        ),
      );
    }
  }
}
