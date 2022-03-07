import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:redux/redux.dart';

import '../../core/const.dart';
import '../../model/state.dart';
import '../../model/user.dart';
import '../../service/nav.dart';
import 'features/login.dart';
import 'features/register.dart';

part 'auth.freezed.dart';

class AuthView extends StatelessWidget with GetItMixin {
  AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final AuthMiddleware middleware = get();
    final INav nav = get();
    return StoreConnector<MyDexState, AuthState>(
      converter: (_) => _.state.authState,
      builder: (ctx, _) => nav.getBy(Const.loginView),
    );
  }
}

class AuthMiddleware {}

class AuthReducer {
  static Reducer<AuthState> reduce = combineReducers<AuthState>([
    TypedReducer<AuthState, OwnerChanged>((s, _) => s.copyWith(owner: _.owner)),
    TypedReducer<AuthState, AuthChanged>((s, _) => s.copyWith(isAuthed: _.auth)),
    TypedReducer<AuthState, RegisterAction>(registerSelector),
    TypedReducer<AuthState, LoginAction>(loginSelector),
  ]);

  static var loginSelector = TypedReducer<AuthState, LoginAction>((state, action) => //
      state.copyWith(loginState: LoginReducer.reduce(state.loginState, action)));

  static var registerSelector = TypedReducer<AuthState, RegisterAction>((state, action) => //
      state.copyWith(registerState: RegisterReducer.reduce(state.registerState, action)));
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(User()) User owner,
    @Default(false) bool isAuthed,
    @Default(LoginState()) LoginState loginState,
    @Default(RegisterState()) RegisterState registerState,
  }) = _AuthState;
}

class AuthActions {}

@freezed
class AuthAction with _$AuthAction implements AuthActions {
  const factory AuthAction.authChanged(bool auth) = AuthChanged;
  const factory AuthAction.ownerChanged(User owner) = OwnerChanged;
}
