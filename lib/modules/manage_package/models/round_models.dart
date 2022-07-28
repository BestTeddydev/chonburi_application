import 'dart:developer';

import 'package:chonburi_mobileapp/modules/manage_activity/models/activity_model.dart';

class PackageRoundModel {
  String id;
  String round;
  int dayType;
  List<ActivityModel> activities;
  PackageRoundModel({
    required this.round,
    required this.dayType,
    required this.activities,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'round': round,
      'dayType': dayType,
      'activities': activities.map((x) => x.toMap()).toList(),
    };
  }

  Map<String, dynamic> toMapActivityId() {
    return <String, dynamic>{
      'round': round,
      'dayType': dayType,
      'activities': activities.map((x) => x.id).toList(),
    };
  }

  factory PackageRoundModel.fromMap(Map<String, dynamic> map) {
    return PackageRoundModel(
      id: map['_id'],
      round: map['round'],
      dayType: map['dayType'],
      activities: List<ActivityModel>.from(
          map['activities'].map((x) => ActivityModel.fromMap(x))),
    );
  }
  factory PackageRoundModel.fromMapActivityId(Map<String, dynamic> map) {
    log('$map');
    return PackageRoundModel(
      id: map['_id'],
      round: map['round'],
      dayType: map['dayType'],
      activities: List<ActivityModel>.from(
        map['activities'].map(
          (x) => ActivityModel.fromMap(
            {
              '_id': x,
              'activityName': '',
              'price': 0,
              'unit': '',
              'imageRef': [],
              'minPerson': 0,
              'businessId': '',
              'accepted': true,
            },
          ),
        ),
      ),
    );
  }

  PackageRoundModel copyWith({
    String? id,
    String? round,
    int? dayType,
    List<ActivityModel>? activities,
  }) {
    return PackageRoundModel(
      id: id ?? this.id,
      round: round ?? this.round,
      dayType: dayType ?? this.dayType,
      activities: activities ?? this.activities,
    );
  }
}
