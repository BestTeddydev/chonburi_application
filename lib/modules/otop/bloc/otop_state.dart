part of 'otop_bloc.dart';

class OtopState extends Equatable {
  final List<BusinessModel> otops;
  final BusinessModel otop;
  final List<CategoryModel> categories;
  final List<ProductModel> products;
  final List<ProductCartModel> cartProduct;
  final bool loading;
  final bool loaded;
  final bool hasError;
  final String message;
  final bool isSearched;
  final List<ProductModel> introducesProds;
  final File imagePayment;
  OtopState({
    this.otops = const [],
    this.categories = const [],
    this.products = const [],
    this.cartProduct = const [],
    this.hasError = false,
    this.loaded = false,
    this.loading = false,
    this.message = '',
    this.isSearched = false,
    this.introducesProds = const [],
    File? imagePayment,
    BusinessModel? otop,
  })  : otop = otop ??
            BusinessModel(
              id: '',
              businessName: '',
              sellerId: '',
              address: '',
              latitude: 0,
              longitude: 0,
              statusOpen: false,
              ratingCount: 0,
              point: 0,
              paymentNumber: '',
              qrcodeRef: '',
              phoneNumber: '',
              imageRef: '',
              ratePrice: 0,
              typeBusiness: 'otop',
              typePayment: '',
              introduce: '',
            ),
        imagePayment = imagePayment ?? File('');

  @override
  List<Object> get props => [
        otops,
        categories,
        products,
        loaded,
        loading,
        hasError,
        message,
        isSearched,
        cartProduct,
        otop,
        introducesProds,
        imagePayment,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cartProduct': cartProduct.map((x) => x.toMap()).toList(),
    };
  }

  factory OtopState.fromMap(Map<String, dynamic> map) {
    return OtopState(
      cartProduct: List<ProductCartModel>.from(
          map['cartProduct'].map((x) => ProductCartModel.fromMap(x))),
    );
  }
}
