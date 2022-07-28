part of 'manage_activity_bloc.dart';

abstract class ManageActivityEvent extends Equatable {
  const ManageActivityEvent();

  @override
  List<Object> get props => [];
}

class FetchActivityManage extends ManageActivityEvent {
  final String token;
  final bool accepted;
  const FetchActivityManage({
    required this.token,
    required this.accepted,
  });
}

class FetchActivityBusiness extends ManageActivityEvent {
  final String token;
  final String businessId;
  final bool accepted;
  const FetchActivityBusiness({
    required this.token,
    required this.businessId,
    required this.accepted,
  });
}

class CreateActivityManage extends ManageActivityEvent {
  final ActivityModel activityModel;
  final String token;
  const CreateActivityManage({
    required this.activityModel,
    required this.token,
  });
}

class UpdateActivityManage extends ManageActivityEvent {
  final ActivityModel activityModel;
  final String token;
  const UpdateActivityManage({
    required this.activityModel,
    required this.token,
  });
}

class DeleteActivityManage extends ManageActivityEvent {
  final String docId;
  final String token;
  const DeleteActivityManage({
    required this.docId,
    required this.token,
  });
}

class SelectBusinessEvent extends ManageActivityEvent {
  final BusinessNameModel businessNameModel;
  const SelectBusinessEvent({
    required this.businessNameModel,
  });
}

class SelectImageEvent extends ManageActivityEvent {
  final File image;
  // final String image;
  const SelectImageEvent({
    required this.image,
  });
}

class RemoveImageEvent extends ManageActivityEvent {
  final int index;
  const RemoveImageEvent({
    required this.index,
  });
}

class PartnerApproveActivityEvent extends ManageActivityEvent {
  final ActivityModel activityModel;
  final String token;
  const PartnerApproveActivityEvent({
    required this.activityModel,
    required this.token,
  });
}

class PartnerRejectActivityEvent extends ManageActivityEvent {
  final ActivityModel activityModel;
  final String token;
  const PartnerRejectActivityEvent({
    required this.activityModel,
    required this.token,
  });
}

class SetImageRefForEdit extends ManageActivityEvent {
  final List<File> imageRefs;
  const SetImageRefForEdit({
    required this.imageRefs,
  });
}

class SetMyOrderActivityEvent extends ManageActivityEvent {
  final List<OrderActivityModel> ordersActivity;
  final String businessId;
  const SetMyOrderActivityEvent({
    required this.ordersActivity,
    required this.businessId,
  });
}

class ActionOrderActivityEvent extends ManageActivityEvent {
  final String token;
  final String businessId;
  final String status;
  final String docId;
  const ActionOrderActivityEvent({
    required this.token,
    required this.businessId,
    required this.status,
    required this.docId,
  });
}
