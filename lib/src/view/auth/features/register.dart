import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:redux/redux.dart';

import '../../../core/const.dart';
import '../../../core/extensions.dart';
import '../../../core/types.dart';
import '../../../core/view.dart';
import '../../../model/state.dart';
import '../../../model/user.dart';
import '../../../service/nav.dart';
import '../auth.dart';

part 'register.freezed.dart';

class RegisterView extends StatelessWidget with GetItMixin {
  RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegisterMiddleware middleware = get();
    final INav nav = get();
    return StoreConnector<MyDexState, RegisterVM>(
      converter: (store) => RegisterVM.fromStore(store, middleware),
      builder: (ctx, _) => Scaffold(
        appBar: const Text(Const.registerTitle).appBar(),
        body: View.frame([
          View.singleCard([
            RegisterView.fieldsView(_),
            RegisterView.buttonsView(_, nav.goBack(context)),
          ])
        ]),
      ),
    );
  }

  static Widget fieldsView(RegisterVM vm) => Column(children: [
        const Text(Const.nameLabel) //
            .inputDecor(vm.state.errors[Const.nameLabel])
            .textField(vm.onNameChanged)
            .padding(24.h.onlyBottom()),
        const Text(Const.emailLabel) //
            .inputDecor(vm.state.errors[Const.emailLabel])
            .textField(vm.onEmailChanged)
            .padding(24.h.onlyBottom()),
        const Text(Const.passwordLabel) //
            .inputDecor(vm.state.errors[Const.passwordLabel])
            .textField(vm.onPasswordChanged)
            .padding(12.h.onlyBottom()),
      ]);

  static Widget buttonsView(RegisterVM vm, Runnable onBackClick) => [
        const Text(Const.loginBtn).textButton(onBackClick),
        const Text(Const.submitBtn).elevatedButton(vm.onSubmit(onBackClick)),
      ].row(MainAxisAlignment.end);
}

class RegisterMiddleware {
  final UserRepo userRepo;

  RegisterMiddleware(this.userRepo);

  String? validateName(String name) {
    if (name.isEmpty) return Const.nameIsBlankTxt;
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) return Const.passwordBlankTxt;
    return null;
  }

  String? validateEmail(String email, String cached) {
    if (email.isEmpty) return Const.emailBlankTxt;
    if (!email.contains('@')) return Const.emailInvalidTxt;
    if (cached.isNotEmpty) return Const.emailAlreadyExistTxt;
    return null;
  }

  Func<MyDexStore, Future<void>> onRegisterSubmit(Runnable onComplete) => (store) async {
        RegisterState state = store.state.authState.registerState;
        var cached = await userRepo.doGet(state.emailText);

        var nameError = validateName(state.nameText);
        store.dispatch(RegisterAction.errorsChanged(Const.nameLabel, nameError));

        var emailError = validateEmail(state.emailText, cached.email);
        store.dispatch(RegisterAction.errorsChanged(Const.emailLabel, emailError));

        var passwordError = validatePassword(state.passwordText);
        store.dispatch(RegisterAction.errorsChanged(Const.passwordLabel, passwordError));

        if (nameError != null || emailError != null || passwordError != null) return;
        await userRepo.doInsert([User(id: 1, name: state.nameText, email: state.emailText, password: state.passwordText)]);
        onComplete();
      };
}

class RegisterVM {
  final RegisterState state;
  final Consumer<String> onNameChanged;
  final Consumer<String> onEmailChanged;
  final Consumer<String> onPasswordChanged;
  final Func<Runnable, Runnable> onSubmit;
  RegisterVM({
    required this.state,
    required this.onNameChanged,
    required this.onEmailChanged,
    required this.onPasswordChanged,
    required this.onSubmit,
  });

  factory RegisterVM.fromStore(MyDexStore store, RegisterMiddleware middleware) => RegisterVM(
        state: store.state.authState.registerState,
        onNameChanged: (_) => store.dispatch(RegisterAction.nameTextChanged(_)),
        onEmailChanged: (_) => store.dispatch(RegisterAction.emailTextChanged(_)),
        onPasswordChanged: (_) => store.dispatch(RegisterAction.passwordTextChanged(_)),
        onSubmit: (_) => () => store.dispatch(middleware.onRegisterSubmit(_)),
      );
}

class RegisterReducer {
  static Reducer<RegisterState> reduce = combineReducers<RegisterState>([
    TypedReducer<RegisterState, NameTextChanged>((s, _) => s.copyWith(nameText: _.name)),
    TypedReducer<RegisterState, EmailTextChanged>((s, _) => s.copyWith(emailText: _.email)),
    TypedReducer<RegisterState, PasswordTextChanged>((s, _) => s.copyWith(passwordText: _.password)),
    TypedReducer<RegisterState, ErrorsChanged>((s, _) => s.copyWith(errors: s.errors.copyWith(_.key, _.error))),
  ]);
}

@freezed
class RegisterAction with _$RegisterAction implements AuthActions {
  const factory RegisterAction.nameTextChanged(String name) = NameTextChanged;
  const factory RegisterAction.emailTextChanged(String email) = EmailTextChanged;
  const factory RegisterAction.passwordTextChanged(String password) = PasswordTextChanged;
  const factory RegisterAction.errorsChanged(String key, String? error) = ErrorsChanged;
}

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState({
    @Default('') String nameText,
    @Default('') String emailText,
    @Default('') String passwordText,
    @Default({}) Map<String, String?> errors,
  }) = _RegisterState;
}
