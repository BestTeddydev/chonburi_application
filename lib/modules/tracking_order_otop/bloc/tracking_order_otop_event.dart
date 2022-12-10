part of 'tracking_order_otop_bloc.dart';

abstract class TrackingOrderOtopEvent extends Equatable {
  const TrackingOrderOtopEvent();

  @override
  List<Object> get props => [];
}

class CreateOrderOtopEvent extends TrackingOrderOtopEvent {
  final OrderOtopModel orderOtopModel;
  final File imagePayment;
  final String token;
  const CreateOrderOtopEvent({
    required this.orderOtopModel,
    required this.imagePayment,
    required this.token,
  });
}

class FetchOrdersOtopEvent extends TrackingOrderOtopEvent {
  final String token;
  final String userId;
  const FetchOrdersOtopEvent({
    required this.token,
    required this.userId,
  });
}

class BuyerUpdateOrderOtopEvent extends TrackingOrderOtopEvent {
  final OrderOtopModel orderOtopModel;
  final String token;
  final File imagePayment;
  const BuyerUpdateOrderOtopEvent({
    required this.orderOtopModel,
    required this.token,
    required this.imagePayment,
  });
}

class BuyerSetInitOrderStatusEvent extends TrackingOrderOtopEvent {
  final String status;
  const BuyerSetInitOrderStatusEvent({
    required this.status,
  });
}

class BuyerSelectImagePaymentEvent extends TrackingOrderOtopEvent {
  final File image;
  const BuyerSelectImagePaymentEvent({
    required this.image,
  });
}
