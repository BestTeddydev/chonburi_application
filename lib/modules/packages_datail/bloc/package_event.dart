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
