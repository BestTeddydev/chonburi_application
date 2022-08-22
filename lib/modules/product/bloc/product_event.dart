part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchsProductEvent extends ProductEvent {
  final String businessId;
  const FetchsProductEvent({
    required this.businessId,
  });
}

class CreateProductEvent extends ProductEvent {
  final String token;
  final ProductModel productModel;
  const CreateProductEvent({
    required this.token,
    required this.productModel,
  });
}

class UpdateProductEvent extends ProductEvent {
  final String token;
  final ProductModel productModel;
  const UpdateProductEvent({
    required this.token,
    required this.productModel,
  });
}

class DeleteProductEvent extends ProductEvent {
  final String token;
  final ProductModel productModel;
  const DeleteProductEvent({
    required this.token,
    required this.productModel,
  });
}

class SelectImageProductEvent extends ProductEvent {
  final File imageRef;
  const SelectImageProductEvent({
    required this.imageRef,
  });
}

class UpdateStatusEvent extends ProductEvent {
  final String token;
  final ProductModel productModel;
  const UpdateStatusEvent({
    required this.token,
    required this.productModel,
  });
}
