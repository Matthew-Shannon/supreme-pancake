import 'package:mydex/src/core/const.dart';
import 'package:mydex/src/core/di.dart';
import 'package:mydex/src/service/service.dart';
import 'package:mydex/src/view/auth/auth.dart';

import '../../core/util.dart';

void main() {
  group('Auth', () {
    late INav nav;

    group('view', () {
      setUp(() {
        nav = Nav('', '', {Const.loginView: () => const Text('Foo')});
      });

      testWidgets('build', (tester) async {
        DI.instance.registerLazySingleton<INav>(() => nav);
        await tester.inflate(AuthView());
        expect(find.text('Foo'), findsOneWidget);
        await DI.instance.reset();
      });
    });
  });
}
