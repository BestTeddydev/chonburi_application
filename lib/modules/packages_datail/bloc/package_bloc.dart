import 'package:chonburi_mobileapp/modules/manage_package/models/package_tour_models.dart';
import 'package:chonburi_mobileapp/modules/order_package/models/order_activity.dart';
import 'package:chonburi_mobileapp/utils/services/package_service.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'package_event.dart';
part 'package_state.dart';

class PackageBloc extends HydratedBloc<PackageEvent, PackageState> {
  PackageBloc() : super(PackageState()) {
    on<FetchPackageEvent>(_fetchPackage);
    on<BuyActivityEvent>(_buyActivity);
    on<CancelActivityEvent>(_cancelActivity);
    on<ClearBuyActivityEvent>(_clearBuyActivity);
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
        ),
      );
    } catch (e) {
      emitter(PackageState(isError: true));
    }
  }

  void _buyActivity(BuyActivityEvent event, Emitter<PackageState> emitter) {
    List<OrderActivityModel> allActivities = List.from(state.buyActivity)
      ..add(event.activityModel);
    emitter(
      PackageState(
        packagesTour: state.packagesTour,
        isError: false,
        buyActivity: allActivities,
        packageId: event.packageID,
      ),
    );
  }

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
      ),
    );
  }

  void _clearBuyActivity(
      ClearBuyActivityEvent event, Emitter<PackageState> emitter) {
    emitter(
      PackageState(
        packagesTour: state.packagesTour,
        isError: false,
        buyActivity: const [],
        packageId: '',
      ),
    );
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
