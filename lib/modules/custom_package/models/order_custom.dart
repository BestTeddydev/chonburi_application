import 'package:chonburi_mobileapp/modules/auth/models/user_model.dart';
import 'package:chonburi_mobileapp/modules/contact_admin/models/contact_admin_model.dart';
import 'package:chonburi_mobileapp/modules/contact_info/models/contact_models.dart';
import 'package:chonburi_mobileapp/modules/order_package/models/order_activity.dart';

class OrderCustomModel {
  String id;
  ContactAdminModel contactAdmin;
  String status; // admin accept
  int totalMember;
  double totalPrice;
  DateTime checkIn;
  DateTime checkOut;
  ContactModel contact;
  List<OrderActivityModel> orderActivities;
  UserModel user;
  String receiptImage;
  OrderCustomModel({
    required this.id,
    required this.contactAdmin,
    required this.status,
    required this.totalMember,
    required this.totalPrice,
    required this.checkIn,
    required this.checkOut,
    required this.contact,
    required this.orderActivities,
    required this.user,
    required this.receiptImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'contactAdmin': contactAdmin.toMap(),
      'status': status,
      'totalMember': totalMember,
      'totalPrice': totalPrice,
      'checkIn': checkIn.toUtc().toIso8601String(),
      'checkOut': checkOut.toUtc().toIso8601String(),
      'contact': contact.toMap(),
      'orderActivities': orderActivities.map((x) => x.toMap()).toList(),
      'user': user.toMap(),
      'receiptImage': receiptImage,
    };
  }

  factory OrderCustomModel.fromMap(Map<String, dynamic> map) {
    return OrderCustomModel(
      id: map['_id'] ?? '',
      contactAdmin: ContactAdminModel.fromMap(map['contactAdmin']),
      status: map['status'] ?? 'รออนุมัติ',
      totalMember: map['totalMember']?.toInt() ?? 0,
      totalPrice: map['totalPrice']?.toDouble() ?? 0,
      checkIn: DateTime.parse(map['checkIn']).toLocal(),
      checkOut: DateTime.parse(map['checkOut']).toLocal(),
      contact: ContactModel.fromMapOrderCustom(map['contact']),
      orderActivities: List<OrderActivityModel>.from(
        map['orderActivities'].map(
          (x) => OrderActivityModel.fromMapCustom(x),
        ),
      ),
      user: UserModel.fromMap(map['user']),
      receiptImage: map['receiptImage'] ?? '',
    );
  }
}
