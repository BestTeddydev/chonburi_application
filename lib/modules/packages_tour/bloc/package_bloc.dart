import 'dart:developer';
import 'dart:io';

import 'package:chonburi_mobileapp/modules/contact_admin/models/contact_admin_model.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/package_tour_models.dart';
import 'package:chonburi_mobileapp/modules/order_package/models/order_activity.dart';
import 'package:chonburi_mobileapp/modules/order_package/models/order_package.dart';
import 'package:chonburi_mobileapp/utils/services/order_package_service.dart';
import 'package:chonburi_mobileapp/utils/services/package_service.dart';
import 'package:chonburi_mobileapp/utils/services/upload_file_service.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'package_event.dart';
part 'package_state.dart';

class PackageBloc extends HydratedBloc<PackageEvent, PackageState> {
  PackageBloc() : super(PackageState()) {
    on<SelectCheckDate>(_selectCheckDate);
    on<TotalMemberEvent>(_selectMember);
    on<FetchPackageEvent>(_fetchPackage);
    on<BuyActivityEvent>(_buyActivity);
    on<CancelActivityEvent>(_cancelActivity);
    on<ClearBuyActivityEvent>(_clearBuyActivity);
    on<FetchsPackagesEvent>(_fetchPackages);
    on<SelectImageSlipPaymentEvent>(selectImageSlip);
    on<CheckoutPackageEvent>(checkoutPackage);
    on<SelectCheckEndDate>(_selectCheckEndDate);
  }

