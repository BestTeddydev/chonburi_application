import 'package:bloc/bloc.dart';
import 'package:chonburi_mobileapp/modules/custom_package/models/order_custom.dart';
import 'package:chonburi_mobileapp/modules/manage_activity/models/activity_model.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/round_models.dart';
import 'package:chonburi_mobileapp/utils/services/order_custom_service.dart';
import 'package:equatable/equatable.dart';

part 'custom_package_event.dart';
part 'custom_package_state.dart';

class CustomPackageBloc extends Bloc<CustomPackageEvent, CustomPackageState> {
  CustomPackageBloc() : super(const CustomPackageState()) {
    on<AddRoundCustomEvent>(_addRound);
    on<RemoveRoundCustomEvent>(_removeRound);
    on<UpdateRoundNameCustomEvent>(_updateRoundName);
    on<SelectActivityCustomEvent>(_selectActivity);
    on<RemoveActivityCustomEvent>(_removeActivity);
    on<CreateOrderCustomEvent>(_createOrderPackage);
    on<FetchsOrderCustomEvent>(_fetchsOrderCustom);
  }
  void _createOrderPackage(
      CreateOrderCustomEvent event, Emitter<CustomPackageState> emitter) async {
    try {
      emitter(CustomPackageState(rounds: state.rounds, loading: true));
      await OrderCustomService.createOrderCustom(
          event.orderCustomModel, event.token);
      emitter(CustomPackageState(
          rounds: state.rounds, loaded: true, loading: false));
    } catch (e) {
      emitter(CustomPackageState(rounds: state.rounds, hasError: true));
    }
  }

  void _fetchsOrderCustom(
      FetchsOrderCustomEvent event, Emitter<CustomPackageState> emitter) async {
    try {
      emitter(CustomPackageState(
        orders: state.orders,
        loading: true,
      ));
      List<OrderCustomModel> orders =
          await OrderCustomService.fetchOrderCustoms(
        event.token,
        event.id,
        event.businessId,
      );
      emitter(CustomPackageState(
        orders: orders,
        rounds: state.rounds,
        loaded: true,
        loading: false,
      ));
    } catch (e) {
      print(e);
      emitter(CustomPackageState(
        rounds: state.rounds,
        loaded: true,
        loading: false,
      ));
    }
  }

  void _addRound(
    AddRoundCustomEvent event,
    Emitter<CustomPackageState> emitter,
  ) {
    emitter(
      CustomPackageState(
        rounds: List.from(state.rounds)..add(event.roundModel),
      ),
    );
  }

  void _removeRound(
    RemoveRoundCustomEvent event,
    Emitter<CustomPackageState> emitter,
  ) {
    emitter(
      CustomPackageState(
        rounds: List.from(state.rounds)..remove(event.roundModel),
      ),
    );
  }

  void _updateRoundName(
    UpdateRoundNameCustomEvent event,
    Emitter<CustomPackageState> emitter,
  ) {
    int index = List<PackageRoundModel>.from(state.rounds).indexWhere(
      (element) => element.id == event.roundModel.id,
    );
    List<PackageRoundModel> allRounds =
        List<PackageRoundModel>.from(state.rounds)
          ..removeWhere(
            (element) => element.id == event.roundModel.id,
          );
    allRounds.insert(index, event.roundModel.copyWith(round: event.value));
    emitter(
      CustomPackageState(
        rounds: allRounds,
      ),
    );
  }

  void _selectActivity(
      SelectActivityCustomEvent event, Emitter<CustomPackageState> emitter) {
    int index = List<PackageRoundModel>.from(state.rounds).indexWhere(
      (element) => element.id == event.roundId,
    );
    List<PackageRoundModel> allRounds =
        List<PackageRoundModel>.from(state.rounds)
          ..removeWhere(
            (element) => element.id == event.roundId,
          );
    allRounds.insert(
      index,
      state.rounds[index].copyWith(
        activities: List.from(state.rounds[index].activities)
          ..add(event.activityModel),
      ),
    );
    emitter(
      CustomPackageState(
        rounds: allRounds,
      ),
    );
  }

  void _removeActivity(
      RemoveActivityCustomEvent event, Emitter<CustomPackageState> emitter) {
    int index = List<PackageRoundModel>.from(state.rounds).indexWhere(
      (element) => element.id == event.roundId,
    );
    List<PackageRoundModel> allRounds =
        List<PackageRoundModel>.from(state.rounds)
          ..removeWhere(
            (element) => element.id == event.roundId,
          );
    allRounds.insert(
      index,
      state.rounds[index].copyWith(
        activities: List.from(state.rounds[index].activities)
          ..removeWhere((element) => element.id == event.activityModel.id),
      ),
    );
    emitter(
      CustomPackageState(
        rounds: allRounds,
      ),
    );
  }
}
