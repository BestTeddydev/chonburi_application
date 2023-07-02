class RoomLeftModel {
  String id;
  int roomLeft;
  RoomLeftModel({
    required this.id,
    required this.roomLeft,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "roomLeft": roomLeft,
    };
  }

  factory RoomLeftModel.fromMap(Map<String, dynamic> map) {
    return RoomLeftModel(
      id: map["id"],
      roomLeft: map["roomLeft"]?.toInt(),
    );
  }
}
