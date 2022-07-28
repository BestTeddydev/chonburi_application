part of 'order_package_bloc.dart';

abstract class OrderPackageEvent extends Equatable {
  const OrderPackageEvent();

  @override
  List<Object> get props => [];
}

class CreateOrderPackageEvent extends OrderPackageEvent {
  final OrderPackageModel orderPackageModel;
  final String token;
  const CreateOrderPackageEvent({
    required this.orderPackageModel,
    required this.token,
  });
}

class FetchsOrderPackageEvent extends OrderPackageEvent {
  final String token;
  final String id;
  final String businessId;
  final String packageId;
  const FetchsOrderPackageEvent({
    required this.token,
     this.id = '',
     this.businessId = '',
     this.packageId = '',
  });
}
class UpdateOrderPackageEvent extends OrderPackageEvent {
  final String token;
  final String status;
  final String docId;
  const UpdateOrderPackageEvent({
    required this.token,
    required this.status,
    required this.docId,
  });
}

class BillOrderPackageEvent extends OrderPackageEvent {
  final String token;
  final String status;
  final String docId;
  const BillOrderPackageEvent({
    required this.token,
    required this.status,
    required this.docId,
  });
  
}

class SelectImageReceiptEvent extends OrderPackageEvent {
  final File image;
  const SelectImageReceiptEvent({
    required this.image,
  });
}
