class RoomModel {
  String id;
  String roomName;
  double price;
  String imageCover;
  List<String> listImageDetail;
  String businessId;
  String categoryId;
  String descriptionRoom;
  int totalRoom;
  String roomSize;
  int totalGuest;
  RoomModel({
    required this.id,
    required this.roomName,
    required this.price,
    required this.imageCover,
    required this.listImageDetail,
    required this.businessId,
    required this.categoryId,
    required this.descriptionRoom,
    required this.totalRoom,
    required this.roomSize,
    required this.totalGuest,
  });

  RoomModel copyWith({
    String? id,
    String? roomName,
    double? price,
    String? imageCover,
    List<String>? listImageDetail,
    String? businessId,
    String? categoryId,
    String? descriptionRoom,
    int? totalRoom,
    String? roomSize,
    int? totalGuest,
  }) {
    return RoomModel(
      id: id ?? this.id,
      roomName: roomName ?? this.roomName,
      price: price ?? this.price,
      imageCover: imageCover ?? this.imageCover,
      listImageDetail: listImageDetail ?? this.listImageDetail,
      businessId: businessId ?? this.businessId,
      categoryId: categoryId ?? this.categoryId,
      descriptionRoom: descriptionRoom ?? this.descriptionRoom,
      totalRoom: totalRoom ?? this.totalRoom,
      roomSize: roomSize ?? this.roomSize,
      totalGuest: totalGuest ?? this.totalGuest,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roomName': roomName,
      'price': price,
      'imageCover': imageCover,
      'listImageDetail': listImageDetail,
      'businessId': businessId,
      'categoryId': categoryId,
      'descriptionRoom': descriptionRoom,
      'totalRoom': totalRoom,
      'roomSize': roomSize,
      'totalGuest': totalGuest,
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['_id'],
      roomName: map['roomName'],
      price: map['price']?.toDouble(),
      imageCover: map['imageCover'],
      listImageDetail: List<String>.from(map['listImageDetail']),
      businessId: map['businessId'],
      categoryId: map['categoryId'],
      descriptionRoom: map['descriptionRoom'],
      totalRoom: map['totalRoom']?.toInt(),
      roomSize: map['roomSize'],
      totalGuest: map['totalGuest']?.toInt(),
    );
  }
}
