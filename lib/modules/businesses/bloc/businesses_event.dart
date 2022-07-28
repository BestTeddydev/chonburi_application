part of 'businesses_bloc.dart';

abstract class BusinessesEvent extends Equatable {
  const BusinessesEvent();

  @override
  List<Object> get props => [];
}
class FetchBusinesses extends BusinessesEvent {
  final String businessName;
  final String typeBusiness;
  const FetchBusinesses({
    required this.businessName,
    required this.typeBusiness,
  });
}
class FetchBusinessByIdEvent extends BusinessesEvent {
  final String docId;
  const FetchBusinessByIdEvent({
    required this.docId,
  });
}

class FetchBusinessOwnerEvent extends BusinessesEvent {
  final String token;
  final String typeBusiness;
  const FetchBusinessOwnerEvent({
    required this.token,
    required this.typeBusiness,
  });
}

class CreateBusinessEvent extends BusinessesEvent {
  final String token;
  final BusinessModel business;
  const CreateBusinessEvent({
    required this.token,
    required this.business,
  });
}

class UpdateBusinessEvent extends BusinessesEvent {
  final String token;
  final BusinessModel business;
  const UpdateBusinessEvent({
    required this.token,
    required this.business,
  });
}

class DeleteBusinessEvent extends BusinessesEvent {
  final String token;
  final String docId;
  const DeleteBusinessEvent({
    required this.token,
    required this.docId,
  });
}
class SelectImageCoverEvent extends BusinessesEvent {
  final File coverImage;
  const SelectImageCoverEvent({
    required this.coverImage,
  });
}

class SelectImageQRcodeEvent extends BusinessesEvent {
  final File qrcodeImage;
  const SelectImageQRcodeEvent({
    required this.qrcodeImage,
  });
}

class ChangeTypePaymentBusinessEvent extends BusinessesEvent {
  final String value;
  const ChangeTypePaymentBusinessEvent({
    required this.value,
  });
}
