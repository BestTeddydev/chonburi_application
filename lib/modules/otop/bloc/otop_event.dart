part of 'otop_bloc.dart';

abstract class OtopEvent extends Equatable {
  const OtopEvent();

  @override
  List<Object> get props => [];
}

class FetchsOtopsEvent extends OtopEvent {
  final String search;
  final String typeBusiness;
  final bool statusSearch;
  const FetchsOtopsEvent({
    required this.search,
    required this.typeBusiness,
    required this.statusSearch,
  });
}

class FetchOtopEvent extends OtopEvent {
  final String businessId;
  const FetchOtopEvent({
    required this.businessId,
  });
}

class FetchsCategoryOtopEvent extends OtopEvent {
  final String businessId;
  const FetchsCategoryOtopEvent({
    required this.businessId,
  });
}

class FetchsProductsEvent extends OtopEvent {
  final String businessId;
  const FetchsProductsEvent({
    required this.businessId,
  });
}

class FetchsIntroduceProductsEvent extends OtopEvent {}

class AddProductToCartEvent extends OtopEvent {
  final ProductCartModel productCart;
  const AddProductToCartEvent({
    required this.productCart,
  });
}

class UpdateProductInCartEvent extends OtopEvent {
  final ProductCartModel productCart;
  const UpdateProductInCartEvent({
    required this.productCart,
  });
}

class ClearCartProductEvent extends OtopEvent {}
class SelectPaymentImageEvent extends OtopEvent {
  final File image;
  const SelectPaymentImageEvent({
    required this.image,
  });
}
class ClearCartProductOfBusinessEvent extends OtopEvent {
  final String businessId;
  const ClearCartProductOfBusinessEvent({
    required this.businessId,
  });
  
}
