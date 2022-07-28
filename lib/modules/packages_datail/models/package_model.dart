// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';

class PackageModel {
  String id;
  String packageName;
  String contactPhone;
  String contactName;
  String dayTrips; // type : 1d || 2d1n
  List<String> activityId;
  List<String> dayForrent; // วันที่สามารถซื้อแพ็คเกจได้ เช่น ส. อา.
  String packageImage;
  String mark;
  String createdBy;
  double price; // ราคาเบื้องต้นของแพ็คเกจเช่น ค่ารถตู้
  String accountPayment;
  String imagePayment;
  String typePayment; // ธนาคาร... / พร้อมเพย์
  PackageModel({
    required this.id,
    required this.packageName,
    required this.contactPhone,
    required this.contactName,
    required this.dayTrips,
    required this.activityId,
    required this.dayForrent,
    required this.packageImage,
    required this.mark,
    required this.createdBy,
    required this.price,
    required this.accountPayment,
    required this.imagePayment,
    required this.typePayment,
  });

  PackageModel copyWith({
    String? id,
    String? packageName,
    String? contactPhone,
    String? contactName,
    String? dayTrips,
    List<String>? activityId,
    List<String>? dayForrent,
    String? packageImage,
    String? mark,
    String? createdBy,
    double? price,
    String? accountPayment,
    String? imagePayment,
    String? typePayment,
  }) {
    return PackageModel(
      id: id ?? this.id,
      packageName: packageName ?? this.packageName,
      contactPhone: contactPhone ?? this.contactPhone,
      contactName: contactName ?? this.contactName,
      dayTrips: dayTrips ?? this.dayTrips,
      activityId: activityId ?? this.activityId,
      dayForrent: dayForrent ?? this.dayForrent,
      packageImage: packageImage ?? this.packageImage,
      mark: mark ?? this.mark,
      createdBy: createdBy ?? this.createdBy,
      price: price ?? this.price,
      accountPayment: accountPayment ?? this.accountPayment,
      imagePayment: imagePayment ?? this.imagePayment,
      typePayment: typePayment ?? this.typePayment,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'packageName': packageName,
      'contactPhone': contactPhone,
      'contactName': contactName,
      'dayTrips': dayTrips,
      'activityId': activityId,
      'dayForrent': dayForrent,
      'packageImage': packageImage,
      'mark': mark,
      'createdBy': createdBy,
      'price': price,
    };
  }

  factory PackageModel.fromMap(Map<String, dynamic> map) {
    return PackageModel(
      id: map['_id'] ?? '',
      packageName: map['packageName'] ?? '',
      contactPhone: map['contactPhone'] ?? '',
      contactName: map['contactName'] ?? '',
      dayTrips: map['dayTrips'] ?? '',
      activityId: List<String>.from((map['activityId'])),
      dayForrent: List<String>.from((map['dayForrent'])),
      packageImage: map['packageImage'] ?? '',
      mark: map['mark'] ?? '',
      createdBy: map['createdBy'] ?? '',
      price: map['price'] ?? 0,
      accountPayment: map['accountPayment'] ?? '',
      imagePayment: map['imagePayment'] ?? '',
      typePayment: map['typePayment'] ?? '',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PackageModel &&
        other.id == id &&
        other.packageName == packageName &&
        other.contactPhone == contactPhone &&
        other.contactName == contactName &&
        other.dayTrips == dayTrips &&
        listEquals(other.activityId, activityId) &&
        listEquals(other.dayForrent, dayForrent) &&
        other.packageImage == packageImage &&
        other.mark == mark &&
        other.createdBy == createdBy &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        packageName.hashCode ^
        contactPhone.hashCode ^
        contactName.hashCode ^
        dayTrips.hashCode ^
        activityId.hashCode ^
        dayForrent.hashCode ^
        packageImage.hashCode ^
        mark.hashCode ^
        createdBy.hashCode ^
        price.hashCode;
  }
}
