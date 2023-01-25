class ContactAdminModel {
  String id;
  String adminId;
  String fullName;
  String address;
  String phoneNumber;
  String typePayment;
  String accountPayment;
  ContactAdminModel({
    required this.id,
    required this.adminId,
    required this.fullName,
    required this.address,
    required this.phoneNumber,
    required this.typePayment,
    required this.accountPayment,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'adminId': adminId,
      'fullName': fullName,
      'address': address,
      'phoneNumber': phoneNumber,
      'typePayment': typePayment,
      'accountPayment': accountPayment,
    };
  }

  factory ContactAdminModel.fromMap(Map<String, dynamic> map) {
    return ContactAdminModel(
      id: map['_id'],
      adminId: map['adminId'],
      fullName: map['fullName'],
      address: map['address'],
      phoneNumber: map['phoneNumber'],
      typePayment: map['typePayment'],
      accountPayment: map['accountPayment'],
    );
  }
}
