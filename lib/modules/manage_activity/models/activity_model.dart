class ActivityModel {
  String id;
  String activityName;
  double price;
  String unit;
  List<String> imageRef;
  int minPerson;
  String placeId;
  bool accepted;
  String usageTime;
  ActivityModel({
    required this.id,
    required this.activityName,
    required this.price,
    required this.unit,
    required this.imageRef,
    required this.minPerson,
    required this.placeId,
    required this.accepted,
    required this.usageTime,
  });

  ActivityModel copyWith({
    String? id,
    String? activityName,
    double? price,
    String? unit,
    List<String>? imageRef,
    int? minPerson,
    String? placeId,
    bool? accepted,
    String? usageTime,
  }) {
    return ActivityModel(
      id: id ?? this.id,
      activityName: activityName ?? this.activityName,
      price: price ?? this.price,
      unit: unit ?? this.unit,
      imageRef: imageRef ?? this.imageRef,
      minPerson: minPerson ?? this.minPerson,
      placeId: placeId ?? this.placeId,
      accepted: accepted ?? this.accepted,
      usageTime: usageTime ?? this.usageTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'activityName': activityName,
      'price': price,
      'unit': unit,
      'imageRef': imageRef,
      'minPerson': minPerson,
      'placeId': placeId,
      'accepted': accepted,
      'usageTime': usageTime,
    };
  }

  Map<String, dynamic> toMapId() {
    return <String, dynamic>{
      '_id': id,
      'activityName': activityName,
      'price': price,
      'unit': unit,
      'imageRef': imageRef,
      'minPerson': minPerson,
      'placeId': placeId,
      'accepted': accepted,
      'usageTime': usageTime,
    };
  }

  Map<String, dynamic> onlyId() {
    return <String, dynamic>{
      '_id': id,
    };
  }

  factory ActivityModel.fromMapOnlyId(String id) {
    return ActivityModel(
      id: id,
      activityName: '',
      price: 0,
      unit: '',
      imageRef: [],
      minPerson: 0,
      placeId: '',
      accepted: true,
      usageTime: '',
    );
  }

  factory ActivityModel.fromMap(Map<String, dynamic> map) {
    return ActivityModel(
      id: map['_id'],
      activityName: map['activityName'],
      price: map['price']?.toDouble(),
      unit: map['unit'],
      imageRef: List<String>.from(map['imageRef']),
      minPerson: map['minPerson']?.toInt(),
      placeId: map['placeId'],
      accepted: map['accepted'],
      usageTime: map['usageTime'] ?? '',
    );
  }
}
