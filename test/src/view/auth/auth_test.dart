import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mydex/src/core/di.dart';
import 'package:mydex/src/core/view.dart';
import 'package:mydex/src/model/state.dart';
import 'package:mydex/src/service/nav.dart';
import 'package:mydex/src/view/auth/auth.dart';

import '../../core/mock.dart';
import '../../core/util.dart';

void main() {
  group('Auth', () {
    late AuthMiddleware middleware;
    late MyDexStore store;
    late INav nav;

    group('view', () {
      setUp(() {
        middleware = AuthMiddleware();
        store = setupStore([MyDexReducer.authSelector]);

        nav = MockNav();
        when(() => nav.getBy(any())).thenReturn(const Text('Foo'));
      });

      testWidgets('build', (tester) async {
        DI.instance.registerLazySingleton<AuthMiddleware>(() => middleware);
        DI.instance.registerLazySingleton<INav>(() => nav);
        await tester.pumpWidget(testApp(AuthView.new).storeProvider(store));
        expect(find.text('Foo'), findsOneWidget);
        await DI.instance.reset();
      });
    });
  });
}
