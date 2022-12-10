// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'activity_bloc.dart';

abstract class ActivityEvent extends Equatable {
  const ActivityEvent();

  @override
  List<Object> get props => [];
}

// class SelectCheckDate extends ActivityEvent {
//   final DateTime date;
//   const SelectCheckDate({required this.date});
// }

class TotalMemberEmptyEvent extends ActivityEvent {}

// class FetchActivityEvent extends ActivityEvent {
//   final int totalMembers;
//   final String checkDate;
//   const FetchActivityEvent({
//     required this.totalMembers,
//     required this.checkDate,
//   });
// }

class SelectHasTagEvent extends ActivityEvent {
  final ActivitySelectedModel activitySelectedModel;
  const SelectHasTagEvent({
    required this.activitySelectedModel,
  });
}

// class FetchsPackagesEvent extends ActivityEvent {
//   final List<String> activitiesID;
//   final String day;
//   const FetchsPackagesEvent({required this.activitiesID, required this.day});
// }

class ChangeTabEvent extends ActivityEvent {
  final int tab;
  const ChangeTabEvent({
    required this.tab,
  });
}
