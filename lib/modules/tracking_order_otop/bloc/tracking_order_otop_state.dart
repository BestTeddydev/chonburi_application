part of 'tracking_order_otop_bloc.dart';

class TrackingOrderOtopState extends Equatable {
  final List<OrderOtopModel> orders;
  final bool loading;
  final bool loaded;
  final bool hasError;
  final String message;
  const TrackingOrderOtopState({
    required this.orders,
    this.loading = false,
    this.hasError = false,
    this.loaded = false,
    this.message = '',
  });

  @override
  List<Object> get props => [orders, loaded, loading, hasError, message];
}
