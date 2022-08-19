part of 'manage_partner_bloc.dart';

class ManagePartnerState extends Equatable {
  final List<PartnerModel> partners;
  final bool loading;
  final bool loaded;
  final bool hasError;
  final String message;
  const ManagePartnerState({
    required this.partners,
    this.loaded = false,
    this.loading = false,
    this.hasError = false,
    this.message = '',
  });

  @override
  List<Object> get props => [partners, loaded, loading, hasError, message];
}
