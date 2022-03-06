import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mydex/src/core/const.dart';
import 'package:mydex/src/core/di.dart';
import 'package:mydex/src/core/view.dart';
import 'package:mydex/src/model/state.dart';
import 'package:mydex/src/model/user.dart';
import 'package:mydex/src/view/auth/auth.dart';
import 'package:mydex/src/view/home/features/settings.dart';

import '../../../core/util.dart';
import '../../../service/prefs_test.dart';

void main() {
  middlewareTests();
  viewTests();
}

void middlewareTests() {
  late SettingsMiddleware middleware;
  late MyDexStore store;
  late MockPrefs prefs;

  group('SettingsMiddleware', () {
    setUp(() {
      prefs = MockPrefs();
      middleware = SettingsMiddleware(prefs);
      store = setupStore((_, c) => _.copyWith(
            authState: AuthReducer.reduce(_.authState, c),
            settingsState: SettingsReducer.reduce(_.settingsState, c),
          ));
    });

    test('toggleTheme', () async {
      when(() => prefs.setTheme(any())).thenAnswerVoidFuture();
      expect(store.state.settingsState.isDarkMode, false);

      await middleware.toggleTheme(true)(store);
      expect(store.state.settingsState.isDarkMode, true);

      await middleware.toggleTheme(false)(store);
      expect(store.state.settingsState.isDarkMode, false);
    });

    test('logout', () async {
      when(() => prefs.setAuth(any())).thenAnswerVoidFuture();
      expect(store.state.authState.isAuthed, false);

      store.dispatch(const AuthAction.authChanged(true));
      expect(store.state.authState.isAuthed, true);

      await middleware.logout()(store);
      expect(store.state.authState.isAuthed, false);
      verify(() => prefs.setAuth(any())).called(1);
    });
  });
}

void viewTests() {
  late SettingsMiddleware middleware;
  late MyDexStore store;

  group('SettingsView', () {
    setUp(() {
      var prefs = MockPrefs();
      middleware = SettingsMiddleware(prefs);
      store = setupStore((_, c) => _.copyWith(
            authState: AuthReducer.reduce(_.authState, c),
            settingsState: SettingsReducer.reduce(_.settingsState, c),
          ));
      DI.instance
        ..registerLazySingleton<MyDexStore>(() => store)
        ..registerLazySingleton<SettingsMiddleware>(() => middleware);
    });

    tearDown(() async => DI.instance.reset());

    testWidgets('buttons', (tester) async {
      var vm = SettingsVM.fromStore(store, middleware);
      await tester.pumpWidget(testApp(() => SettingsView.buttons(vm).column()));
      expect(find.text(Const.logoutBtn), findsOneWidget);
      // TODO?
    });

    testWidgets('toggles', (tester) async {
      var vm = SettingsVM.fromStore(store, middleware);
      await tester.pumpWidget(testApp(() => SettingsView.toggles(vm).column().material()));
      expect(find.text(Const.darkModeBtn), findsOneWidget);
      // TODO?
    });

    testWidgets('userView', (tester) async {
      var vm = const UserVM(User(id: 1, name: 'a', email: 'b@', password: 'c'));
      await tester.pumpWidget(testApp(() => SettingsView.userView(vm).column().material()));
      expect(find.text('Name: a'), findsOneWidget);
      expect(find.text('Email: b@'), findsOneWidget);
      expect(find.text('Password: c'), findsOneWidget);
    });

    testWidgets('build', (tester) async {
      await tester.pumpWidget(testApp(SettingsView.new).storeProvider(store));
      store.dispatch(const AuthAction.ownerChanged(User(id: 1, name: 'a', email: 'b@', password: 'c')));
      await tester.pump(Duration.zero);
      expect(find.text('Name: a'), findsOneWidget);
      expect(find.text('Email: b@'), findsOneWidget);
      expect(find.text('Password: c'), findsOneWidget);
      expect(find.text(Const.logoutBtn), findsOneWidget);
      expect(find.text(Const.darkModeBtn), findsOneWidget);
    });
  });
}
