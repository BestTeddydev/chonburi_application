part of 'contact_admin_bloc.dart';

class ContactAdminState extends Equatable {
  final List<ContactAdminModel> contacts;
  final ContactAdminModel selectContact;
  final bool isLoaded;
  final bool isError;
  ContactAdminState({
    this.contacts = const [],
    this.isError = false,
    this.isLoaded = false,
    ContactAdminModel? selectContact,
  }) : selectContact = selectContact ??
            ContactAdminModel(
              id: '',
              fullName: '',
              address: '',
              phoneNumber: '',
              typePayment: '',
              accountPayment: '',
              createdBy: '',
              imagePayment: '',
              profileRef: '',
            );

  @override
  List<Object> get props => [contacts, selectContact, isError, isLoaded];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'selectContact': selectContact.toMap(),
    };
  }

  factory ContactAdminState.fromMap(Map<String, dynamic> map) {
    return ContactAdminState(
      selectContact: ContactAdminModel.fromMap(map['selectContact']),
    );
  }
}
