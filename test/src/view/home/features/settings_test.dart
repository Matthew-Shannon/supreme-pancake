import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mydex/src/core/const.dart';
import 'package:mydex/src/core/di.dart';
import 'package:mydex/src/core/view.dart';
import 'package:mydex/src/model/state.dart';
import 'package:mydex/src/model/user.dart';
import 'package:mydex/src/service/prefs.dart';
import 'package:mydex/src/service/repo.dart';
import 'package:mydex/src/view/auth/auth.dart';
import 'package:mydex/src/view/home/features/settings.dart';

import '../../../core/mock.dart';
import '../../../core/util.dart';

void main() {
  group('Settings', () {
    late SettingsMiddleware middleware;
    late AppDatabase database;
    late MyDexStore store;
    late SettingsVM vm;
    late IPrefs prefs;

    setUp(() {
      prefs = MockPrefs();
      when(() => prefs.setTheme(any())).thenCall();
      when(() => prefs.setAuth(any())).thenCall();
      when(() => prefs.clear()).thenCall();

      database = MockAppDatabase();
      when(() => database.clear()).thenCall();

      middleware = SettingsMiddleware(prefs, database);
      store = setupStore([
        MyDexReducer.clearSelector,
        MyDexReducer.authSelector,
        MyDexReducer.settingsSelector,
      ]);
      vm = SettingsVM.fromStore(store, middleware);
    });

    group('middleware', () {
      test('toggleTheme', () async {
        expect(store.state.settingsState.isDarkMode, false);
        await middleware.toggleTheme(true)(store);
        expect(store.state.settingsState.isDarkMode, true);
        await middleware.toggleTheme(false)(store);
        expect(store.state.settingsState.isDarkMode, false);
      });

      test('logout', () async {
        expect(store.state.authState.isAuthed, false);
        store.dispatch(const AuthAction.authChanged(true));
        expect(store.state.authState.isAuthed, true);
        await middleware.logout()(store);
        expect(store.state.authState.isAuthed, false);
        verify(() => prefs.setAuth(any())).called(1);
      });

      test('wipe', () async {
        expect(store.state.authState.isAuthed, false);
        expect(store.state.authState.owner == const User(), true);
        store.dispatch(const AuthAction.authChanged(true));
        store.dispatch(const AuthAction.ownerChanged(mockUser));
        expect(store.state != const MyDexState(), equals(true));
        await middleware.wipeData()(store);
        expect(store.state == const MyDexState(), equals(true));
      });
    });

    group('view', () {
      testWidgets('logoutBtn', (tester) async {
        await tester.pumpWidget(testApp(() => SettingsView.buttons(vm).column()));
        store.dispatch(const AuthAction.authChanged(true));
        expect(store.state.authState.isAuthed, equals(true));
        expectAllExist([
          Const.logoutBtn,
        ]);
        await tester.tap(find.text(Const.logoutBtn));
        expect(store.state.authState.isAuthed, equals(false));
      });

      testWidgets('wipeBtn', (tester) async {
        store.dispatch(const AuthAction.authChanged(true));
        store.dispatch(const AuthAction.ownerChanged(mockUser));
        await tester.pumpWidget(testApp(() => SettingsView.buttons(vm).column()));
        expect(store.state != const MyDexState(), equals(true));
        expectAllExist([
          Const.wipeBtn,
        ]);
        await tester.tap(find.text(Const.wipeBtn));
        expect(store.state == const MyDexState(), equals(true));
      });

      testWidgets('toggles', (tester) async {
        await tester.pumpWidget(testApp(() => SettingsView.toggles(vm).column().material()));
        expectAllExist([Const.darkModeBtn]);
        await tester.tap(find.text(Const.darkModeBtn));
      });

      testWidgets('userView', (tester) async {
        await tester.pumpWidget(testApp(() => SettingsView.userView(const UserVM(mockUser)).column().material()));
        expectAllExist(['Name: a', 'Email: b@', 'Password: c']);
      });

      testWidgets('build', (tester) async {
        DI.instance.registerLazySingleton<SettingsMiddleware>(() => middleware);
        store.dispatch(const AuthAction.ownerChanged(mockUser));
        await tester.pumpWidget(testApp(SettingsView.new).storeProvider(store));
        expectAllExist(['Name: a', 'Email: b@', 'Password: c', Const.logoutBtn, Const.darkModeBtn, Const.wipeBtn]);
        await DI.instance.reset();
      });
    });
  });
}
