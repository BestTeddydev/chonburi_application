part of 'register_partner_bloc.dart';

 class RegisterPartnerState extends Equatable {
  final bool loading;
  final bool hasError;
  final bool loaded;
  final String message;
  final bool eyePassword;
  final File profileRef;
  RegisterPartnerState({
    this.hasError = false,
    this.loaded = false,
    this.loading = false,
    this.message = '',
    this.eyePassword = true,
    File? profileRef,
  }) : profileRef = profileRef ?? File('');

  @override
  List<Object> get props => [loaded, loading, hasError, profileRef,eyePassword];
}

