import '../../../core/const.dart';
import '../../../core/view.dart';
import '../../../model/user.dart';
import '../../../service/service.dart';
import '../auth.dart';

part 'login.g.dart';

class LoginView extends StatelessWidget with GetItMixin {
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginStore store = get();
    final INav nav = get();
    return Observer(
      builder: (_) => Scaffold(
        appBar: const Text(Const.loginTitle).appBar(),
        body: View.frame([
          View.singleCard([
            LoginView.fieldsView(store),
            LoginView.buttonsView(store, nav.goTo(_, Const.registerView)),
          ])
        ]),
      ),
    );
  }

  static Widget fieldsView(LoginStore store) => [
        const Text(Const.emailLabel) //
            .inputDecor(store.errors.value[Const.emailLabel]?.toNullable())
            .textField(store.emailChanged)
            .padding(24.h.onlyBottom()),
        const Text(Const.passwordLabel) //
            .inputDecor(store.errors.value[Const.passwordLabel]?.toNullable())
            .textField(store.passwordChanged, isPassword: true)
            .padding(12.h.onlyBottom()),
      ].column();

  static Widget buttonsView(LoginStore store, void Function() onRegisterClick) => [
        const Text(Const.registerBtn).textButton(onRegisterClick),
        const Text(Const.submitBtn).elevatedButton(store.onLoginSubmit),
      ].row(align: MainAxisAlignment.end);
}

class LoginStore = LoginBase with _$LoginStore;

abstract class LoginBase with Store {
  final Observable<Map<String, Option<String>>> errors = Observable({});
  final Observable<String> password = Observable('');
  final Observable<String> email = Observable('');
  final AuthStore authStore;
  final UserRepo userRepo;
  final IPrefs prefs;

  LoginBase(this.prefs, this.userRepo, this.authStore);

  @action
  void emailChanged(String _) => email.value = _;

  @action
  void passwordChanged(String _) => password.value = _;

  @action
  void errorChanged(Map<String, Option<String>> _) => errors.value = _;

  Option<String> validateEmail(String email, String cached) {
    if (email.isEmpty) return some(Const.emailBlankTxt);
    if (!email.contains('@')) return some(Const.emailInvalidTxt);
    if (cached != email) return some(Const.emailNotFound);
    return none();
  }

  Option<String> validatePassword(String password, String cached) {
    if (password.isEmpty) return some(Const.passwordBlankTxt);
    if (cached != password) return some(Const.passwordIncorrect);
    return none();
  }

  @action
  Future<void> onLoginSubmit() async {
    var cached = await userRepo.doGet() | const User();
    errorChanged({
      Const.emailLabel: validateEmail(email.value, cached.email),
      Const.passwordLabel: validatePassword(password.value, cached.password),
    });
    if (errors.value.values.where((_) => _.isSome()).isNotEmpty) return;
    await prefs.setAuth(true);
    authStore.ownerChanged(cached);
    authStore.authChanged(true);
  }
}
