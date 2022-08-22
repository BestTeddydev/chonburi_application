part of 'product_bloc.dart';

class ProductState extends Equatable {
  final List<ProductModel> products;
  final File imageProduct;
  final bool loading;
  final bool loaded;
  final bool hasError;
  final String message;
  ProductState({
    required this.products,
    this.hasError = false,
    this.loaded = false,
    this.loading = false,
    this.message = '',
    File? imageProduct,
  }) : imageProduct = imageProduct ?? File('');

  @override
  List<Object> get props =>
      [products, loaded, loading, message, hasError, imageProduct];
}
