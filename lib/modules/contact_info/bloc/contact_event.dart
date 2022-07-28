part of 'contact_bloc.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class FetchContactsEvent extends ContactEvent {
  final String token;
  const FetchContactsEvent({
    required this.token,
  });
}
class SelectContactEvent extends ContactEvent {
  final ContactModel contactModel;
  const SelectContactEvent({
    required this.contactModel,
  });
}
class AddContactEvent extends ContactEvent {
  final ContactModel contactModel;
  final String token;
  const AddContactEvent({
    required this.contactModel,
    required this.token,
  });
}
class UpdateContactEvent extends ContactEvent {
  final ContactModel contactModel;
  final String token;
  const UpdateContactEvent({
    required this.contactModel,
    required this.token,
  });
}
class DeleteContactEvent extends ContactEvent {
  final ContactModel contactModel;
  final String token;
  const DeleteContactEvent({
    required this.contactModel,
    required this.token,
  });
}
