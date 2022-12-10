import 'package:chonburi_mobileapp/modules/manage_activity/models/activity_model.dart';

class PackageDetailModel {
  String id;
  String packageName;
  String contactPhone;
  String contactName;
  String dayTrips;
  List<ActivityModel> activityId;
  List<String> dayForrent;
  String packageImage;
  String mark;
  String createdBy;
  double price;
  String introduce;
  PackageDetailModel({
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
    required this.introduce,
  });

  PackageDetailModel copyWith({
    String? id,
    String? packageName,
    String? contactPhone,
    String? contactName,
    String? dayTrips,
    List<ActivityModel>? activityId,
    List<String>? dayForrent,
    String? packageImage,
    String? mark,
    String? createdBy,
    double? price,
    String? introduce,
  }) {
    return PackageDetailModel(
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
      introduce: introduce ?? this.introduce,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'packageName': packageName,
      'contactPhone': contactPhone,
      'contactName': contactName,
      'dayTrips': dayTrips,
      'activityId': activityId.map((x) => x.toMap()).toList(),
      'dayForrent': dayForrent,
      'packageImage': packageImage,
      'mark': mark,
      'createdBy': createdBy,
      'price': price,
      'introduce':introduce,
    };
  }

  factory PackageDetailModel.fromMap(Map<String, dynamic> map) {
    return PackageDetailModel(
      id: map['_id'] ?? '',
      packageName: map['packageName'] ?? '',
      contactPhone: map['contactPhone'] ?? '',
      contactName: map['contactName'] ?? '',
      dayTrips: map['dayTrips'] ?? '',
      activityId: List<ActivityModel>.from(
        (map['activityId']).map<ActivityModel>(
          (x) => ActivityModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      dayForrent: List<String>.from((map['dayForrent'])),
      packageImage: map['packageImage'] ?? '',
      mark: map['mark'] ?? '',
      createdBy: map['createdBy'] ?? '',
      price: map['price'] ?? 0,
      introduce:map['introduce'] ?? ''
    );
  }
}
