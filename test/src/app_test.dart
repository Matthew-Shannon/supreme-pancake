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

import 'core/mock.dart';
import 'core/util.dart';

void main() {
  group('Auth', () {
    late MockNav nav;
    late IStyle skin;
    late MyDexStore store;

    group('view', () {
      setUp(() {
        nav = MockNav();
        when(() => nav.getBy(any())).thenReturn(const Text(''));

        skin = MockStyle();
        when(skin.lightTheme).thenReturn(ThemeData.fallback());
        when(skin.darkTheme).thenReturn(ThemeData.fallback());

        store = setupStore([MyDexReducer.authSelector, MyDexReducer.settingsSelector]);

        DI.instance.registerLazySingleton<MyDexStore>(() => store);
        DI.instance.registerLazySingleton<IStyle>(() => skin);
        DI.instance.registerLazySingleton<INav>(() => nav);
      });

      tearDown(() async => DI.instance.reset());

      testWidgets('auth', (tester) async {
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
  });
}
