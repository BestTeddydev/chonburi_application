import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chonburi_mobileapp/modules/register_partner/models/partner_model.dart';
import 'package:chonburi_mobileapp/utils/services/partner_service.dart';
import 'package:chonburi_mobileapp/utils/services/upload_file_service.dart';
import 'package:equatable/equatable.dart';

part 'register_partner_event.dart';
part 'register_partner_state.dart';

class RegisterPartnerBloc
    extends Bloc<RegisterPartnerEvent, RegisterPartnerState> {
  RegisterPartnerBloc() : super(RegisterPartnerState()) {
    on<SelectProfileRefEvent>(_selectProfileRef);
    on<PartnerRegisterEvent>(_registerPartner);
    on<ShowPasswordEvent>(_showPassword);
  }
  void _selectProfileRef(
      SelectProfileRefEvent event, Emitter<RegisterPartnerState> emitter) {
    emitter(RegisterPartnerState(
        profileRef: event.profileRef, eyePassword: state.eyePassword));
  }

  void _registerPartner(
      PartnerRegisterEvent event, Emitter<RegisterPartnerState> emitter) async {
    try {
      emitter(
          RegisterPartnerState(loading: true, profileRef: state.profileRef));
      if (state.profileRef.path.isNotEmpty) {
        String fileName = await UploadService.singleFile(state.profileRef.path);
        event.partnerModel.profileRef = fileName;
      }

      try {
        await PartnerService.register(event.partnerModel);
        emitter(
          RegisterPartnerState(
            loading: false,
            loaded: true,
            message: 'สมัครสมาชิกเรียบร้อย รอการยืนยัน',
          ),
        );
      } catch (e) {
        emitter(
          RegisterPartnerState(
              loading: false,
              hasError: true,
              message: 'มีผู้ใช้งานนี้แล้ว กรุณาลองใหม่อีกครั้ง',
              profileRef: state.profileRef),
        );
      }
    } catch (e) {
      emitter(
        RegisterPartnerState(
          loading: false,
          hasError: true,
          message: 'อัพโหลดรูปภาพล้มเหลว',
        ),
      );
    }
  }

  void _showPassword(
      ShowPasswordEvent event, Emitter<RegisterPartnerState> emitter) {
    emitter(RegisterPartnerState(
        profileRef: state.profileRef, eyePassword: !state.eyePassword));
  }
}
