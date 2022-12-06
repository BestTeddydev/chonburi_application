import 'package:chonburi_mobileapp/modules/auth/models/user_model.dart';
import 'package:chonburi_mobileapp/modules/businesses/models/business_models.dart';
import 'package:chonburi_mobileapp/modules/contact_info/models/contact_models.dart';
import 'package:chonburi_mobileapp/modules/otop/models/product_cart_model.dart';

class OrderOtopModel {
  String id;
  UserModel user;
  ContactModel contact;
  double totalPrice;
  double prepaidPrice;
  double shippingPrice;
  List<String> imagePayment;
  BusinessModel business;
  String status;
  bool reviewed;
  List<ProductCartModel> product;
  OrderOtopModel({
    required this.id,
    required this.user,
    required this.contact,
    required this.totalPrice,
    required this.prepaidPrice,
    required this.imagePayment,
    required this.business,
    required this.status,
    required this.reviewed,
    required this.product,
    required this.shippingPrice,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'contact': contact.toMapId(),
      'totalPrice': totalPrice,
      'prepaidPrice': prepaidPrice,
      'imagePayment': imagePayment,
      'business': business.toMapWithId(),
      'status': status,
      'reviewed': reviewed,
      'product': product.map((x) => x.toMap()).toList(),
      'shippingPrice': shippingPrice,
    };
  }

  factory OrderOtopModel.fromMap(Map<String, dynamic> map) {
    return OrderOtopModel(
      id: map['_id'] ?? '',
      user: UserModel.fromMap(map['user']),
      contact: ContactModel.fromMap(map['contact']),
      totalPrice: double.parse(map['totalPrice']),
      prepaidPrice: double.parse(map['prepaidPrice']),
      imagePayment: map['imagePayment'],
      business: BusinessModel.fromMap(map['business']),
      status: map['status'],
      reviewed: map['reviewed'] ?? '',
      product: List<ProductCartModel>.from(
          map['product'].map((x) => ProductCartModel.fromMap(x))),
      shippingPrice: double.parse(map['shippingPrice']),
    );
  }
}
