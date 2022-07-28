// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ActivityTimeModel {
  String round;
  String duringTime;
  ActivityTimeModel({
    required this.round,
    required this.duringTime,
  });

  ActivityTimeModel copyWith({
    String? round,
    String? duringTime,
  }) {
    return ActivityTimeModel(
      round: round ?? this.round,
      duringTime: duringTime ?? this.duringTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'round': round,
      'duringTime': duringTime,
    };
  }

  factory ActivityTimeModel.fromMap(Map<String, dynamic> map) {
    return ActivityTimeModel(
      round: map['round'] as String,
      duringTime: map['duringTime'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ActivityTimeModel.fromJson(String source) => ActivityTimeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ActivityTimeModel(round: $round, duringTime: $duringTime)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ActivityTimeModel &&
      other.round == round &&
      other.duringTime == duringTime;
  }

  @override
  int get hashCode => round.hashCode ^ duringTime.hashCode;
}
