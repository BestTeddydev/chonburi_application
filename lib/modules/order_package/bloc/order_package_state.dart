part of 'order_package_bloc.dart';

class OrderPackageState extends Equatable {
  final List<OrderPackageModel> ordersPackages;
  final List<OrderCustomModel> orderCustomPackages;
  final bool loading;
  final bool loaded;
  final bool hasError;
  final String message;
  final File reciepImage;
   OrderPackageState({
    required this.ordersPackages,
    required this.orderCustomPackages,
    this.hasError = false,
    this.loaded = false,
    this.loading = false,
    this.message = '',
    File? reciepImage,
  }):reciepImage = reciepImage ?? File('');

  @override
  List<Object> get props => [
        ordersPackages,
        loaded,
        loading,
        hasError,
        message,
        reciepImage
      ];
}
