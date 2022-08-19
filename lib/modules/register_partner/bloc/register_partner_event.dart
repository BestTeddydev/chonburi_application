part of 'register_partner_bloc.dart';

abstract class RegisterPartnerEvent extends Equatable {
  const RegisterPartnerEvent();

  @override
  List<Object> get props => [];
}

class PartnerRegisterEvent extends RegisterPartnerEvent {
  final PartnerModel partnerModel;
  const PartnerRegisterEvent({
    required this.partnerModel,
  });
}

class SelectProfileRefEvent extends RegisterPartnerEvent {
  final File profileRef;
  const SelectProfileRefEvent({
    required this.profileRef,
  });
}

class ShowPasswordEvent extends RegisterPartnerEvent {}
