part of 'package_bloc.dart';

abstract class PackageEvent extends Equatable {
  const PackageEvent();

  @override
  List<Object> get props => [];
}

class FetchPackageEvent extends PackageEvent {
  final String packageID;
  const FetchPackageEvent({required this.packageID});
}

class BuyActivityEvent extends PackageEvent {
  final OrderActivityModel activityModel;
  final String packageID;
  const BuyActivityEvent({
    required this.activityModel,
    required this.packageID,
  });
}

class CancelActivityEvent extends PackageEvent {
  final OrderActivityModel activityModel;
  final String roundId;
  const CancelActivityEvent({
    required this.activityModel,
    required this.roundId,
  });
}

class ClearBuyActivityEvent extends PackageEvent {}

class FetchsPackagesEvent extends PackageEvent {}
class SelectCheckDate extends PackageEvent {
  final DateTime date;
  const SelectCheckDate({required this.date});
}
class TotalMemberEvent extends PackageEvent {
  final int member;
  const TotalMemberEvent({
    required this.member,
  });
}

class SelectImageSlipPaymentEvent extends PackageEvent {
  final File image;
  const SelectImageSlipPaymentEvent({
    required this.image,
  });
}

class CheckoutPackageEvent extends PackageEvent {
  final String token;
  final OrderPackageModel order;
  final File slipPayment;
  const CheckoutPackageEvent({
    required this.token,
    required this.order,
    required this.slipPayment,
  });
}
