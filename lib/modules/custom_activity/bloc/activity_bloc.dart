import 'package:chonburi_mobileapp/modules/custom_activity/models/activity_selected_model.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/package_tour_models.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends HydratedBloc<ActivityEvent, ActivityState> {
  ActivityBloc() : super(ActivityState()) {
    // on<SelectCheckDate>(_selectCheckDate);
    on<TotalMemberEmptyEvent>(_changeTotalMemberEmpty);
    // on<FetchActivityEvent>(_fetchActivity);
    on<SelectHasTagEvent>(_selectHasTag);
    // on<FetchsPackagesEvent>(_fetchPackages);
    on<ChangeTabEvent>(_selectTab);
  }
  // void _selectCheckDate(SelectCheckDate event, Emitter<ActivityState> emit) {
  //   // event คือตัวที่รับค่าใหม่มา
  //   // state คือตัวที่เก็บค่าเก่าไว้
  //   emit(
  //     ActivityState(
  //       checkDate: event.date,
  //       activities: state.activities,
  //       isTab: state.isTab,
  //       packages: state.packages,
  //       totalMember: state.totalMember,
  //     ),
  //   );
  // }

  void _changeTotalMemberEmpty(
      TotalMemberEmptyEvent event, Emitter<ActivityState> emitter) {
    emitter(
      ActivityState(
        checkDate: state.checkDate,
        activities: const [],
        isTab: state.isTab,
        packages: state.packages,
        totalMember: 0,
      ),
    );
  }

  // Future<void> _fetchActivity(
  //     FetchActivityEvent event, Emitter<ActivityState> emitter) async {
  //   List<ActivitySelectedModel> activities =
  //       await ActivityService.fetchActivityPerson(
  //     event.totalMembers,
  //     event.checkDate,
  //   );
  //   emitter(
  //     ActivityState(
  //       activities: activities,
  //       checkDate: state.checkDate,
  //       isTab: state.isTab,
  //       packages: state.packages,
  //       totalMember: event.totalMembers,
  //     ),
  //   );
  // }

  void _selectHasTag(SelectHasTagEvent event, Emitter<ActivityState> emitter) {
    ActivitySelectedModel activityModel = event.activitySelectedModel;
    final int index = state.activities.indexOf(activityModel);
    List<ActivitySelectedModel> activities = List.from(state.activities)
      ..remove(activityModel);
    activityModel.selected == true
        ? activities.insert(index, activityModel.copyWith(selected: false))
        : activities.insert(index, activityModel.copyWith(selected: true));
    emitter(
      ActivityState(
        activities: activities,
        isTab: state.isTab,
        checkDate: state.checkDate,
        packages: state.packages,
        totalMember: state.totalMember,
      ),
    );
  }

  // Future<void> _fetchPackages(
  //   FetchsPackagesEvent event,
  //   Emitter<ActivityState> emitter,
  // ) async {
  //   try {
  //     List<PackageTourModel> packages =
  //         await PackageService.fetchsPackages(event.activitiesID, event.day);
  //     emitter(
  //       ActivityState(
  //         packages: packages,
  //         activities: state.activities,
  //         checkDate: state.checkDate,
  //         isTab: 0,
  //         totalMember: state.totalMember,
  //       ),
  //     );
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  void _selectTab(ChangeTabEvent event, Emitter<ActivityState> emitter) {
    emitter(
      ActivityState(
        packages: state.packages,
        activities: state.activities,
        checkDate: state.checkDate,
        isTab: event.tab,
        totalMember: state.totalMember,
      ),
    );
  }

  @override
  ActivityState? fromJson(Map<String, dynamic> json) {
    return ActivityState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ActivityState state) {
    return state.toMap();
  }
}
