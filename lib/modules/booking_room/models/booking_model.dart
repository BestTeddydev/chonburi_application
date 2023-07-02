import 'package:chonburi_mobileapp/modules/businesses/models/business_models.dart';
import 'package:chonburi_mobileapp/modules/contact_info/models/contact_models.dart';
import 'package:chonburi_mobileapp/modules/manage_room/models/room_models.dart';

class BookingModel {
  String id;
  String userId;
  ContactModel contactInfo;
  num totalPrice;
  int totalRoom;
  num prepaidPrice;
  String imagePayment;
  String status;
  RoomModel roomId;
  bool reviewed;
  DateTime checkIn;
  DateTime checkOut;
  BusinessModel businessId;
  BookingModel({
    required this.id,
    required this.userId,
    required this.contactInfo,
    required this.totalPrice,
    required this.totalRoom,
    required this.prepaidPrice,
    required this.imagePayment,
    required this.status,
    required this.roomId,
    required this.reviewed,
    required this.checkIn,
    required this.checkOut,
    required this.businessId,
  });

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     "userId": userId,
  //     "contactInfo": contactInfo.toMap(),
  //     "totalPrice": totalPrice,
  //     "totalRoom": totalRoom,
  //     "prepaidPrice": prepaidPrice,
  //     "imagePayment": imagePayment,
  //     "status": status,
  //     "roomId": roomId,
  //     "reviewed": reviewed,
  //     "checkIn": checkIn.toUtc().toIso8601String(),
  //     "checkOut": checkOut.toUtc().toIso8601String(),
  //     "businessId": businessId.toMap(),
  //   };
  // }

  // factory BookingModel.fromMap(Map<String, dynamic> map) {
  //   return BookingModel(
  //     id: map["_id"] ?? '',
  //     userId: map["userId"] ?? '',
  //     contactInfo: ContactModel.fromMap(map["contactInfo"]),
  //     totalPrice: map["totalPrice"],
  //     totalRoom: map["totalRoom"]?.toInt(),
  //     prepaidPrice: map["prepaidPrice"],
  //     imagePayment: map["imagePayment"],
  //     status: map["status"] ?? '',
  //     roomId: map["roomId"] ?? '',
  //     reviewed: map["reviewed"],
  //     checkIn: DateTime.parse(map["checkIn"]).toLocal(),
  //     checkOut: DateTime.parse(map["checkOut"]).toLocal(),
  //     businessId: BusinessModel.fromMap(map["businessId"]),
  //   );
  // }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "userId": userId,
      "contactInfo": contactInfo.id,
      "totalPrice": totalPrice,
      "totalRoom": totalRoom,
      "prepaidPrice": prepaidPrice,
      "imagePayment": imagePayment,
      "status": status,
      "roomId": roomId.id,
      "reviewed": reviewed,
      "checkIn": checkIn.toUtc().toIso8601String(),
      "checkOut": checkOut.toUtc().toIso8601String(),
      "businessId": businessId.id,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map["_id"],
      userId: map["userId"],
      contactInfo: ContactModel.fromMap(map["contactInfo"]),
      totalPrice: map["totalPrice"],
      totalRoom: map["totalRoom"]?.toInt(),
      prepaidPrice: map["prepaidPrice"],
      imagePayment: map["imagePayment"],
      status: map["status"],
      roomId: RoomModel.fromMap(map["roomId"]),
      reviewed: map["reviewed"],
      checkIn: DateTime.parse(map["checkIn"]).toLocal(),
      checkOut: DateTime.parse(map["checkOut"]).toLocal(),
      businessId: BusinessModel.fromMap(map["businessId"]),
    );
  }
}
