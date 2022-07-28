part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final bool loading;
  final bool hasError;
  final bool loaded;
  final String message;
  final File profileRef;
  RegisterState({
    this.hasError = false,
    this.loaded = false,
    this.loading = false,
    this.message = '',
    File? profileRef,
  }) : profileRef = profileRef ?? File('');

  @override
  List<Object> get props => [loaded, loading, hasError, profileRef];
}
