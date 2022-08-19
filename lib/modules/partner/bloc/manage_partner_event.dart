part of 'manage_partner_bloc.dart';

abstract class ManagePartnerEvent extends Equatable {
  const ManagePartnerEvent();

  @override
  List<Object> get props => [];
}

class FetchPartnerEvent extends ManagePartnerEvent {
  final String token;
  final bool status;
  const FetchPartnerEvent({
    required this.token,
    required this.status,
  });
}

class ApprovePartnerEvent extends ManagePartnerEvent {
  final String token;
  final PartnerModel partner;
  const ApprovePartnerEvent({
    required this.token,
    required this.partner,
  });
}

class RejectPartnerEvent extends ManagePartnerEvent {
  final String token;
  final String docId;
  const RejectPartnerEvent({
    required this.token,
    required this.docId,
  });
}