  Future<void> _fetchPackages(
    FetchsPackagesEvent event,
    Emitter<PackageState> emitter,
  ) async {
    try {
      List<PackageTourModel> packages = await PackageService.fetchsPackages();
      emitter(
        PackageState(
          packagesTour: state.packagesTour,
          buyActivity: state.buyActivity,
          isError: false,
          packageId: state.packageId,
          packages: packages,
          totalMember: state.totalMember,
          checkDate: state.checkDate,
          checkEndDate: state.checkEndDate,
        ),
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _fetchPackage(
    FetchPackageEvent event,
    Emitter<PackageState> emitter,
  ) async {
    try {
      PackageTourModel packageModel =
          await PackageService.fetchPackage(event.packageID);
      emitter(
        PackageState(
          packagesTour: packageModel,
          buyActivity: state.buyActivity,
          isError: false,
          packageId: state.packageId,
          packages: state.packages,
          totalMember: state.totalMember,
          checkDate: state.checkDate,
          checkEndDate: state.checkEndDate,
        ),
      );
    } catch (e) {
      log(e.toString());
      emitter(PackageState(
        isError: true,
        packagesTour: state.packagesTour,
        buyActivity: state.buyActivity,
        packageId: state.packageId,
        packages: state.packages,
        totalMember: state.totalMember,
        checkDate: state.checkDate,
        checkEndDate: state.checkEndDate,
      ));
    }
  }

  void _selectCheckDate(SelectCheckDate event, Emitter<PackageState> emitter) {
    // event คือตัวที่รับค่าใหม่มา
    // state คือตัวที่เก็บค่าเก่าไว้
    emitter(
      PackageState(
        packagesTour: state.packagesTour,
        buyActivity: state.buyActivity,
        packageId: state.packageId,
        checkDate: event.date,
        packages: state.packages,
        totalMember: state.totalMember,
        checkEndDate: state.checkEndDate,
      ),
    );
  }

  void _selectCheckEndDate(
      SelectCheckEndDate event, Emitter<PackageState> emitter) {
    // event คือตัวที่รับค่าใหม่มา
    // state คือตัวที่เก็บค่าเก่าไว้
    emitter(
      PackageState(
        packagesTour: state.packagesTour,
        buyActivity: state.buyActivity,
        packageId: state.packageId,
        checkDate: state.checkDate,
        packages: state.packages,
        totalMember: state.totalMember,
        checkEndDate: event.date,
      ),
    );
  }

  void _selectMember(TotalMemberEvent event, Emitter<PackageState> emitter) {
    emitter(
      PackageState(
        packagesTour: state.packagesTour,
        buyActivity: state.buyActivity,
        packageId: state.packageId,
        checkDate: state.checkDate,
        packages: state.packages,
        totalMember: event.member,
        checkEndDate: state.checkEndDate,
      ),
    );
  }

  // cancel not use
  void _buyActivity(BuyActivityEvent event, Emitter<PackageState> emitter) {
    List<OrderActivityModel> allActivities = List.from(state.buyActivity)
      ..add(event.activityModel);
    emitter(
      PackageState(
        packagesTour: state.packagesTour,
        isError: false,
        buyActivity: allActivities,
        packageId: event.packageID,
        packages: state.packages,
        totalMember: state.totalMember,
        checkDate: state.checkDate,
        checkEndDate: state.checkEndDate,
      ),
    );
  }

  // cancel not use
  void _cancelActivity(
      CancelActivityEvent event, Emitter<PackageState> emitter) {
    List<OrderActivityModel> allActivities = List.from(state.buyActivity)
      ..removeWhere(
        (activity) =>
            activity.id == event.activityModel.id &&
            activity.roundId == event.roundId,
      );
    emitter(
      PackageState(
        packageId: allActivities.isNotEmpty ? state.packageId : '',
        isError: false,
        buyActivity: allActivities,
        packagesTour: state.packagesTour,
        packages: state.packages,
        totalMember: state.totalMember,
        checkDate: state.checkDate,
        checkEndDate: state.checkEndDate,
      ),
    );
  }

  // not use
  void _clearBuyActivity(
      ClearBuyActivityEvent event, Emitter<PackageState> emitter) {
    emitter(
      PackageState(
        packagesTour: state.packagesTour,
        isError: false,
        buyActivity: const [],
        packageId: '',
        packages: state.packages,
        totalMember: state.totalMember,
        checkDate: state.checkDate,
        checkEndDate: state.checkEndDate,
      ),
    );
  }

  void selectImageSlip(
    SelectImageSlipPaymentEvent event,
    Emitter<PackageState> emitter,
  ) {
    emitter(
      PackageState(
        packagesTour: state.packagesTour,
        buyActivity: state.buyActivity,
        packageId: state.packageId,
        packages: state.packages,
        totalMember: state.totalMember,
        checkDate: state.checkDate,
        slipPayment: event.image,
        checkEndDate: state.checkEndDate,
      ),
    );
  }

  checkoutPackage(
    CheckoutPackageEvent event,
    Emitter<PackageState> emitter,
  ) async {
    try {
      if (event.slipPayment.path.isNotEmpty) {
        String imageUrl =
            await UploadService.singleFile(event.slipPayment.path);
        event.order.receiptImage = imageUrl;
      }
      await OrderPackageService.createOrderPackage(event.order, event.token);
      emitter(
        PackageState(
          packagesTour: state.packagesTour,
          buyActivity: state.buyActivity,
          packageId: state.packageId,
          packages: state.packages,
          totalMember: state.totalMember,
          checkDate: state.checkDate,
          slipPayment: state.slipPayment,
          loaded: true,
          checkEndDate: state.checkEndDate,
        ),
      );
    } catch (e) {
      emitter(
        PackageState(
          packagesTour: state.packagesTour,
          buyActivity: state.buyActivity,
          packageId: state.packageId,
          packages: state.packages,
          totalMember: state.totalMember,
          checkDate: state.checkDate,
          slipPayment: state.slipPayment,
          isError: true,
          checkEndDate: state.checkEndDate,
        ),
      );
    }
  }

  @override
  PackageState? fromJson(Map<String, dynamic> json) {
    return PackageState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(PackageState state) {
    return state.toMap();
  }
}
