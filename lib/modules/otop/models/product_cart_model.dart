class ProductCartModel {
  String productId;
  String productName;
  String businessId;
  int amount;
  num totalPrice;
  num price;
  String businessName;
  String userId;
  String imageURL;
  num weight;
  num width;
  num height;
  num long;
  ProductCartModel({
    required this.productId,
    required this.productName,
    required this.businessId,
    required this.amount,
    required this.totalPrice,
    required this.price,
    required this.businessName,
    required this.userId,
    required this.imageURL,
    required this.weight,
    required this.width,
    required this.height,
    required this.long,
  });

  ProductCartModel copyWith({
    String? productId,
    String? productName,
    String? businessId,
    int? amount,
    num? totalPrice,
    num? price,
    String? businessName,
    String? userId,
    String? imageURL,
    String? addtionMessage,
    num? weight,
    num? width,
    num? height,
    num? long,
  }) {
    return ProductCartModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      businessId: businessId ?? this.businessId,
      amount: amount ?? this.amount,
      totalPrice: totalPrice ?? this.totalPrice,
      price: price ?? this.price,
      businessName: businessName ?? this.businessName,
      userId: userId ?? this.userId,
      imageURL: imageURL ?? this.imageURL,
      weight: weight ?? this.weight,
      width: width ?? this.width,
      height: height ?? this.height,
      long: long ?? this.long,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'productName': productName,
      'businessId': businessId,
      'amount': amount,
      'totalPrice': totalPrice,
      'price': price,
      'businessName': businessName,
      'userId': userId,
      'imageURL': imageURL,
      'weight': weight,
      'width': width,
      'height': height,
      'long': long,
    };
  }

  factory ProductCartModel.fromMap(Map<String, dynamic> map) {
    return ProductCartModel(
      productId: map['productId'],
      productName: map['productName'],
      businessId: map['businessId'],
      amount: map['amount']?.toInt(),
      totalPrice: map['totalPrice'],
      price: map['price'],
      businessName: map['businessName'],
      userId: map['userId'],
      imageURL: map['imageURL'],
      weight: map['weight'],
      width: map['width'],
      height: map['height'],
      long: map['long'],
    );
  }
}
