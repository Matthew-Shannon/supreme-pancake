import '../../../core/const.dart';
import '../../../core/view.dart';
import '../../../model/model.dart';
import '../../../service/service.dart';

part 'register.g.dart';

class RegisterView extends StatelessWidget with GetItMixin {
  RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegisterStore store = get();
    final INav nav = get();
    return Observer(
      builder: (_) => Scaffold(
        appBar: const Text(Const.registerTitle).appBar(),
        body: View.frame([
          View.singleCard([
            RegisterView.fieldsView(store),
            RegisterView.buttonsView(store, nav.goBack(_)),
          ])
        ]),
      ),
    );
  }

  static Widget fieldsView(RegisterStore store) => Column(children: [
        const Text(Const.nameLabel) //
            .inputDecor(store.errors.value[Const.nameLabel]?.toNullable())
            .textField(store.nameChanged)
            .padding(24.h.onlyBottom()),
        const Text(Const.emailLabel) //
            .inputDecor(store.errors.value[Const.emailLabel]?.toNullable())
            .textField(store.emailChanged)
            .padding(24.h.onlyBottom()),
        const Text(Const.passwordLabel) //
            .inputDecor(store.errors.value[Const.passwordLabel]?.toNullable())
            .textField(store.passwordChanged, isPassword: true)
            .padding(12.h.onlyBottom()),
      ]);

  static Widget buttonsView(RegisterStore store, void Function() onBack) => [
        const Text(Const.loginBtn).textButton(onBack),
        const Text(Const.submitBtn).elevatedButton(() => store.onRegisterSubmit(onBack)),
      ].row(align: MainAxisAlignment.end);
}

class RegisterStore = RegisterBase with _$RegisterStore;

abstract class RegisterBase with Store {
  final UserRepo userRepo;

  final Observable<String> name = Observable('');
  final Observable<String> email = Observable('');
  final Observable<String> password = Observable('');
  final Observable<Map<String, Option<String>>> errors = Observable({});

  RegisterBase(this.userRepo);

  @action
  void nameChanged(String _) => name.value = _;

  @action
  void emailChanged(String _) => email.value = _;

  @action
  void passwordChanged(String _) => password.value = _;

  @action
  void errorChanged(Map<String, Option<String>> _) => errors.value = _;

  Option<String> validateName(String name) {
    if (name.isEmpty) return some(Const.nameBlankTxt);
    return none();
  }

  Option<String> validatePassword(String password) {
    if (password.isEmpty) return some(Const.passwordBlankTxt);
    return none();
  }

  Option<String> validateEmail(String email, String cached) {
    if (email.isEmpty) return some(Const.emailBlankTxt);
    if (!email.contains('@')) return some(Const.emailInvalidTxt);
    if (cached.isNotEmpty) return some(Const.emailAlreadyExistTxt);
    return none();
  }

  @action
  Future<void> onRegisterSubmit(void Function() onComplete) async {
    var cached = await userRepo.doGet() | const User();
    errorChanged({
      Const.nameLabel: validateName(name.value),
      Const.emailLabel: validateEmail(email.value, cached.email),
      Const.passwordLabel: validatePassword(password.value),
    });
    if (errors.value.values.where((_) => _.isSome()).isNotEmpty) return;
    await userRepo.doInsert(User(name: name.value, email: email.value, password: password.value));
    onComplete();
  }
}
