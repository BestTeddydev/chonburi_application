import 'package:bloc/bloc.dart';
import 'package:chonburi_mobileapp/modules/register_partner/models/partner_model.dart';
import 'package:chonburi_mobileapp/utils/services/partner_service.dart';
import 'package:equatable/equatable.dart';

part 'manage_partner_event.dart';
part 'manage_partner_state.dart';

class ManagePartnerBloc extends Bloc<ManagePartnerEvent, ManagePartnerState> {
  ManagePartnerBloc() : super(const ManagePartnerState(partners: [])) {
    on<FetchPartnerEvent>(_fetchPartners);
    on<ApprovePartnerEvent>(approvePartner);
    on<RejectPartnerEvent>(rejectPartner);
  }
  void _fetchPartners(
      FetchPartnerEvent event, Emitter<ManagePartnerState> emitter) async {
    try {
      List<PartnerModel> partners =
          await PartnerService.fetchsPartner(event.token, event.status);
      emitter(
        ManagePartnerState(
          partners: partners,
          loaded: true,
        ),
      );
    } catch (e) {
      emitter(
        ManagePartnerState(partners: state.partners, hasError: true),
      );
    }
  }

  void approvePartner(
      ApprovePartnerEvent event, Emitter<ManagePartnerState> emitter) async {
    try {
      await PartnerService.approvePartner(event.token, event.partner);
      emitter(
        ManagePartnerState(
          partners: state.partners,
          loaded: true,
          message: 'ยืนยันผู้ประกอบการเรียบร้อย',
        ),
      );
    } catch (e) {
      emitter(
        ManagePartnerState(
          partners: state.partners,
          hasError: true,
          message: 'ยืนยันผู้ประกอบการล้มเหลว',
        ),
      );
    }
  }

  void rejectPartner(
    RejectPartnerEvent event,
    Emitter<ManagePartnerState> emitter,
  ) async {
    try {
      await PartnerService.rejectPartner(event.token, event.docId);
      emitter(
        ManagePartnerState(
          partners: List.from(state.partners)
            ..removeWhere(
              (element) => element.id == event.docId,
            ),
          loaded: true,
          message: 'ปฏิเสธผู้ประกอบการเรียบร้อย',
        ),
      );
    } catch (e) {
      emitter(
        ManagePartnerState(
          partners: state.partners,
          hasError: true,
          message: 'ปฏิเสธผู้ประกอบการล้มเหลว',
        ),
      );
    }
  }
}
