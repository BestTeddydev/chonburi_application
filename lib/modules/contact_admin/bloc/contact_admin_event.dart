part of 'contact_admin_bloc.dart';

abstract class ContactAdminEvent extends Equatable {
  const ContactAdminEvent();

  @override
  List<Object> get props => [];
}

class AdminCreateContactEvent extends ContactAdminEvent {
  final ContactAdminModel contactAdminModel;
  final String token;
  const AdminCreateContactEvent({
    required this.contactAdminModel,
    required this.token,
  });
}

class FetchsContactAdminEvent extends ContactAdminEvent {}

// user select contact admin
class SelectContactAdminEvent extends ContactAdminEvent {
  final ContactAdminModel contactAdminModel;
  const SelectContactAdminEvent({
    required this.contactAdminModel,
  });
}
