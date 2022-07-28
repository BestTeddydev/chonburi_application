part of 'activity_bloc.dart';

class ActivityState extends Equatable {
  final DateTime checkDate;
  final List<ActivitySelectedModel> activities;
  final List<PackageTourModel> packages;
  final int totalMember;
  final int isTab;
  ActivityState({
    DateTime? checkDate,
    this.activities = const <ActivitySelectedModel>[],
    this.packages = const <PackageTourModel>[],
    this.totalMember = 0,
    this.isTab = 0,
  }) : checkDate = checkDate ?? DateTime.now();

  @override
  List<Object> get props => [
        checkDate,
        activities,
        packages,
        isTab,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'checkDate': checkDate.millisecondsSinceEpoch,
      // 'totalMember': totalMember
      // 'activities': activities.map((x) => x.toMap()).toList(),
    };
  }

  factory ActivityState.fromMap(Map<String, dynamic> map) {
    return ActivityState(
      checkDate: DateTime.fromMillisecondsSinceEpoch(map['checkDate']),
      // totalMember: map['totalMember']
      // activities: List<ActivitySelectedModel>.from(
      //   (map['activities']).map<ActivitySelectedModel>(
      //     (x) => ActivitySelectedModel.fromMap(x as Map<String, dynamic>),
      //   ),
      // ),
    );
  }
}
