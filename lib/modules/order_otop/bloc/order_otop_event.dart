part of 'order_otop_bloc.dart';

abstract class OrderOtopEvent extends Equatable {
  const OrderOtopEvent();

  @override
  List<Object> get props => [];
}

class UpdateOrderOtopEvent extends OrderOtopEvent {
  final OrderOtopModel orderOtopModel;
  final File imagePayment;
  final String token;
  const UpdateOrderOtopEvent({
    required this.orderOtopModel,
    required this.imagePayment,
    required this.token,
  });
}

class FetchMyOrdersOtopEvent extends OrderOtopEvent {
  final String token;
  final String businessId;
  const FetchMyOrdersOtopEvent({
    required this.token,
    required this.businessId,
  });
}

class SetInitOrderStatus extends OrderOtopEvent {
  final String status;
  const SetInitOrderStatus({
    required this.status,
  });
}

class ChangeStatusOrderEvent extends OrderOtopEvent {
  final String token;
  final OrderOtopModel order;
  const ChangeStatusOrderEvent({
    required this.token,
    required this.order,
  });
}
