import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mydex/src/core/const.dart';
import 'package:mydex/src/core/di.dart';
import 'package:mydex/src/core/view.dart';
import 'package:mydex/src/model/state.dart';
import 'package:mydex/src/service/nav.dart';
import 'package:mydex/src/service/prefs.dart';
import 'package:mydex/src/view/home/home.dart';

import '../../core/mock.dart';
import '../../core/util.dart';

void main() {
  group('home', () {
    late HomeMiddleware middleware;
    late MyDexStore store;
    late IPrefs prefs;

    setUp(() {
      prefs = MockPrefs();
      when(() => prefs.setPos(any())).thenCall();

      middleware = HomeMiddleware(prefs);
      store = setupStore([MyDexReducer.homeSelector]);
    });

    group('middleware', () {
      test('onPosChange', () async {
        await middleware.changePos(1)(store);
        expect(store.state.homeState.pos, 1);
        verify(() => prefs.setPos(any())).called(1);
      });
    });

    group('view', () {
      testWidgets('bottomBar', (tester) async {
        await tester.pumpWidget(testApp(() => Scaffold(bottomNavigationBar: HomeView.bottomNav(HomeView.bottomItems(), middleware, 0))).storeProvider(store));
        expectAllExist([Const.newsTitle, Const.searchTitle, Const.favoritesTitle, Const.settingsTitle]);
      });

      testWidgets('build', (tester) async {
        var nav = MockNav();
        when(() => nav.getBy(any())).thenReturn(const Text(''));
        DI.instance.registerLazySingleton<HomeMiddleware>(() => middleware);
        DI.instance.registerLazySingleton<INav>(() => nav);
        await tester.pumpWidget(testApp(HomeView.new).storeProvider(store));
        expectAllExist([Const.newsTitle, Const.searchTitle, Const.favoritesTitle, Const.settingsTitle]);
        await DI.instance.reset();
      });
    });
  });
}
