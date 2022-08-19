class CategoryModel {
  String id;
  String categoryName;
  String businessId;
  CategoryModel({
    required this.id,
    required this.categoryName,
    required this.businessId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoryName': categoryName,
      'businessId': businessId,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['_id'],
      categoryName: map['categoryName'],
      businessId: map['businessId'],
    );
  }
}
