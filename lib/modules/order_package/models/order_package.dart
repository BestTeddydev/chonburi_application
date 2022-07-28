import 'package:chonburi_mobileapp/modules/contact_info/models/contact_models.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/package_tour_models.dart';
import 'package:chonburi_mobileapp/modules/order_package/models/order_activity.dart';

class OrderPackageModel {
  String id;
  PackageTourModel package;
  String status; // admin accept
  int totalMember;
  double totalPrice;
  DateTime checkIn;
  DateTime checkOut;
  ContactModel contact;
  List<OrderActivityModel> orderActivities;
  String userId;
  String receiptImage;
  OrderPackageModel({
    required this.id,
    required this.package,
    required this.status,
    required this.totalMember,
    required this.totalPrice,
    required this.checkIn,
    required this.checkOut,
    required this.contact,
    required this.orderActivities,
    required this.userId,
    required this.receiptImage,
  });

  OrderPackageModel copyWith({
    String? id,
    PackageTourModel? package,
    String? status,
    int? totalMember,
    double? totalPrice,
    DateTime? checkIn,
    DateTime? checkOut,
    ContactModel? contact,
    List<OrderActivityModel>? orderActivities,
    String? userId,
    String? receiptImage,
  }) {
    return OrderPackageModel(
      id: id ?? this.id,
      package: package ?? this.package,
      status: status ?? this.status,
      totalMember: totalMember ?? this.totalMember,
      totalPrice: totalPrice ?? this.totalPrice,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      contact: contact ?? this.contact,
      orderActivities: orderActivities ?? this.orderActivities,
      userId: userId ?? this.userId,
      receiptImage: receiptImage ?? this.receiptImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'id': id,
      'package': package.id,
      'status': status,
      'totalMember': totalMember,
      'totalPrice': totalPrice,
      'checkIn': checkIn.toIso8601String(),
      'checkOut': checkOut.toIso8601String(),
      'contact': contact.id,
      'orderActivities': orderActivities.map((x) => x.toMap()).toList(),
      'userId': userId,
      'receiptImage': receiptImage,
    };
  }

  factory OrderPackageModel.fromMap(Map<String, dynamic> map) {
    return OrderPackageModel(
      id: map['_id'],
      package: PackageTourModel.fromMapBuyer(map['package']),
      status: map['status'],
      totalMember: map['totalMember']?.toInt(),
      totalPrice: map['totalPrice']?.toDouble(),
      checkIn: DateTime.parse(map['checkIn']).toLocal(),
      checkOut: DateTime.parse(map['checkOut']).toLocal(),
      contact: ContactModel.fromMapId(map['contact']),
      orderActivities: List<OrderActivityModel>.from(
        map['orderActivities'].map(
          (x) => OrderActivityModel.fromMap(x),
        ),
      ),
      userId: map['userId'],
      receiptImage: map['receiptImage'],
    );
  }
}
