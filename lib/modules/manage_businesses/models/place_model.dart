class PlaceModel {
  String id;
  String placeName;
  String address;
  String description;
  List<String> imageList;
  String videoRef;
  int ratingCount;
  double point;
  double lat;
  double lng;
  String ownerId;
  double price;
  PlaceModel({
    required this.id,
    required this.placeName,
    required this.address,
    required this.description,
    required this.imageList,
    required this.videoRef,
    required this.ratingCount,
    required this.point,
    required this.lat,
    required this.lng,
    required this.ownerId,
    required this.price,
  });

  PlaceModel copyWith({
    String? id,
    String? placeName,
    String? address,
    String? description,
    List<String>? imageList,
    String? videoRef,
    int? ratingCount,
    double? point,
    double? lat,
    double? lng,
    String? ownerId,
    double? price,
  }) {
    return PlaceModel(
      id: id ?? this.id,
      placeName: placeName ?? this.placeName,
      address: address ?? this.address,
      description: description ?? this.description,
      imageList: imageList ?? this.imageList,
      videoRef: videoRef ?? this.videoRef,
      ratingCount: ratingCount ?? this.ratingCount,
      point: point ?? this.point,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      ownerId: ownerId ?? this.ownerId,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'placeName': placeName,
      'address': address,
      'description': description,
      'imageList': imageList,
      'videoRef': videoRef,
      'ratingCount': ratingCount,
      'point': point,
      'lat': lat,
      'lng': lng,
      'ownerId': ownerId,
      'price': price,
    };
  }

  factory PlaceModel.fromMap(Map<String, dynamic> map) {
    return PlaceModel(
      id: map['_id'],
      placeName: map['placeName'],
      address: map['address'],
      description: map['description'],
      imageList: List<String>.from(map['imageList']),
      videoRef: map['videoRef'],
      ratingCount: map['ratingCount']?.toInt(),
      point: map['point']?.toDouble(),
      lat: map['lat']?.toDouble(),
      lng: map['lng']?.toDouble(),
      ownerId: map['ownerId'],
      price: map['price']?.toDouble(),
    );
  }
}
