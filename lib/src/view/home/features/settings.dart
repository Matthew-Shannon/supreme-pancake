import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../../../core/const.dart';
import '../../../core/extensions.dart';
import '../../../core/types.dart';
import '../../../core/view.dart';
import '../../../model/state.dart';
import '../../../model/user.dart';
import '../../../service/prefs.dart';
import '../../../service/repo.dart';
import '../../auth/auth.dart';

part 'settings.freezed.dart';

class SettingsView extends StatelessWidget with GetItMixin {
  SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingsMiddleware middleware = get();
    return StoreConnector<MyDexState, SettingsVM>(
      converter: (_) => SettingsVM.fromStore(_, middleware),
      builder: (ctx, _) => Scaffold(
        appBar: const Text(Const.settingsTitle).appBar(),
        body: View.frame(body(_)),
      ),
    );
  }

  static List<Widget> body(SettingsVM vm) => [
        ...SettingsView.userView(vm.userVM),
        ...SettingsView.toggles(vm),
        ...SettingsView.buttons(vm),
      ];

  static List<Widget> userView(UserVM vm) => //
      vm.fields().map(Text.new).mapList((_) => ListTile(title: _));

  static List<Widget> toggles(SettingsVM vm) => [
        SwitchListTile(
          title: const Text(Const.darkModeBtn),
          onChanged: vm.onToggleTheme,
          value: vm.settingsState.isDarkMode,
        ),
      ];

  static List<Widget> buttons(SettingsVM vm) => [
        const Text(Const.logoutBtn).outlinedButton(Const.logoutBtn, vm.onLogout),
        const Text(Const.wipeBtn).outlinedButton(Const.wipeBtn, vm.onWipe),
      ];
}

class SettingsVM {
  final SettingsState settingsState;
  final UserVM userVM;
  final Runnable onLogout;
  final Consumer<bool> onToggleTheme;
  final Runnable onWipe;

  const SettingsVM({required this.settingsState, required this.userVM, required this.onLogout, required this.onToggleTheme, required this.onWipe});

  factory SettingsVM.fromStore(MyDexStore store, SettingsMiddleware middleware) => SettingsVM(
      settingsState: store.state.settingsState,
      userVM: UserVM(store.state.authState.owner),
      onLogout: () => store.dispatch(middleware.logout()),
      onToggleTheme: (_) => store.dispatch(middleware.toggleTheme(_)),
      onWipe: () => store.dispatch(middleware.wipeData()));
}

class SettingsMiddleware {
  final IPrefs prefs;
  final AppDatabase database;
  SettingsMiddleware(this.prefs, this.database);

  Func<MyDexStore, Future<void>> toggleTheme(bool status) => (store) async {
        await prefs.setTheme(status);
        store.dispatch(SettingsAction.themeChanged(status));
      };

  Func<MyDexStore, Future<void>> logout() => (store) async {
        await prefs.setAuth(false);
        store.dispatch(const AuthAction.authChanged(false));
      };

  ThunkAction<MyDexState> wipeData() => (store) async {
        await store.dispatch(ClearAction());
        await prefs.clear();
        await database.clear();
      };
}

class SettingsReducer {
  static Reducer<SettingsState> reduce = combineReducers<SettingsState>([
    TypedReducer<SettingsState, ThemeChanged>((s, _) => s.copyWith(isDarkMode: _.theme)),
  ]);
}

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(false) bool isDarkMode,
    @Default(false) bool isiOS,
  }) = _SettingsState;
}

@freezed
class SettingsAction with _$SettingsAction {
  const factory SettingsAction.themeChanged(bool theme) = ThemeChanged;
}
