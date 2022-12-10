part of 'tracking_order_otop_bloc.dart';

class TrackingOrderOtopState extends Equatable {
  final List<OrderOtopModel> orders;
  final bool loading;
  final bool loaded;
  final bool hasError;
  final String message;
  final String orderStatus;
  final File imagePayment;

  TrackingOrderOtopState({
    required this.orders,
    this.loading = false,
    this.hasError = false,
    this.loaded = false,
    this.message = '',
    this.orderStatus = 'PAY_PREPAID',
    File? imagePayment,
  }) : imagePayment = imagePayment ?? File('');

  @override
  List<Object> get props => [
        orders,
        loaded,
        loading,
        hasError,
        message,
        orderStatus,
        imagePayment,
      ];
}
