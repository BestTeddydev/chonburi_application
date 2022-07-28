import 'package:chonburi_mobileapp/modules/custom_activity/models/activity_selected_model.dart';

loopID(List<dynamic> list) {
  List<String> listId = [];
  for (int i = 0; i < list.length; i++) {
    listId.add(list[i].id);
  }
  return listId;
}

loopSelectHasTag(List<ActivitySelectedModel> activities) {
  List<String> listId = [];
  for (int i = 0; i < activities.length; i++) {
    ActivitySelectedModel activitySelectedModel = activities[i];
    if (activitySelectedModel.selected) listId.add(activitySelectedModel.id);
  }
  return listId;
}
