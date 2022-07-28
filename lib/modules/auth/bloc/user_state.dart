part of 'user_bloc.dart';

class UserState extends Equatable {
  final UserModel user;
  final bool eyesPassword;
  final bool hasError;
  final bool loading;
  final bool refresh;
  UserState({
    UserModel? user,
    this.hasError = false,
    this.loading = false,
    this.eyesPassword = true,
    this.refresh = false,
  }) : user = user ??
            UserModel(
              userId: '',
              username: '',
              firstName: '',
              lastName: '',
              roles: '',
              token: '',
              tokenDevice: '',
              profileRef: '',
            );

  @override
  List<Object> get props => [
        user,
        hasError,
        loading,
        refresh,
        eyesPassword,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
    };
  }

  factory UserState.fromMap(Map<String, dynamic> map) {
    return UserState(
      user: UserModel.fromMap(map['user']),
    );
  }
}
