import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chonburi_mobileapp/modules/businesses/models/business_name_models.dart';
import 'package:chonburi_mobileapp/modules/order_package/models/order_activity.dart';
import 'package:chonburi_mobileapp/utils/services/activity_service.dart';
import 'package:chonburi_mobileapp/utils/services/order_package_service.dart';
import 'package:chonburi_mobileapp/utils/services/upload_file_service.dart';
import 'package:equatable/equatable.dart';

import '../models/activity_model.dart';

part 'manage_activity_event.dart';
part 'manage_activity_state.dart';

class ManageActivityBloc
    extends Bloc<ManageActivityEvent, ManageActivityState> {
  ManageActivityBloc() : super(ManageActivityState()) {
    on<FetchActivityManage>(_fetchActivities);
    on<UpdateActivityManage>(_updateActivity);
    on<CreateActivityManage>(_createActivity);
    on<DeleteActivityManage>(_deleteActivity);
    on<SelectBusinessEvent>(_selectBusiness);
    on<SelectImageEvent>(_selectImage);
    on<FetchActivityBusiness>(_fetchActivitiesSellert);
    on<PartnerApproveActivityEvent>(_approveActivity);
    on<PartnerRejectActivityEvent>(_rejectActivity);
    on<RemoveImageEvent>(_removeImage);
    on<SetImageRefForEdit>(_setImageRefForEdit);
    on<SetMyOrderActivityEvent>(_setMyOrderActivity);
    on<ActionOrderActivityEvent>(_actionOrderActivity);
  }
  void _fetchActivities(
      FetchActivityManage event, Emitter<ManageActivityState> emitter) async {
    try {
      emitter(ManageActivityState(loading: true));
      List<ActivityModel> activities =
          await ActivityService.fetchActivityAdmin(event.token, event.accepted);
      emitter(ManageActivityState(
        loading: false,
        loaded: true,
        activities: activities,
      ));
    } catch (e) {
      emitter(ManageActivityState(
        loading: false,
        hasError: true,
        message: 'ระบบเกิดเหตุขัดข้อง ขออภัยในความไม่สะดวก',
      ));
    }
  }

  void _fetchActivitiesSellert(
      FetchActivityBusiness event, Emitter<ManageActivityState> emitter) async {
    try {
      emitter(ManageActivityState(loading: true));
      List<ActivityModel> activities =
          await ActivityService.fetchActivityBusiness(
        event.token,
        event.businessId,
        event.accepted,
      );
      emitter(ManageActivityState(
        loading: false,
        loaded: true,
        activities: activities,
      ));
    } catch (e) {
      emitter(ManageActivityState(
        loading: false,
        hasError: true,
        message: 'ระบบเกิดเหตุขัดข้อง ขออภัยในความไม่สะดวก',
      ));
    }
  }

  void _createActivity(
      CreateActivityManage event, Emitter<ManageActivityState> emitter) async {
    try {
      emitter(ManageActivityState(
        loading: true,
        activities: state.activities,
        imageRef: state.imageRef,
      ));
      if (event.activityModel.imageRef.isNotEmpty) {
        List<String> imageRef = await UploadService.multipleFile(
          event.activityModel.imageRef,
        );
        event.activityModel.imageRef = imageRef;
      }

      try {
        ActivityModel newActivity = await ActivityService.createActivity(
            event.activityModel, event.token);
        emitter(ManageActivityState(
          loading: false,
          loaded: true,
          activities: List.from(state.activities)..add(newActivity),
          imageRef: state.imageRef,
          message: 'สร้างข้อมูลเรียบร้อย',
          business: state.business,
        ));
      } catch (e) {
        emitter(ManageActivityState(
          loading: false,
          hasError: true,
          message: 'สร้างข้อมูลล้มเหลว',
          activities: state.activities,
          imageRef: state.imageRef,
          business: state.business,
        ));
      }
    } catch (e) {
      emitter(ManageActivityState(
        loading: false,
        hasError: true,
        message: 'อัพโหลดรูปล้มเหลว',
        activities: state.activities,
        imageRef: state.imageRef,
      ));
    }
  }

  void _updateActivity(
    UpdateActivityManage event,
    Emitter<ManageActivityState> emitter,
  ) async {
    try {
      emitter(ManageActivityState(
        loading: true,
        activities: state.activities,
        business: state.business,
        imageRef: state.imageRef,
      ));
      if (event.activityModel.imageRef.isNotEmpty) {
        List<String> imageRef = await UploadService.multipleFile(
          event.activityModel.imageRef,
        );
        event.activityModel.imageRef = imageRef;
      }
      try {
        await ActivityService.updateActivity(
          event.activityModel,
          event.activityModel.id,
          event.token,
        );
        int index = List.from(state.activities)
            .indexWhere((element) => element.id == event.activityModel.id);
        List<ActivityModel> allActivities = List.from(state.activities)
          ..removeWhere((element) => element.id == event.activityModel.id);
        allActivities.insert(index, event.activityModel);
        emitter(ManageActivityState(
          loading: false,
          loaded: true,
          activities: allActivities,
          message: 'แก้ไขข้อมูลเรียบร้อย',
          business: state.business,
          imageRef: state.imageRef,
        ));
      } catch (e) {
        emitter(ManageActivityState(
          loading: false,
          hasError: true,
          message: 'แก้ไขข้อมูลล้มเหลว',
          activities: state.activities,
          business: state.business,
          imageRef: state.imageRef,
        ));
      }
    } catch (e) {
      emitter(ManageActivityState(
        loading: false,
        hasError: true,
        message: 'แก้ไขรูปภาพล้มเหลว',
        activities: state.activities,
        business: state.business,
        imageRef: state.imageRef,
      ));
    }
  }

  void _deleteActivity(
      DeleteActivityManage event, Emitter<ManageActivityState> emitter) async {
    try {
      emitter(ManageActivityState(
        loading: true,
        activities: state.activities,
        business: state.business,
      ));
      await ActivityService.deleteActivity(event.token, event.docId);

      List<ActivityModel> allActivities = List.from(state.activities)
        ..removeWhere((element) => element.id == event.docId);
      emitter(ManageActivityState(
        loading: false,
        loaded: true,
        activities: allActivities,
        message: 'ลบข้อมูลเรียบร้อย',
        business: state.business,
      ));
    } catch (e) {
      emitter(ManageActivityState(
        loading: false,
        hasError: true,
        message: 'ลบข้อมูลล้มเหลว',
        activities: state.activities,
        business: state.business,
      ));
    }
  }

  void _selectBusiness(
      SelectBusinessEvent event, Emitter<ManageActivityState> emitter) {
    emitter(
      ManageActivityState(
        business: event.businessNameModel,
        activities: state.activities,
        imageRef: state.imageRef,
      ),
    );
  }

  void _selectImage(
    SelectImageEvent event,
    Emitter<ManageActivityState> emitter,
  ) {
    List<File> allImage = List.from(state.imageRef)..add(event.image);
    emitter(
      ManageActivityState(
        business: state.business,
        activities: state.activities,
        imageRef: allImage,
      ),
    );
  }

  void _removeImage(
      RemoveImageEvent event, Emitter<ManageActivityState> emitter) {
    emitter(
      ManageActivityState(
        business: state.business,
        activities: state.activities,
        imageRef: List.from(state.imageRef)..removeAt(event.index),
      ),
    );
  }

  void _approveActivity(
    PartnerApproveActivityEvent event,
    Emitter<ManageActivityState> emitter,
  ) async {
    try {
      emitter(ManageActivityState(
        loading: true,
        activities: state.activities,
        business: state.business,
      ));
      await ActivityService.updateActivity(
        event.activityModel,
        event.activityModel.id,
        event.token,
      );

      List<ActivityModel> allActivities = List.from(state.activities)
        ..removeWhere((element) => element.id == event.activityModel.id);
      emitter(ManageActivityState(
        loading: false,
        loaded: true,
        activities: allActivities,
        message: 'อนุมัติเรียบร้อย',
        business: state.business,
      ));
    } catch (e) {
      emitter(
        ManageActivityState(
          loading: false,
          hasError: true,
          message: 'อนุมัติข้อมูลล้มเหลว',
          activities: state.activities,
          business: state.business,
        ),
      );
    }
  }

  void _rejectActivity(
    PartnerRejectActivityEvent event,
    Emitter<ManageActivityState> emitter,
  ) async {
    try {
      emitter(ManageActivityState(
        loading: true,
        activities: state.activities,
        business: state.business,
      ));
      await ActivityService.updateActivity(
          event.activityModel, event.activityModel.id, event.token);

      List<ActivityModel> allActivities = List.from(state.activities)
        ..removeWhere((element) => element.id == event.activityModel.id);
      emitter(ManageActivityState(
        loading: false,
        loaded: true,
        activities: allActivities,
        message: 'ปฏิเสธเรียบร้อย',
        business: state.business,
      ));
    } catch (e) {
      emitter(
        ManageActivityState(
          loading: false,
          hasError: true,
          message: 'ปฏิเสธข้อมูลล้มเหลว',
          activities: state.activities,
          business: state.business,
        ),
      );
    }
  }

  void _setImageRefForEdit(
      SetImageRefForEdit event, Emitter<ManageActivityState> emitter) {
    emitter(
      ManageActivityState(
        activities: state.activities,
        business: state.business,
        imageRef: event.imageRefs,
      ),
    );
  }

  void _setMyOrderActivity(
      SetMyOrderActivityEvent event, Emitter<ManageActivityState> emitter) {
    List<OrderActivityModel> orders = event.ordersActivity
        .where((order) => order.businessId == event.businessId)
        .toList();
    emitter(
      ManageActivityState(
        activities: state.activities,
        business: state.business,
        imageRef: state.imageRef,
        orderActivityBusiness: orders,
      ),
    );
  }

  void _actionOrderActivity(ActionOrderActivityEvent event,
      Emitter<ManageActivityState> emitter) async {
    try {
      List<OrderActivityModel> orders = [];
      for (var i = 0; i < state.orderActivityBusiness.length; i++) {
        OrderActivityModel order = state.orderActivityBusiness[i];
        orders.add(order.copyWith(status: event.status));
      }
      await OrderPackageService.actionOrderActivity(event.token, event.docId,
          event.status, event.businessId);
      emitter(ManageActivityState(
        activities: state.activities,
        business: state.business,
        imageRef: state.imageRef,
        orderActivityBusiness: orders,
      ));
    } catch (e) {
      log(e.toString());
      emitter(ManageActivityState(
        activities: state.activities,
        business: state.business,
        imageRef: state.imageRef,
        orderActivityBusiness: state.orderActivityBusiness,
      ));
    }
  }
}
