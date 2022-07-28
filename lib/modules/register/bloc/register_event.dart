part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUserEvent extends RegisterEvent {
  final String? pathName;
  final UserRegisterModel userRegisterModel;
  const RegisterUserEvent({
    required this.pathName,
    required this.userRegisterModel,
  });
}

class SelectProfileRefEvent extends RegisterEvent {
  final File profileRef;
  const SelectProfileRefEvent({
    required this.profileRef,
  });
}
