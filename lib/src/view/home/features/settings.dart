import '../../../core/const.dart';
import '../../../core/view.dart';
import '../../../model/model.dart';
import '../../../service/service.dart';
import '../../auth/auth.dart';

part 'settings.g.dart';

class SettingsView extends StatelessWidget with GetItMixin {
  SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingsStore settingsStore = get();
    final AuthStore authStore = get();
    return Observer(
      builder: (_) => Scaffold(
        appBar: const Text(Const.settingsTitle).appBar(),
        body: View.frame([
          SettingsView.userView(UserVM(authStore.owner.value)),
          SettingsView.toggles(settingsStore),
          SettingsView.buttons(settingsStore),
        ]),
      ),
    );
  }

  static Widget userView(UserVM vm) => vm //
      .fields()
      .map(Text.new)
      .map((_) => ListTile(title: _))
      .toList()
      .column();

  static Widget toggles(SettingsStore store) => [
        const Text(Const.darkModeBtn).switchListCell(store.isDarkMode.value, store.themeChanged),
      ].column();

  static Widget buttons(SettingsStore store) => [
        const Text(Const.logoutBtn).outlinedButton(Const.logoutBtn, store.logout),
        const Text(Const.wipeBtn).outlinedButton(Const.wipeBtn, store.wipeData),
      ].column();
}

class SettingsStore = SettingsBase with _$SettingsStore;

abstract class SettingsBase with Store {
  SettingsBase(this.prefs, this.authStore);
  final AuthStore authStore;
  final IPrefs prefs;

  Observable<bool> isDarkMode = Observable(false);
  Observable<bool> isiOS = Observable(false);

  @action
  Future<void> themeChanged(bool _) async {
    await prefs.setTheme(_);
    isDarkMode.value = _;
  }

  @action
  Future<void> logout() async {
    await prefs.setAuth(false);
    authStore.authChanged(false);
  }

  @action
  Future<void> wipeData() async {
    authStore.authChanged(false);
    authStore.ownerChanged(const User());
    await prefs.clear();
  }
}
