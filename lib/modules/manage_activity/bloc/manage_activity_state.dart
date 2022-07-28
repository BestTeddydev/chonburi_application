part of 'manage_activity_bloc.dart';

class ManageActivityState extends Equatable {
  final List<ActivityModel> activities;
  final List<File> imageRef; // for create
  final BusinessNameModel business; // for create
  final List<OrderActivityModel>orderActivityBusiness;
  final bool loading;
  final bool loaded;
  final bool hasError;
  final String message;
  ManageActivityState({
    this.activities = const <ActivityModel>[],
    this.hasError = false,
    this.loaded = false,
    this.loading = false,
    this.message = '',
    this.imageRef = const <File>[],
    this.orderActivityBusiness = const [],
    BusinessNameModel? business,
  }) : business = business ??
            BusinessNameModel(
              businessId: '',
              businessName: '',
            );

  @override
  List<Object> get props => [
        activities,
        loaded,
        loading,
        hasError,
        message,
        business,
        imageRef,
        orderActivityBusiness,
      ];
}
