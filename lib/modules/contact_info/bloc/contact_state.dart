part of 'contact_bloc.dart';

class ContactState extends Equatable {
  final ContactModel myContact;
  final List<ContactModel> contacts;
  final bool loading;
  final bool hasError;
  final bool loaded;
  final String message;
  ContactState({
    this.contacts = const <ContactModel>[],
    ContactModel? myContact,
    this.hasError = false,
    this.loaded = false,
    this.loading = false,
    this.message = '',
  }) : myContact = myContact ??
            ContactModel(
              userId: '',
              fullName: '',
              address: '',
              phoneNumber: '',
              lat: 0,
              lng: 0,
              id: '',
            );

  @override
  List<Object> get props => [
        myContact,
        contacts,
        loaded,
        loading,
        hasError,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'myContact': myContact.toMapId(),
    };
  }

  factory ContactState.fromMap(Map<String, dynamic> map) {
    return ContactState(
      myContact: ContactModel.fromMap(map['myContact']),
    );
  }
}
