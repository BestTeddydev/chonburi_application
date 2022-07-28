
class CategoryModel {
  String id;
  String categoryName;
  String businessId;
  List<Map<String, dynamic>> menu;
  CategoryModel({
    required this.id,
    required this.categoryName,
    required this.businessId,
    required this.menu,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'categoryName': categoryName,
      'businessId': businessId,
      'menu': menu,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      categoryName: map['categoryName'],
      businessId: map['businessId'],
      menu: List<Map<String, dynamic>>.from(map['menu'].map((x) =>x)),
    );
  }


}
