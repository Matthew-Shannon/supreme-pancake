import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mydex/src/app.dart';
import 'package:mydex/src/core/const.dart';
import 'package:mydex/src/core/di.dart';
import 'package:mydex/src/core/view.dart';
import 'package:mydex/src/model/state.dart';
import 'package:mydex/src/service/nav.dart';
import 'package:mydex/src/service/style.dart';
import 'package:mydex/src/view/auth/auth.dart';
import 'package:mydex/src/view/home/features/settings.dart';

import 'core/util.dart';
import 'service/nav_test.dart';
import 'service/style_test.dart';

void main() {
  viewTests();
}

void viewTests() {
  late MockNav nav;
  late MockStyle skin;
  late MyDexStore store;

  group('AppView', () {
    setUp(() {
      nav = MockNav();
      skin = MockStyle();
      store = setupStore((_, c) => _.copyWith(
            authState: AuthReducer.reduce(_.authState, c),
            settingsState: SettingsReducer.reduce(_.settingsState, c),
          ));
      DI.instance
        ..registerLazySingleton<MyDexStore>(() => store)
        ..registerLazySingleton<IStyle>(() => skin)
        ..registerLazySingleton<INav>(() => nav);
    });

    tearDown(() async => DI.instance.reset());

    testWidgets('auth', (tester) async {
      when(() => nav.getBy(any())).thenReturn(const Text(''));
      when(skin.lightTheme).thenReturn(ThemeData.fallback());
      await tester.pumpWidget(testApp(AppView.new).storeProvider(store));
      verify(() => nav.getBy(Const.authView)).called(1);

      store.dispatch(const AuthAction.authChanged(false));
      await tester.pump(Duration.zero);
      verify(() => nav.getBy(Const.authView)).called(1);

      store.dispatch(const AuthAction.authChanged(true));
      await tester.pump(Duration.zero);
      verify(() => nav.getBy(Const.homeView)).called(1);
    });

    testWidgets('style', (tester) async {
      when(() => nav.getBy(any())).thenReturn(const Text(''));
      when(skin.lightTheme).thenReturn(ThemeData.fallback());
      when(skin.darkTheme).thenReturn(ThemeData.fallback());
      await tester.pumpWidget(testApp(AppView.new).storeProvider(store));
      verify(() => skin.lightTheme()).called(1);

      store.dispatch(const SettingsAction.themeChanged(false));
      await tester.pump(Duration.zero);
      verify(() => skin.lightTheme()).called(1);

      store.dispatch(const SettingsAction.themeChanged(true));
      await tester.pump(Duration.zero);
      verify(() => skin.darkTheme()).called(1);
    });
  });
}
