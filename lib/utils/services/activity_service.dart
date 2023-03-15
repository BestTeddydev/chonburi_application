import 'package:chonburi_mobileapp/constants/api_path.dart';
import 'package:chonburi_mobileapp/modules/custom_activity/models/activity_selected_model.dart';
import 'package:chonburi_mobileapp/modules/manage_activity/models/activity_model.dart';
import 'package:chonburi_mobileapp/utils/helper/dio.dart';
import 'package:dio/dio.dart';

class ActivityService {
  static Future<List<ActivitySelectedModel>> fetchActivityPerson(
      int person, String day) async {
    try {
      List<ActivitySelectedModel> activities = [];
      Response response =
          await Dio().get('${APIRoute.host}/guest/activities/$person/$day');
      for (var activity in response.data) {
        ActivitySelectedModel activityModel =
            ActivitySelectedModel.fromMap(activity);
        activities.add(activityModel);
      }

      return activities;
    } catch (e) {
      return [];
    }
  }

  static Future<List<ActivityModel>> fetchActivityAdmin(
    String token,
    bool? accepted,
  ) async {
    try {
      String url = '/activity';
      if (accepted != null && accepted) {
        url = '/activity?accepted=$accepted';
      }
      List<ActivityModel> activities = [];
      Response response = await DioService.dioGetAuthen(url, token);
      for (var activity in response.data) {
        ActivityModel activityModel = ActivityModel.fromMap(activity);

        activities.add(activityModel);
      }

      return activities;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  static Future<List<ActivityModel>> fetchActivityBusiness(
      String token, String businessId, bool accepted) async {
    try {
      List<ActivityModel> activities = [];
      Response response = await DioService.dioGetAuthen(
          '/activity/$businessId/$accepted', token);
      for (var activity in response.data) {
        ActivityModel activityModel = ActivityModel.fromMap(activity);

        activities.add(activityModel);
      }

      return activities;
    } catch (e) {
      return [];
    }
  }

  static Future<ActivityModel> createActivity(
    ActivityModel activityModel,
    String token,
  ) async {
    Response response = await DioService.dioPostAuthen(
        '/activity', token, activityModel.toMap());
    ActivityModel activity = ActivityModel.fromMap(response.data);
    return activity;
  }

  static Future<void> updateActivity(
    ActivityModel activityModel,
    String docId,
    String token,
  ) async {
    await DioService.dioPut('/activity/$docId', token, activityModel.toMap());
  }

  static Future<void> deleteActivity(String token, String docId) async {
    await DioService.dioDelete('/activity/$docId', token);
  }
}
