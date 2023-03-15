class OrderActivityModel {
  String id;
  String activityName;
  double price;
  List<String> imageRef;
  int totalPerson;
  String businessId;
  String status; // partner approve
  String roundId;
  String roundName;
  String dayName;
  OrderActivityModel({
    required this.id,
    required this.activityName,
    required this.price,
    required this.imageRef,
    required this.totalPerson,
    required this.businessId,
    required this.status,
    required this.roundId,
    required this.roundName,
    required this.dayName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'activityName': activityName,
      'price': price,
      'imageRef': imageRef,
      'totalPerson': totalPerson,
      'businessId': businessId,
      'status': status,
      'roundId': roundId,
      'roundName': roundName,
      'dayName': dayName,
    };
  }

  factory OrderActivityModel.fromMap(Map<String, dynamic> map) {
    return OrderActivityModel(
      id: map['_id'],
      activityName: map['activityName'],
      price: map['price']?.toDouble(),
      imageRef: List<String>.from(map['imageRef']),
      totalPerson: map['totalPerson']?.toInt(),
      businessId: map['businessId'],
      status: map['status'],
      roundId: map['roundId'],
      roundName: map['roundName'],
      dayName: map['dayName'],
    );
  }
factory OrderActivityModel.fromMapCustom(Map<String, dynamic> map) {
    return OrderActivityModel(
      id: map['id'],
      activityName: map['activityName'],
      price: map['price']?.toDouble(),
      imageRef: List<String>.from(map['imageRef']),
      totalPerson: map['totalPerson']?.toInt(),
      businessId: map['businessId'],
      status: map['status'],
      roundId: map['roundId'],
      roundName: map['roundName'],
      dayName: map['dayName'],
    );
  }
  OrderActivityModel copyWith({
    String? id,
    String? activityName,
    double? price,
    List<String>? imageRef,
    int? totalPerson,
    String? businessId,
    String? status,
    String? roundId,
    String? roundName,
    String? dayName,
  }) {
    return OrderActivityModel(
      id: id ?? this.id,
      activityName: activityName ?? this.activityName,
      price: price ?? this.price,
      imageRef: imageRef ?? this.imageRef,
      totalPerson: totalPerson ?? this.totalPerson,
      businessId: businessId ?? this.businessId,
      status: status ?? this.status,
      roundId: roundId ?? this.roundId,
      roundName: roundName ?? this.roundName,
      dayName: dayName ?? this.dayName,
    );
  }
}
