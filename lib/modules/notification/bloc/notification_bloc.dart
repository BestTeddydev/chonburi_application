import 'package:bloc/bloc.dart';
import 'package:chonburi_mobileapp/modules/notification/models/notification_models.dart';
import 'package:chonburi_mobileapp/utils/services/notification_service.dart';
import 'package:equatable/equatable.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(const NotificationState(notifications: [])) {
    on<FetchNotificationEvent>(_fetchNotifications);
    on<DeleteNotificationEvent>(_deleteNotification);
  }
  void _fetchNotifications(
      FetchNotificationEvent event, Emitter<NotificationState> emitter) async {
    try {
      List<NotificationModel> notifications =
          await NotificationService.fetchsNotification(event.recipientId);
      emitter(
        NotificationState(notifications: notifications),
      );
    } catch (e) {
      emitter(
        const NotificationState(
          notifications: [],
        ),
      );
    }
  }

  void _deleteNotification(
      DeleteNotificationEvent event, Emitter<NotificationState> emitter) async {
    try {
      await NotificationService.deleteNotification(event.docId, event.token);
      List<NotificationModel> notifications = List.from(state.notifications)
        ..removeWhere(
          (element) => element.id == event.docId,
        );
      emitter(
        NotificationState(notifications: notifications),
      );
    } catch (e) {
      emitter(
        NotificationState(
          notifications: state.notifications,
        ),
      );
    }
  }
}
