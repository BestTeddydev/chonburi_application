
import '../../manage_activity/models/activity_model.dart';

class BuyActivity {
  Map<String, List<ActivityModel>> packageActivity;
  BuyActivity({
    required this.packageActivity,
  });

  BuyActivity copyWith({
    Map<String, List<ActivityModel>>? packageActivity,
  }) {
    return BuyActivity(
      packageActivity: packageActivity ?? this.packageActivity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'packageActivity': packageActivity,
    };
  }

  factory BuyActivity.fromMap(Map<String, dynamic> map) {
    return BuyActivity(
      packageActivity: Map<String, List<ActivityModel>>.from((map['packageActivity'] as Map<String, List<ActivityModel>>)),
    );
  }
}
