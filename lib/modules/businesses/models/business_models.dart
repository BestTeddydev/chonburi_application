
class BusinessModel {
  String id;
  String businessName;
  String sellerId;
  String address;
  double latitude;
  double longitude;
  bool statusOpen;
  double ratingCount;
  double point;
  String paymentNumber;
  String qrcodeRef; //image url
  String phoneNumber;
  String imageRef; //image url
  double ratePrice;
  String typeBusiness;
  String typePayment;
  String introduce;
  BusinessModel({
    required this.id,
    required this.businessName,
    required this.sellerId,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.statusOpen,
    required this.ratingCount,
    required this.point,
    required this.paymentNumber,
    required this.qrcodeRef,
    required this.phoneNumber,
    required this.imageRef,
    required this.ratePrice,
    required this.typeBusiness,
    required this.typePayment,
    required this.introduce,
  });
  

  BusinessModel copyWith({
    String? id,
    String? businessName,
    String? sellerId,
    String? address,
    double? latitude,
    double? longitude,
    bool? statusOpen,
    double? ratingCount,
    double? point,
    String? paymentNumber,
    String? qrcodeRef,
    String? phoneNumber,
    String? imageRef,
    double? ratePrice,
    String? typeBusiness,
    String? typePayment,
    String? introduce,
  }) {
    return BusinessModel(
      id: id ?? this.id,
      businessName: businessName ?? this.businessName,
      sellerId: sellerId ?? this.sellerId,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      statusOpen: statusOpen ?? this.statusOpen,
      ratingCount: ratingCount ?? this.ratingCount,
      point: point ?? this.point,
      paymentNumber: paymentNumber ?? this.paymentNumber,
      qrcodeRef: qrcodeRef ?? this.qrcodeRef,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imageRef: imageRef ?? this.imageRef,
      ratePrice: ratePrice ?? this.ratePrice,
      typeBusiness: typeBusiness ?? this.typeBusiness,
      typePayment: typePayment ?? this.typePayment,
      introduce: introduce ?? this.introduce,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'businessName': businessName,
      'sellerId': sellerId,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'statusOpen': statusOpen,
      'ratingCount': ratingCount,
      'point': point,
      'paymentNumber': paymentNumber,
      'qrcodeRef': qrcodeRef,
      'phoneNumber': phoneNumber,
      'imageRef': imageRef,
      'ratePrice': ratePrice,
      'typeBusiness': typeBusiness,
      'typePayment': typePayment,
      'introduce': introduce,
    };
  }

  Map<String, dynamic> toMapWithId() {
    return <String, dynamic>{
      "_id":id,
      'businessName': businessName,
      'sellerId': sellerId,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'statusOpen': statusOpen,
      'ratingCount': ratingCount,
      'point': point,
      'paymentNumber': paymentNumber,
      'qrcodeRef': qrcodeRef,
      'phoneNumber': phoneNumber,
      'imageRef': imageRef,
      'ratePrice': ratePrice,
      'typeBusiness': typeBusiness,
      'typePayment': typePayment,
      'introduce': introduce,
    };
  }

  factory BusinessModel.fromMap(Map<String, dynamic> map) {
    return BusinessModel(
      id: map['_id'],
      businessName: map['businessName'],
      sellerId: map['sellerId'],
      address: map['address'],
      latitude: map['latitude']?.toDouble(),
      longitude: map['longitude']?.toDouble(),
      statusOpen: map['statusOpen'],
      ratingCount: map['ratingCount']?.toDouble(),
      point: map['point']?.toDouble(),
      paymentNumber: map['paymentNumber'],
      qrcodeRef: map['qrcodeRef'],
      phoneNumber: map['phoneNumber'],
      imageRef: map['imageRef'],
      ratePrice: map['ratePrice']?.toDouble(),
      typeBusiness: map['typeBusiness'],
      typePayment: map['typePayment'],
      introduce: map['introduce'],
    );
  }
}
