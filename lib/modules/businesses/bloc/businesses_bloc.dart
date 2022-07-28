import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chonburi_mobileapp/modules/businesses/models/business_models.dart';
import 'package:chonburi_mobileapp/utils/services/business_service.dart';
import 'package:chonburi_mobileapp/utils/services/upload_file_service.dart';
import 'package:equatable/equatable.dart';

part 'businesses_event.dart';
part 'businesses_state.dart';

class BusinessesBloc extends Bloc<BusinessesEvent, BusinessesState> {
  BusinessesBloc() : super(BusinessesState()) {
    on<FetchBusinesses>(_fetchBusiness);
    on<FetchBusinessByIdEvent>(_fetchBusinesById);
    on<FetchBusinessOwnerEvent>(_fetchBusinessOwner);
    on<CreateBusinessEvent>(_createBusiness);
    on<UpdateBusinessEvent>(_updateBusiness);
    on<DeleteBusinessEvent>(_deleteBusiness);
    on<SelectImageCoverEvent>(_selectImageCover);
    on<SelectImageQRcodeEvent>(_selectImageQrcode);
    on<ChangeTypePaymentBusinessEvent>(_changeTypePayment);
  }
  void _fetchBusiness(
      FetchBusinesses event, Emitter<BusinessesState> emitter) async {
    try {
      emitter(BusinessesState(loading: true));
      List<BusinessModel> businesses = await BusinessService.fetchBusiness(
        event.businessName,
        event.typeBusiness,
      );
      emitter(
        BusinessesState(loading: false, loaded: true, businesses: businesses),
      );
    } catch (e) {
      emitter(BusinessesState(loading: false, hasError: true));
    }
  }

  void _fetchBusinessOwner(
      FetchBusinessOwnerEvent event, Emitter<BusinessesState> emitter) async {
    try {
      emitter(
        BusinessesState(
          loading: true,
          businesses: state.businesses,
          businessModel: state.businessModel,
        ),
      );
      List<BusinessModel> businesses = await BusinessService.fetchBusinessOwner(
        event.token,
        event.typeBusiness,
      );
      emitter(
        BusinessesState(
          loading: false,
          loaded: true,
          businesses: businesses,
          businessModel: state.businessModel,
        ),
      );
    } catch (e) {
      emitter(
        BusinessesState(
          loading: false,
          hasError: true,
          businesses: state.businesses,
          businessModel: state.businessModel,
        ),
      );
    }
  }

  //  show business when edit activity
  void _fetchBusinesById(
      FetchBusinessByIdEvent event, Emitter<BusinessesState> emitter) async {
    try {
      emitter(
        BusinessesState(
          loading: true,
          businesses: state.businesses,
          businessModel: state.businessModel,
        ),
      );
      BusinessModel business =
          await BusinessService.fetchBusinessById(event.docId);
      emitter(
        BusinessesState(
          loading: false,
          loaded: true,
          businesses: state.businesses,
          businessModel: business,
        ),
      );
    } catch (e) {
      emitter(BusinessesState(loading: false, hasError: true));
    }
  }

  void _createBusiness(
      CreateBusinessEvent event, Emitter<BusinessesState> emitter) async {
    try {
      emitter(
        BusinessesState(
          loading: true,
          businesses: state.businesses,
          qrcodeRef: state.qrcodeRef,
          coverImage: state.coverImage,
          typePayment: state.typePayment,
        ),
      );
      if (state.coverImage.path.isNotEmpty) {
        String imageUrl = await UploadService.singleFile(state.coverImage.path);
        event.business.imageRef = imageUrl;
      }
      if (state.qrcodeRef.path.isNotEmpty) {
        String imageQRUrl =
            await UploadService.singleFile(state.qrcodeRef.path);
        event.business.qrcodeRef = imageQRUrl;
      }

      await BusinessService.createBusiness(event.token, event.business);
      emitter(
        BusinessesState(
          businesses: state.businesses,
          qrcodeRef: state.qrcodeRef,
          coverImage: state.coverImage,
          loaded: true,
          message: 'บันทึกข้อมูลเรียบร้อย',
          typePayment: state.typePayment,
          loading: false,
        ),
      );
    } catch (e) {
      emitter(
        BusinessesState(
          businesses: state.businesses,
          qrcodeRef: state.qrcodeRef,
          coverImage: state.coverImage,
          message: 'บันทึกข้อมูลล้มเหลว',
          typePayment: state.typePayment,
          hasError: true,
          loading: false,
        ),
      );
    }
  }

