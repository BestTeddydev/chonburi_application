
class ContactModel {
  String id;
  String userId;
  String fullName;
  String address;
  String phoneNumber;
  double lat;
  double lng;
  ContactModel({
    required this.userId,
    required this.fullName,
    required this.address,
    required this.phoneNumber,
    required this.lat,
    required this.lng,
    required this.id,
  });

  ContactModel copyWith({
    String? userId,
    String? fullName,
    String? address,
    String? phoneNumber,
    double? lat,
    double? lng,
    String? id,
  }) {
    return ContactModel(
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fullName': fullName,
      'address': address,
      'phoneNumber': phoneNumber,
      'lat': lat,
      'lng': lng,
    };
  }

  Map<String, dynamic> toMapId() {
    return {
      'userId': userId,
      'fullName': fullName,
      'address': address,
      'phoneNumber': phoneNumber,
      'lat': lat,
      'lng': lng,
      '_id': id,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      userId: map['userId'] ?? '',
      fullName: map['fullName'] ?? '',
      address: map['address'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      lat: map['lat']?.toDouble() ?? 0.0,
      lng: map['lng']?.toDouble() ?? 0.0,
      id: map['_id'] ?? '',
    );
  }
  factory ContactModel.fromMapOrderCustom(Map<String, dynamic> map) {
    return ContactModel(
      userId: map['userId'] ?? '',
      fullName: map['fullName'] ?? '',
      address: map['address'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      lat: map['lat']?.toDouble() ?? 0.0,
      lng: map['lng']?.toDouble() ?? 0.0,
      id:'',
    );
  }
  factory ContactModel.fromMapId(String id) {
    return ContactModel(
      userId: '',
      fullName: '',
      address: '',
      phoneNumber: '',
      lat: 0.0,
      lng: 0.0,
      id: id,
    );
  }
}
