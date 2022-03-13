import 'package:mydex/src/core/const.dart';
import 'package:mydex/src/core/di.dart';
import 'package:mydex/src/service/service.dart';
import 'package:mydex/src/view/home/home.dart';

import '../../core/mock.dart';
import '../../core/util.dart';

void main() {
  group('home', () {
    late HomeStore store;
    late IPrefs prefs;

    setUp(() {
      prefs = MockPrefs();
      when(() => prefs.setPos(any())).thenCall();

      store = HomeStore(prefs);
    });

    group('middleware', () {
      test('onPosChange', () async {
        await store.onPosChanged(1);
        expect(store.pos.value, 1);
        verify(() => prefs.setPos(1)).called(1);
      });
    });

    group('view', () {
      testWidgets('bottomBar', (tester) async {
        var view = Scaffold(bottomNavigationBar: HomeView.bottomNav(HomeView.bottomItems(), store));
        await tester.inflate(view);
        expectAllExist([Const.newsTitle, Const.searchTitle, Const.favoritesTitle, Const.settingsTitle]);
      });

      testWidgets('build', (tester) async {
        var nav = MockNav();
        when(() => nav.getBy(any())).thenReturn(const Text(''));
        DI.instance.registerLazySingleton<HomeStore>(() => store);
        DI.instance.registerLazySingleton<INav>(() => nav);
        await tester.inflate(HomeView());
        expectAllExist([Const.newsTitle, Const.searchTitle, Const.favoritesTitle, Const.settingsTitle]);
        await DI.instance.reset();
      });
    });
  });
}
