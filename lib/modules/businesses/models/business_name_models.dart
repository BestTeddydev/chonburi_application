
class BusinessNameModel {
  String businessId;
  String businessName;
  BusinessNameModel({
    required this.businessId,
    required this.businessName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': businessId,
      'businessName': businessName,
    };
  }

  factory BusinessNameModel.fromMap(Map<String, dynamic> map) {
    return BusinessNameModel(
      businessId: map['_id'],
      businessName: map['businessName'],
    );
  }
}
