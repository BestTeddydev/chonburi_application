class NotificationModel {
  String id;
  String title;
  String message;
  bool readed;
  String recipientId;
  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.readed,
    required this.recipientId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'message': message,
      'readed': readed,
      'recipientId': recipientId,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id:map['_id'],
      title: map['title'],
      message: map['message'],
      readed: map['readed'],
      recipientId: map['recipientId'],

    );
  }
}
