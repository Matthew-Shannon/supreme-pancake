import '../../core/const.dart';
import '../../core/view.dart';
import '../../model/model.dart';
import '../../service/service.dart';

part 'auth.g.dart';

class AuthView extends StatelessWidget with GetItMixin {
  AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final INav nav = get();
    return nav.getBy(Const.loginView);
  }
}

class AuthStore = AuthBase with _$AuthStore;

abstract class AuthBase with Store {
  final Observable<User> owner = Observable(const User());
  final Observable<bool> isAuthed = Observable(false);

  @action
  void authChanged(bool _) => isAuthed.value = _;

  @action
  void ownerChanged(User _) => owner.value = _;
}
