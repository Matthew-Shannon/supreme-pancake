import 'package:mydex/src/core/const.dart';
import 'package:mydex/src/core/di.dart';
import 'package:mydex/src/model/model.dart';
import 'package:mydex/src/service/service.dart';
import 'package:mydex/src/view/auth/auth.dart';
import 'package:mydex/src/view/home/features/settings.dart';

import '../../../core/mock.dart';
import '../../../core/util.dart';

void main() {
  group('Settings', () {
    late SettingsStore settingsStore;
    late AuthStore authStore;
    late IPrefs prefs;

    setUp(() {
      prefs = MockPrefs();
      when(() => prefs.setTheme(any())).thenCall();
      when(() => prefs.setAuth(any())).thenCall();
      when(() => prefs.clear()).thenCall();

      authStore = AuthStore();
      settingsStore = SettingsStore(prefs, authStore);
    });

    group('settingsStore', () {
      test('toggleTheme', () async {
        expect(settingsStore.isDarkMode.value, isFalse);
        await settingsStore.themeChanged(true);
        expect(settingsStore.isDarkMode.value, isTrue);
        await settingsStore.themeChanged(false);
        expect(settingsStore.isDarkMode.value, isFalse);
      });

      test('logout', () async {
        expect(authStore.isAuthed.value, isFalse);
        authStore.authChanged(true);
        expect(authStore.isAuthed.value, isTrue);
        await settingsStore.logout();
        expect(authStore.isAuthed.value, isFalse);
        verify(() => prefs.setAuth(any())).called(1);
      });

      test('wipe', () async {
        authStore.authChanged(true);
        authStore.ownerChanged(mockUser);
        expect(authStore.isAuthed.value, isTrue);
        expect(authStore.owner.value == const User(), isFalse);
        await settingsStore.wipeData();
        expect(authStore.isAuthed.value, isFalse);
        expect(authStore.owner.value == const User(), isTrue);
      });
    });

    group('view', () {
      testWidgets('logoutBtn', (tester) async {
        var view = SettingsView.buttons(settingsStore);
        await tester.inflate(view);
        authStore.authChanged(true);
        expect(authStore.isAuthed.value, isTrue);
        expectAllExist([Const.logoutBtn]);
        await tester.tap(find.text(Const.logoutBtn));
        expect(authStore.isAuthed.value, isFalse);
      });

      testWidgets('wipeBtn', (tester) async {
        authStore.authChanged(true);
        authStore.ownerChanged(mockUser);
        var view = SettingsView.buttons(settingsStore);
        await tester.inflate(view);
        expect(authStore.isAuthed.value, isTrue);
        expect(authStore.owner.value == const User(), isFalse);
        expectAllExist([Const.wipeBtn]);

        await tester.tap(find.text(Const.wipeBtn));
        expect(authStore.isAuthed.value, isFalse);
        expect(authStore.owner.value == const User(), isTrue);
      });

      testWidgets('toggles', (tester) async {
        var view = SettingsView.toggles(settingsStore);
        await tester.inflate(view);
        expectAllExist([Const.darkModeBtn]);
        await tester.tap(find.text(Const.darkModeBtn));
      });

      testWidgets('userView', (tester) async {
        var view = SettingsView.userView(const UserVM(mockUser));
        await tester.inflate(view);
        expectAllExist(['Name: a', 'Email: b@', 'Password: c']);
      });

      testWidgets('build', (tester) async {
        DI.instance.registerLazySingleton<AuthStore>(() => authStore);
        DI.instance.registerLazySingleton<SettingsStore>(() => settingsStore);
        authStore.ownerChanged(mockUser);
        await tester.inflateWithScaling(SettingsView.new);
        expectAllExist(['Name: a', 'Email: b@', 'Password: c', Const.logoutBtn, Const.darkModeBtn, Const.wipeBtn]);
        await DI.instance.reset();
      });
    });
  });
}