  void _updateBusiness(
      UpdateBusinessEvent event, Emitter<BusinessesState> emitter) async {
    try {
      emitter(
        BusinessesState(
          loading: true,
          businesses: state.businesses,
          qrcodeRef: state.qrcodeRef,
          coverImage: state.coverImage,
          typePayment: state.typePayment,
        ),
      );
      if (state.coverImage.path.isNotEmpty) {
        String imageUrl = await UploadService.singleFile(state.coverImage.path);
        event.business.imageRef = imageUrl;
      }
      if (state.qrcodeRef.path.isNotEmpty) {
        String imageQRUrl =
            await UploadService.singleFile(state.qrcodeRef.path);
        event.business.qrcodeRef = imageQRUrl;
      }
      await BusinessService.updateBusiness(event.token, event.business);
      int index = List<BusinessModel>.from(state.businesses).indexWhere(
        (element) => element.id == event.business.id,
      );
      List<BusinessModel> businesses =
          List<BusinessModel>.from(state.businesses)
            ..removeWhere(
              (element) => element.id == event.business.id,
            );
      businesses.insert(index, event.business);
      emitter(
        BusinessesState(
          businesses: businesses,
          qrcodeRef: state.qrcodeRef,
          coverImage: state.coverImage,
          businessModel: event.business,
          message: 'แก้ไขข้อมูลเรียบร้อย',
          loaded: true,
          loading: false,
        ),
      );
    } catch (e) {
      log(e.toString());
      emitter(
        BusinessesState(
          businesses: state.businesses,
          qrcodeRef: state.qrcodeRef,
          coverImage: state.coverImage,
          businessModel: state.businessModel,
          hasError: true,
          loading: false,
          message: 'แก้ไขข้อมูลล้มเหลว',
        ),
      );
    }
  }

  void _deleteBusiness(
      DeleteBusinessEvent event, Emitter<BusinessesState> emitter) async {
    try {
      emitter(
        BusinessesState(
          businesses: state.businesses,
          qrcodeRef: state.qrcodeRef,
          coverImage: state.coverImage,
          businessModel: state.businessModel,
          loading: true,
        ),
      );
      await BusinessService.deleteBusiness(event.token, event.docId);
      List<BusinessModel> businesses = List.from(state.businesses)
        ..removeWhere(
          (element) => element.id == event.docId,
        );
      emitter(
        BusinessesState(
          businesses: businesses,
          loading: false,
          loaded: true,
          message: "ลบข้อมูลธุรกิจเรียบร้อย",
        ),
      );
    } catch (e) {
      emitter(
        BusinessesState(
            businesses: state.businesses,
            qrcodeRef: state.qrcodeRef,
            coverImage: state.coverImage,
            businessModel: state.businessModel,
            message: 'ลบข้อมูลล้มเหลว'),
      );
    }
  }

  void _selectImageCover(
      SelectImageCoverEvent event, Emitter<BusinessesState> emitter) {
    emitter(
      BusinessesState(
        businesses: state.businesses,
        qrcodeRef: state.qrcodeRef,
        coverImage: event.coverImage,
        businessModel: state.businessModel,
        typePayment: state.typePayment,
      ),
    );
  }

  void _selectImageQrcode(
      SelectImageQRcodeEvent event, Emitter<BusinessesState> emitter) {
    emitter(
      BusinessesState(
        businesses: state.businesses,
        qrcodeRef: event.qrcodeImage,
        coverImage: state.coverImage,
        businessModel: state.businessModel,
        typePayment: state.typePayment,
      ),
    );
  }

  void _changeTypePayment(
      ChangeTypePaymentBusinessEvent event, Emitter<BusinessesState> emitter) {
    emitter(
      BusinessesState(
        businesses: state.businesses,
        qrcodeRef: state.qrcodeRef,
        coverImage: state.coverImage,
        businessModel: state.businessModel,
        typePayment: event.value,
      ),
    );
  }
}
