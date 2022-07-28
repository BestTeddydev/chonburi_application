
class ActivityModel {
  String id;
  String activityName;
  double price;
  String unit;
  List<String> imageRef;
  int minPerson;
  String businessId;
  bool accepted;
  ActivityModel({
    required this.id,
    required this.activityName,
    required this.price,
    required this.unit,
    required this.imageRef,
    required this.minPerson,
    required this.businessId,
    required this.accepted,
  });

  ActivityModel copyWith({
    String? id,
    String? activityName,
    double? price,
    String? unit,
    List<String>? imageRef,
    int? minPerson,
    String? businessId,
    bool? accepted,
  }) {
    return ActivityModel(
      id: id ?? this.id,
      activityName: activityName ?? this.activityName,
      price: price ?? this.price,
      unit: unit ?? this.unit,
      imageRef: imageRef ?? this.imageRef,
      minPerson: minPerson ?? this.minPerson,
      businessId: businessId ?? this.businessId,
      accepted: accepted ?? this.accepted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'activityName': activityName,
      'price': price,
      'unit': unit,
      'imageRef': imageRef,
      'minPerson': minPerson,
      'businessId': businessId,
      'accepted': accepted,
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
      'businessId': businessId,
      'accepted': accepted,
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
      businessId: '',
      accepted: true,
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
      businessId: map['businessId'],
      accepted: map['accepted'],
    );
  }
}
