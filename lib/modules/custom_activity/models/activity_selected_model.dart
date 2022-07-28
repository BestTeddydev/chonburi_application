import 'activity_time_model.dart';

class ActivitySelectedModel {
  String id;
  String activityName;
  bool selected;
  ActivitySelectedModel({
    required this.id,
    required this.activityName,
    required this.selected,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'activityName': activityName,
      'selected': selected,
    };
  }

  factory ActivitySelectedModel.fromMap(Map<String, dynamic> map) {
    return ActivitySelectedModel(
      id: map['_id'] ?? '',
      activityName: map['activityName'] ?? '',
      selected: map['selected'] ?? true,
    );
  }

 

  ActivitySelectedModel copyWith({
    String? id,
    String? activityName,
    bool? selected,
    List<ActivityTimeModel>? activityTime,
  }) {
    return ActivitySelectedModel(
      id: id ?? this.id,
      activityName: activityName ?? this.activityName,
      selected: selected ?? this.selected,
    );
  }
}
