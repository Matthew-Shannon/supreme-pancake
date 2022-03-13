import 'package:mydex/src/app.dart';
import 'package:mydex/src/core/di.dart';
import 'package:mydex/src/service/service.dart';
import 'package:mydex/src/view/auth/auth.dart';
import 'package:mydex/src/view/home/features/settings.dart';

import 'core/mock.dart';
import 'core/util.dart';

void main() {
  group('Auth', () {
    late INav nav;
    late IStyle style;
    late IPrefs prefs;
    late AuthStore authStore;
    late SettingsStore settingsStore;

    group('view', () {
      setUp(() {
        prefs = MockPrefs();
        when(() => prefs.setTheme(any())).thenCall();

        nav = MockNav();
        when(() => nav.selectInitial(any())).thenReturn(const Text('asdf'));

        style = MockStyle();
        when(() => style.selectTheme(any())).thenReturn(ThemeData.fallback());

        authStore = AuthStore();
        settingsStore = SettingsStore(prefs, authStore);

        DI.instance.registerLazySingleton<SettingsStore>(() => settingsStore);
        DI.instance.registerLazySingleton<AuthStore>(() => authStore);
        DI.instance.registerLazySingleton<IStyle>(() => style);
        DI.instance.registerLazySingleton<INav>(() => nav);
      });

      tearDown(() async => DI.instance.reset());

      testWidgets('auth', (tester) async {
        await tester.inflate(AppView());
        verify(() => nav.selectInitial(false)).called(1);

        authStore.authChanged(true);
        await tester.pump(Duration.zero);
        verify(() => nav.selectInitial(true)).called(1);
      });

      testWidgets('style', (tester) async {
        await tester.inflate(AppView());
        verify(() => style.selectTheme(false)).called(1);

        await settingsStore.themeChanged(true);
        await tester.pump(Duration.zero);
        verify(() => style.selectTheme(true)).called(1);
      });
    });
  });
}
