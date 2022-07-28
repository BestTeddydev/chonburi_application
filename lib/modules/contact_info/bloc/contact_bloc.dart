import 'package:chonburi_mobileapp/modules/contact_info/models/contact_models.dart';
import 'package:chonburi_mobileapp/utils/services/contact_service.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends HydratedBloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactState()) {
    on<AddContactEvent>(_addContact);
    on<FetchContactsEvent>(_fetchsContacts);
    on<SelectContactEvent>(_selectContact);
    on<UpdateContactEvent>(_updateContact);
    on<DeleteContactEvent>(_deleteContact);
  }

  void _addContact(AddContactEvent event, Emitter<ContactState> emitter) async {
    try {
      emitter(ContactState(
        loading: true,
        contacts: state.contacts,
        myContact: state.myContact,
      ));
      ContactModel contact =
          await ContactService.createContact(event.contactModel, event.token);
      emitter(
        ContactState(
          loaded: true,
          loading: false,
          hasError: false,
          myContact: state.myContact,
          message: 'สร้างข้อมูลติดต่อเรียบร้อย',
          contacts: List.from(state.contacts)..add(contact),
        ),
      );
    } catch (e) {
      emitter(
        ContactState(
          loading: false,
          hasError: true,
          message: 'สร้างข้อมูลติดต่อล้มเหลว',
          myContact: state.myContact,
        ),
      );
    }
  }

  void _fetchsContacts(
      FetchContactsEvent event, Emitter<ContactState> emitter) async {
    try {
      emitter(ContactState(
        loading: true,
        contacts: state.contacts,
        myContact: state.myContact,
        loaded: state.loaded,
      ));
      List<ContactModel> dataContacts =
          await ContactService.fetchsContacts(event.token);
      emitter(
        ContactState(
          loading: false,
          loaded: true,
          contacts: dataContacts,
          myContact: state.myContact,
        ),
      );
    } catch (e) {
      emitter(
        ContactState(
          loading: false,
          hasError: true,
          loaded: state.loaded,
          message: 'เกิดข้อผิดพลาด ขออภัยในความไม่สะดวก',
          myContact: state.myContact,
        ),
      );
    }
  }

  void _selectContact(SelectContactEvent event, Emitter<ContactState> emitter) {
    emitter(
      ContactState(
        contacts: state.contacts,
        myContact: event.contactModel,
      ),
    );
  }

  void _updateContact(
    UpdateContactEvent event,
    Emitter<ContactState> emitter,
  ) async {
    try {
      emitter(
        ContactState(
          loading: true,
          contacts: state.contacts,
          myContact: state.myContact,
        ),
      );
      await ContactService.updateContact(
          event.contactModel.id, event.contactModel, event.token);
      final index = state.contacts
          .indexWhere((element) => element.id == event.contactModel.id);
      List<ContactModel> allContacts = List.from(state.contacts)
        ..removeWhere((contact) => contact.id == event.contactModel.id);
      allContacts.insert(index, event.contactModel);
      emitter(
        ContactState(
          loading: false,
          loaded: true,
          contacts: allContacts,
          myContact: state.myContact,
          message: 'อัพเดทข้อมูลเรียบร้อย',
        ),
      );
    } catch (e) {
      emitter(
        ContactState(
          loading: false,
          contacts: state.contacts,
          myContact: state.myContact,
          hasError: true,
          message: 'แก้ไขข้อมูลติดต่อล้มเหลว',
        ),
      );
    }
  }

  void _deleteContact(
      DeleteContactEvent event, Emitter<ContactState> emitter) async {
    try {
      emitter(
        ContactState(
          loading: true,
          contacts: state.contacts,
          myContact: state.myContact,
        ),
      );
      await ContactService.deleteContact(
        event.contactModel.id,
        event.token,
      );
      List<ContactModel> allContacts = List.from(state.contacts)
        ..removeWhere((contact) => contact.id == event.contactModel.id);
      emitter(
        ContactState(
          loading: false,
          loaded: true,
          contacts: allContacts,
          myContact: state.myContact,
          message: 'ลบข้อมูลเรียบร้อย',
        ),
      );
    } catch (e) {
      emitter(
        ContactState(
          loading: false,
          contacts: state.contacts,
          myContact: state.myContact,
          hasError: true,
          message: 'ลบข้อมูลติดต่อล้มเหลว',
        ),
      );
    }
  }

  @override
  ContactState? fromJson(Map<String, dynamic> json) {
    return ContactState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ContactState state) {
    return state.toMap();
  }
}
