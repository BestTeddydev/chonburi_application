part of 'manage_package_bloc.dart';

abstract class ManagePackageEvent extends Equatable {
  const ManagePackageEvent();

  @override
  List<Object> get props => [];
}

class FetchPackageEvent extends ManagePackageEvent {
  final String token;
  const FetchPackageEvent({
    required this.token,
  });
}

class CreatePackageEvent extends ManagePackageEvent {
  final String token;
  final PackageTourModel packageTourModel;
  const CreatePackageEvent({
    required this.packageTourModel,
    required this.token,
  });
}

class UpdatePackageEvent extends ManagePackageEvent {
  final String token;
  final PackageTourModel packageTourModel;
  const UpdatePackageEvent({
    required this.packageTourModel,
    required this.token,
  });
}

class DeletePackageEvent extends ManagePackageEvent {
  final String token;
  final String docId;
  const DeletePackageEvent({
    required this.token,
    required this.docId,
  });
}

class SelectImageEvent extends ManagePackageEvent {
  final File image;
  const SelectImageEvent({
    required this.image,
  });
}
class SelectImagePaymentEvent extends ManagePackageEvent {
  final File image;
  const SelectImagePaymentEvent({
    required this.image,
  });
}

class SelectDayForrent extends ManagePackageEvent {
  final String day;
  const SelectDayForrent({
    required this.day,
  });
}

class ChangeDayTripType extends ManagePackageEvent {
  final String dayType;
  const ChangeDayTripType({
    required this.dayType,
  });
}
class ChangeTypePaymentEvent extends ManagePackageEvent {
  final String typePayment;
  const ChangeTypePaymentEvent({
    required this.typePayment,
  });
}

class AddDayEvent extends ManagePackageEvent {
  final String day;
  const AddDayEvent({
    required this.day,
  });
}

class RemoveDayEvent extends ManagePackageEvent {
  final String day;
  const RemoveDayEvent({
    required this.day,
  });
}

class SetDataPackageEvent extends ManagePackageEvent {
  final String tripsType;
  final List<String> dayForrents;
  final String typePayment;
  const SetDataPackageEvent({
    required this.tripsType,
    required this.dayForrents,
    required this.typePayment,
  });
}

class FetchPackageRoundEvent extends ManagePackageEvent {
  final String token;
  final String docId;
  const FetchPackageRoundEvent({
    required this.token,
    required this.docId,
  });
}

class AddRoundPackageEvent extends ManagePackageEvent {
  final PackageRoundModel roundModel;
  const AddRoundPackageEvent({
    required this.roundModel,
  });
}

class SelectActivityEvent extends ManagePackageEvent {
  final ActivityModel activityModel;
  final String roundId;
  const SelectActivityEvent({
    required this.activityModel,
    required this.roundId,
  });
}

class RemoveActivityEvent extends ManagePackageEvent {
  final ActivityModel activityModel;
  final String roundId;
  const RemoveActivityEvent({
    required this.activityModel,
    required this.roundId,
  });
}

class UpdateRoundNameEvent extends ManagePackageEvent {
  final PackageRoundModel roundModel;
  final String value;
  const UpdateRoundNameEvent({
    required this.roundModel,
    required this.value,
  });
}

class RemoveRoundPackageEvent extends ManagePackageEvent {
  final PackageRoundModel roundModel;
  const RemoveRoundPackageEvent({
    required this.roundModel,
  });
}
