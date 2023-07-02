class ContactAdminModel {
  String id;
  String createdBy;
  String fullName;
  String address;
  String phoneNumber;
  String typePayment;
  String accountPayment;
  String profileRef;
  String imagePayment;
  ContactAdminModel({
    required this.id,
    required this.createdBy,
    required this.fullName,
    required this.address,
    required this.phoneNumber,
    required this.typePayment,
    required this.accountPayment,
    required this.imagePayment,
    required this.profileRef,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdBy': createdBy,
      'fullName': fullName,
      'address': address,
      'phoneNumber': phoneNumber,
      'typePayment': typePayment,
      'accountPayment': accountPayment,
      'imagePayment': imagePayment,
      'profileRef': profileRef,
    };
  }

  factory ContactAdminModel.fromMap(Map<String, dynamic> map) {
    return ContactAdminModel(
      id: map['_id'] ?? '',
      createdBy: map['createdBy'] ?? '',
      fullName: map['fullName'] ?? '',
      address: map['address'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      typePayment: map['typePayment'] ?? '',
      accountPayment: map['accountPayment'] ?? '',
      imagePayment: map['imagePayment'] ?? '',
      profileRef: map['profileRef'] ?? '',
    );
  }
}
