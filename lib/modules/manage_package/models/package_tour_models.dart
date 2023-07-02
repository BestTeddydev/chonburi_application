import 'package:chonburi_mobileapp/modules/contact_admin/models/contact_admin_model.dart';
import 'package:chonburi_mobileapp/modules/manage_package/models/round_models.dart';

class PackageTourModel {
  String id;
  String packageName;
  String dayTrips;
  List<PackageRoundModel> round;
  List<String> dayForrent;
  String packageImage;
  String mark;
  String createdBy;
  double price;
  String introduce;
  ContactAdminModel contactAdmin;
  String description;
  PackageTourModel({
    required this.id,
    required this.packageName,
    required this.dayTrips,
    required this.round,
    required this.dayForrent,
    required this.packageImage,
    required this.mark,
    required this.createdBy,
    required this.price,
    required this.introduce,
    required this.description,
    required this.contactAdmin,
  });

  PackageTourModel copyWith(
      {String? id,
      String? packageName,
      String? contactPhone,
      String? contactName,
      String? dayTrips,
      List<PackageRoundModel>? round,
      List<String>? dayForrent,
      String? packageImage,
      String? mark,
      String? createdBy,
      double? price,
      String? introduce,
      String? accountPayment,
      String? imagePayment,
      String? typePayment,
      String? description,
      ContactAdminModel? contactAdmin}) {
    return PackageTourModel(
      id: id ?? this.id,
      packageName: packageName ?? this.packageName,
      dayTrips: dayTrips ?? this.dayTrips,
      round: round ?? this.round,
      dayForrent: dayForrent ?? this.dayForrent,
      packageImage: packageImage ?? this.packageImage,
      mark: mark ?? this.mark,
      createdBy: createdBy ?? this.createdBy,
      price: price ?? this.price,
      introduce: introduce ?? this.introduce,
      description: description ?? this.description,
      contactAdmin: contactAdmin ?? this.contactAdmin,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'packageName': packageName,
      'dayTrips': dayTrips,
      'round': round.map((x) => x.toMapActivityId()).toList(),
      'dayForrent': dayForrent,
      'packageImage': packageImage,
      'mark': mark,
      'createdBy': createdBy,
      'price': price,
      'introduce': introduce,
      'description': description,
      'contactAdmin': contactAdmin.toMap(),
    };
  }

  factory PackageTourModel.fromMap(Map<String, dynamic> map) {
    return PackageTourModel(
      id: map['_id'],
      packageName: map['packageName'],
      dayTrips: map['dayTrips'],
      round: List<PackageRoundModel>.from(
          map['round'].map((x) => PackageRoundModel.fromMap(x))),
      dayForrent: List<String>.from(map['dayForrent']),
      packageImage: map['packageImage'],
      mark: map['mark'],
      createdBy: map['createdBy'],
      price: map['price']?.toDouble(),
      introduce: map['introduce'],
      description: map['description'] ?? '',
      contactAdmin: ContactAdminModel.fromMap(map['contactAdmin']),
    );
  }

  factory PackageTourModel.fromMapBuyer(Map<String, dynamic>? map) {
    if (map != null) {
      return PackageTourModel(
        id: map['_id'] ?? '',
        packageName: map['packageName'] ?? '',
        dayTrips: map['dayTrips'] ?? '',
        round: List<PackageRoundModel>.from(
          map['round'].map(
            (x) => PackageRoundModel.fromMapActivityId(x),
          ),
        ),
        dayForrent: List<String>.from(map['dayForrent']),
        packageImage: map['packageImage'] ?? '',
        mark: map['mark'] ?? '',
        createdBy: map['createdBy'] ?? '',
        price: map['price']?.toDouble(),
        introduce: map['introduce'] ?? '',
        description: map['description'] ?? '',
        contactAdmin: ContactAdminModel.fromMap(map['contactAdmin']),
      );
    } else {
      return PackageTourModel(
        id: '',
        packageName: 'ไม่พบแพ็คเกจ',
        dayTrips: '',
        round: [],
        dayForrent: [],
        packageImage: '',
        mark: '',
        createdBy: '',
        price: 0,
        introduce: '',
        description: '',
        contactAdmin: ContactAdminModel(
          accountPayment: '',
          address: '',
          createdBy: '',
          fullName: '',
          id: '',
          phoneNumber: '',
          typePayment: '',
          imagePayment: '',
          profileRef: '',
        ),
      );
    }
  }

  factory PackageTourModel.fromMapNull() {
    return PackageTourModel(
      id: '',
      packageName: 'ไม่พบแพ็คเกจ',
      dayTrips: '',
      round: [],
      dayForrent: [],
      packageImage: '',
      mark: '',
      createdBy: '',
      price: 0,
      introduce: '',
      description: '',
      contactAdmin: ContactAdminModel(
        accountPayment: '',
        address: '',
        createdBy: '',
        fullName: '',
        id: '',
        phoneNumber: '',
        typePayment: '',
        imagePayment: '',
        profileRef: '',
      ),
    );
  }
}
