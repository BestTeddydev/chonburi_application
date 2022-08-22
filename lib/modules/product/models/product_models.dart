class ProductModel {
  String id;
  String productName;
  double price;
  String imageRef;
  String businessId;
  String categoryId;
  String description;
  bool status;
  double weight;
  double width;
  double height;
  double long;
  ProductModel({
    required this.id,
    required this.productName,
    required this.price,
    required this.imageRef,
    required this.businessId,
    required this.categoryId,
    required this.description,
    required this.status,
    required this.weight,
    required this.width,
    required this.height,
    required this.long,
  });

  ProductModel copyWith({
    String? id,
    String? productName,
    double? price,
    String? imageRef,
    String? businessId,
    String? categoryId,
    String? description,
    bool? status,
    double? weight,
    double? width,
    double? height,
    double? long,
  }) {
    return ProductModel(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      imageRef: imageRef ?? this.imageRef,
      businessId: businessId ?? this.businessId,
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      status: status ?? this.status,
      weight: weight ?? this.weight,
      width: width ?? this.width,
      height: height ?? this.height,
      long: long ?? this.long,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productName': productName,
      'price': price,
      'imageRef': imageRef,
      'businessId': businessId,
      'categoryId': categoryId,
      'description': description,
      'status': status,
      'weight': weight,
      'width': width,
      'height': height,
      'long': long,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['_id'],
      productName: map['productName'],
      price: map['price']?.toDouble(),
      imageRef: map['imageRef'],
      businessId: map['businessId'],
      categoryId: map['categoryId'],
      description: map['description'],
      status: map['status'],
      weight: map['weight']?.toDouble(),
      width: map['width']?.toDouble(),
      height: map['height']?.toDouble(),
      long: map['long']?.toDouble(),
    );
  }
}
