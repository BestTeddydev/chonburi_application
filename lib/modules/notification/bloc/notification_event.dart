part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class FetchNotificationEvent extends NotificationEvent {
  final String recipientId;
  const FetchNotificationEvent({
    required this.recipientId,
  });
}
class DeleteNotificationEvent extends NotificationEvent {
  final String docId;
  final String token;
  const DeleteNotificationEvent({
    required this.docId,
    required this.token,
  });
}
