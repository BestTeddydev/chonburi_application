import 'package:bloc/bloc.dart';
import 'package:chonburi_mobileapp/modules/contact_admin/models/contact_admin_model.dart';
import 'package:chonburi_mobileapp/utils/services/contact_admin_service.dart';
import 'package:equatable/equatable.dart';

part 'contact_admin_event.dart';
part 'contact_admin_state.dart';

class ContactAdminBloc extends Bloc<ContactAdminEvent, ContactAdminState> {
  ContactAdminBloc() : super(ContactAdminState()) {
    on<AdminCreateContactEvent>(createContactAdmin);
    on<FetchsContactAdminEvent>(fetchsContactsAdmin);
    on<SelectContactAdminEvent>(selectContactAdmin);
  }

  void createContactAdmin(
    AdminCreateContactEvent event,
    Emitter<ContactAdminState> emitter,
  ) async {
    try {
      await ContactAdminService.createContact(
        event.contactAdminModel,
        event.token,
      );
      emitter(
        ContactAdminState(
          contacts: state.contacts,
          isLoaded: true,
          selectContact: state.selectContact,
        ),
      );
    } catch (e) {
      emitter(
        ContactAdminState(
          contacts: state.contacts,
          isError: true,
          selectContact: state.selectContact,
        ),
      );
    }
  }

  void fetchsContactsAdmin(
    FetchsContactAdminEvent event,
    Emitter<ContactAdminState> emitter,
  ) async {
    List<ContactAdminModel> contacts =
        await ContactAdminService.fetchsContacts();
    emitter(
      ContactAdminState(
        contacts: contacts,
        selectContact: state.selectContact,
      ),
    );
  }

  void selectContactAdmin(
    SelectContactAdminEvent event,
    Emitter<ContactAdminState> emitter,
  ) {
    emitter(
      ContactAdminState(
        contacts: state.contacts,
        selectContact: event.contactAdminModel,
      ),
    );
  }
}
