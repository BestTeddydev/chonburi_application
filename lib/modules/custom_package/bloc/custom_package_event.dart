part of 'custom_package_bloc.dart';

abstract class CustomPackageEvent extends Equatable {
  const CustomPackageEvent();

  @override
  List<Object> get props => [];
}
class CreateOrderCustomEvent extends CustomPackageEvent {
  final OrderCustomModel orderCustomModel;
  final String token;
  const CreateOrderCustomEvent({
    required this.orderCustomModel,
    required this.token,
  });
}
class FetchsOrderCustomEvent extends CustomPackageEvent {
  final String token;
  final String id;
  final String businessId;
  final String packageId;
  const FetchsOrderCustomEvent({
    required this.token,
     this.id = '',
     this.businessId = '',
     this.packageId = '',
  });
}
class AddRoundCustomEvent extends CustomPackageEvent {
  final PackageRoundModel roundModel;
  const AddRoundCustomEvent({
    required this.roundModel,
  });
}

class SelectActivityCustomEvent extends CustomPackageEvent {
  final ActivityModel activityModel;
  final String roundId;
  const SelectActivityCustomEvent({
    required this.activityModel,
    required this.roundId,
  });
}

class RemoveActivityCustomEvent extends CustomPackageEvent {
  final ActivityModel activityModel;
  final String roundId;
  const RemoveActivityCustomEvent({
    required this.activityModel,
    required this.roundId,
  });
}

class UpdateRoundNameCustomEvent extends CustomPackageEvent {
  final PackageRoundModel roundModel;
  final String value;
  const UpdateRoundNameCustomEvent({
    required this.roundModel,
    required this.value,
  });
}

class RemoveRoundCustomEvent extends CustomPackageEvent {
  final PackageRoundModel roundModel;
  const RemoveRoundCustomEvent({
    required this.roundModel,
  });
}
