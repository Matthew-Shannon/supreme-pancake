import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mydex/src/core/const.dart';
import 'package:mydex/src/core/di.dart';
import 'package:mydex/src/core/view.dart';
import 'package:mydex/src/model/state.dart';
import 'package:mydex/src/service/nav.dart';
import 'package:mydex/src/view/home/home.dart';

import '../../core/mock.dart';
import '../../core/util.dart';

void main() {
  middlewareTests();
  viewTests();
}

void middlewareTests() {
  late HomeMiddleware middleware;
  late MyDexStore store;
  late MockPrefs prefs;

  group('HomeMiddleware', () {
    setUp(() {
      prefs = MockPrefs();
      middleware = HomeMiddleware(prefs);
      store = setupStore((_, c) => _.copyWith(homeState: HomeReducer.reduce(_.homeState, c)));
    });

    test('onPosChange', () async {
      when(() => prefs.setPos(any())).thenCall();
      await middleware.changePos(1)(store);
      verify(() => prefs.setPos(any())).called(1);
      expect(store.state.homeState.pos, 1);
    });
  });
}

void viewTests() {
  late MockNav nav;
  late MockPrefs prefs;
  late MyDexStore store;
  late HomeMiddleware middleware;

  group('HomeView', () {
    setUp(() {
      nav = MockNav();
      prefs = MockPrefs();
      middleware = HomeMiddleware(prefs);
      store = setupStore((_, c) => _.copyWith(homeState: HomeReducer.reduce(_.homeState, c)));
      DI.instance
        ..registerLazySingleton<HomeMiddleware>(() => middleware)
        ..registerLazySingleton<INav>(() => nav);
    });

    tearDown(() async => DI.instance.reset());

    testWidgets('bottomBar', (tester) async {
      var temp = Scaffold(bottomNavigationBar: HomeView.bottomNav(HomeView.bottomItems(), middleware, 0));

      await tester.pumpWidget(testApp(() => temp).storeProvider(store));
      expect(find.text(Const.newsTitle), findsOneWidget);
      expect(find.text(Const.searchTitle), findsOneWidget);
      expect(find.text(Const.favoritesTitle), findsOneWidget);
      expect(find.text(Const.settingsTitle), findsOneWidget);
    });

    testWidgets('build', (tester) async {
      when(() => nav.getBy(any())).thenReturn(const Text(''));
      await tester.pumpWidget(testApp(HomeView.new).storeProvider(store));
      expect(find.text(Const.newsTitle), findsOneWidget);
      expect(find.text(Const.searchTitle), findsOneWidget);
      expect(find.text(Const.favoritesTitle), findsOneWidget);
      expect(find.text(Const.settingsTitle), findsOneWidget);
    });
  });
}
