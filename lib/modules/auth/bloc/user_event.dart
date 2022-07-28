part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserLoginEvent extends UserEvent {
  final String username;
  final String password;
  const UserLoginEvent({
    required this.username,
    required this.password,
  });
}

class UserLogoutEvent extends UserEvent {
  final UserModel userModel;
  const UserLogoutEvent({
    required this.userModel,
  });
}

class PressPasswordEvent extends UserEvent {}
