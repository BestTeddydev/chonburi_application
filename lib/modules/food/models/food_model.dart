class FoodModel {
  String id;
  String foodName;
  double price;
  String imageRef;
  String businessId;
  String categoryId;
  String description;
  int status;
  FoodModel({
    required this.id,
    required this.foodName,
    required this.price,
    required this.imageRef,
    required this.businessId,
    required this.categoryId,
    required this.description,
    required this.status,
  });

  FoodModel copyWith({
    String? id,
    String? foodName,
    double? price,
    String? imageRef,
    String? businessId,
    String? categoryId,
    String? description,
    int? status,
  }) {
    return FoodModel(
      id: id ?? this.id,
      foodName: foodName ?? this.foodName,
      price: price ?? this.price,
      imageRef: imageRef ?? this.imageRef,
      businessId: businessId ?? this.businessId,
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'foodName': foodName,
      'price': price,
      'imageRef': imageRef,
      'businessId': businessId,
      'categoryId': categoryId,
      'description': description,
      'status': status,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      id: map['_id'],
      foodName: map['foodName'],
      price: map['price']?.toDouble(),
      imageRef: map['imageRef'],
      businessId: map['businessId'],
      categoryId: map['categoryId'],
      description: map['description'],
      status: map['status']?.toInt(),
    );
  }
}
