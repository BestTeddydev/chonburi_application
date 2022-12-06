part of 'order_otop_bloc.dart';

class OrderOtopState extends Equatable {
  final List<OrderOtopModel> orders;
  final String orderStatus;
  final bool loading;
  final bool loaded;
  final bool hasError;
  final String message;
  const OrderOtopState({
    required this.orders,
    this.loading = false,
    this.hasError = false,
    this.loaded = false,
    this.message = '',
    this.orderStatus = "PAY_PREPAID",
  });

  @override
  List<Object> get props => [orders, loaded, loading, hasError, message,orderStatus];
}
