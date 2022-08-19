import 'package:chonburi_mobileapp/modules/auth/models/user_model.dart';
import 'package:chonburi_mobileapp/utils/services/user_service.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends HydratedBloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<UserLoginEvent>(_userLogin);
    on<UserLogoutEvent>(_userLogout);
    on<PressPasswordEvent>(_pressedPassword);
    on<UpdateDeviceTokenEvent>(_updateTokenDevice);
  }

  void _userLogin(UserLoginEvent event, Emitter<UserState> emitter) async {
    try {
      emitter(UserState(loading: true));
      UserModel userModel = await UserService.login(
        event.username,
        event.password,
      );
      emitter(UserState(user: userModel, hasError: false, loading: false));
    } catch (e) {
      emitter(UserState(hasError: true, loading: false));
    }
  }

  void _userLogout(UserLogoutEvent event, Emitter<UserState> emitter) {
    try {
      emitter(
        UserState(user: event.userModel),
      );
    } catch (e) {
      emitter(UserState(hasError: true));
    }
  }

  void _pressedPassword(PressPasswordEvent event, Emitter<UserState> emitter) {
    emitter(
      UserState(
        user: state.user,
        eyesPassword: !state.eyesPassword,
      ),
    );
  }

  void _updateTokenDevice(
      UpdateDeviceTokenEvent event, Emitter<UserState> emitter) async {
    try {
      if (state.user.token.isNotEmpty) {
        await UserService.updateTokenDevice(
            event.token, state.user.userId, state.user.token);
      }
      emitter(
        UserState(
          user: state.user.copyWith(tokenDevice: event.token),
        ),
      );
    } catch (e) {
      emitter(UserState(hasError: true));
    }
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    return UserState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    return state.toMap();
  }
}
