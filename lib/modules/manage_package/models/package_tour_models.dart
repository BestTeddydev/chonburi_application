import 'package:chonburi_mobileapp/modules/manage_package/models/round_models.dart';

class PackageTourModel {
  String id;
  String packageName;
  String contactPhone;
  String contactName;
  String dayTrips;
  List<PackageRoundModel> round;
  List<String> dayForrent;
  String packageImage;
  String mark;
  String createdBy;
  double price;
  String introduce;
  String accountPayment;
  String imagePayment;
  String typePayment; // ธนาคาร... / พร้อมเพย์
  String description;
  PackageTourModel({
    required this.id,
    required this.packageName,
    required this.contactPhone,
    required this.contactName,
    required this.dayTrips,
    required this.round,
    required this.dayForrent,
    required this.packageImage,
    required this.mark,
    required this.createdBy,
    required this.price,
    required this.introduce,
    required this.accountPayment,
    required this.imagePayment,
    required this.typePayment,
    required this.description,
    
  });

  PackageTourModel copyWith({
    String? id,
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
  }) {
    return PackageTourModel(
      id: id ?? this.id,
      packageName: packageName ?? this.packageName,
      contactPhone: contactPhone ?? this.contactPhone,
      contactName: contactName ?? this.contactName,
      dayTrips: dayTrips ?? this.dayTrips,
      round: round ?? this.round,
      dayForrent: dayForrent ?? this.dayForrent,
      packageImage: packageImage ?? this.packageImage,
      mark: mark ?? this.mark,
      createdBy: createdBy ?? this.createdBy,
      price: price ?? this.price,
      introduce: introduce ?? this.introduce,
      accountPayment: accountPayment ?? this.accountPayment,
      imagePayment: imagePayment ?? this.imagePayment,
      typePayment: typePayment ?? this.typePayment,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // '_id': id,
      'packageName': packageName,
      'contactPhone': contactPhone,
      'contactName': contactName,
      'dayTrips': dayTrips,
      'round': round.map((x) => x.toMapActivityId()).toList(),
      'dayForrent': dayForrent,
      'packageImage': packageImage,
      'mark': mark,
      'createdBy': createdBy,
      'price': price,
      'introduce': introduce,
      'accountPayment': accountPayment,
      'imagePayment': imagePayment,
      'typePayment': typePayment,
      'description':description,
    };
  }

  factory PackageTourModel.fromMap(Map<String, dynamic> map) {
    return PackageTourModel(
      id: map['_id'],
      packageName: map['packageName'],
      contactPhone: map['contactPhone'],
      contactName: map['contactName'],
      dayTrips: map['dayTrips'],
      round: List<PackageRoundModel>.from(
          map['round'].map((x) => PackageRoundModel.fromMap(x))),
      dayForrent: List<String>.from(map['dayForrent']),
      packageImage: map['packageImage'],
      mark: map['mark'],
      createdBy: map['createdBy'],
      price: map['price']?.toDouble(),
      introduce: map['introduce'],
      accountPayment: map['accountPayment'] ?? '',
      imagePayment: map['imagePayment'] ?? '',
      typePayment: map['typePayment'] ?? '',
      description: map['description'] ?? '',
    );
  }

  factory PackageTourModel.fromMapBuyer(Map<String, dynamic>? map) {
    if (map != null) {
return PackageTourModel(
      id: map['_id'],
      packageName: map['packageName'],
      contactPhone: map['contactPhone'],
      contactName: map['contactName'],
      dayTrips: map['dayTrips'],
      round: List<PackageRoundModel>.from(
        map['round'].map(
          (x) => PackageRoundModel.fromMapActivityId(x),
        ),
      ),
      dayForrent: List<String>.from(map['dayForrent']),
      packageImage: map['packageImage'],
      mark: map['mark'],
      createdBy: map['createdBy'],
      price: map['price']?.toDouble(),
      introduce: map['introduce'],
      accountPayment: map['accountPayment'] ?? '',
      imagePayment: map['imagePayment'] ?? '',
      typePayment: map['typePayment'] ?? '',
      description: map['description'] ?? '',
    );
    }else {
      return PackageTourModel(
      id:'',
      packageName: 'ไม่พบแพ็คเกจ',
      contactPhone: '',
      contactName:'',
      dayTrips: '',
      round: [],
      dayForrent: [],
      packageImage: '',
      mark: '',
      createdBy: '',
      price:0,
      introduce: '',
      accountPayment: '',
      imagePayment: '',
      typePayment: '',
      description: '',
    );
    }
    
  }

  factory PackageTourModel.fromMapNull() {
    return PackageTourModel(
      id:'',
      packageName: 'ไม่พบแพ็คเกจ',
      contactPhone: '',
      contactName:'',
      dayTrips: '',
      round: [],
      dayForrent: [],
      packageImage: '',
      mark: '',
      createdBy: '',
      price:0,
      introduce: '',
      accountPayment: '',
      imagePayment: '',
      typePayment: '',
      description: '',
    );
  }


}
