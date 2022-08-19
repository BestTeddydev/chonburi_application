class PartnerModel {
  String id;
  String firstName;
  String lastName;
  String username;
  String phoneNumber;
  String password;
  String role;
  String profileRef;
  // String verifyRef;
  double lat;
  double lng;
  String address;
  bool isAccept;
  String tokenDevice;
  PartnerModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.phoneNumber,
    required this.password,
    required this.role,
    required this.profileRef,
    required this.lat,
    required this.lng,
    required this.address,
    required this.isAccept,
    required this.tokenDevice,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'phoneNumber': phoneNumber,
      'password': password,
      'role': role,
      'profileRef': profileRef,
      'lat': lat,
      'lng': lng,
      'address': address,
      'isAccept': isAccept,
      'tokenDevice': tokenDevice,
    };
  }

  factory PartnerModel.fromMap(Map<String, dynamic> map) {
    return PartnerModel(
      id: map['_id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      username: map['username'],
      phoneNumber: map['phoneNumber'],
      password: map['password'],
      role: map['role'],
      profileRef: map['profileRef'],
      lat: map['lat']?.toDouble(),
      lng: map['lng']?.toDouble(),
      address: map['address'],
      isAccept: map['isAccept'],
      tokenDevice: map['tokenDevice'],
    );
  }
}
