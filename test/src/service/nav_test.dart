import 'package:mydex/src/core/const.dart';
import 'package:mydex/src/service/service.dart';

import '../core/util.dart';

void main() {
  group('Nav', () {
    late Nav nav;

    setUp(() {
      nav = Nav(Const.homeView, Const.authView, {
        'a': () => const Text('1'),
        Const.homeView: () => const Text(Const.homeView),
        Const.authView: () => const Text(Const.authView),
      });
    });

    testWidgets('getBy', (tester) async {
      await tester.inflate(nav.getBy(''));
      expectAllExist([nav.msg]);

      await tester.inflate(nav.getBy('a'));
      expectAllExist(['1']);
    });

    testWidgets('goTo', (tester) async {
      await tester.inflate(Container(child: const Text('initial')));
      final BuildContext context = tester.element(find.byType(Container));
      expectAllExist(['initial']);

      nav.goTo(context, 'a')();
      await tester.pumpAndSettle();
      expectAllExist(['1']);
    });

    testWidgets('goBack', (tester) async {
      await tester.inflate(Container(child: const Text('initial')));
      final BuildContext context = tester.element(find.byType(Container));
      expectAllExist(['initial']);

      nav.goTo(context, 'a')();
      await tester.pumpAndSettle();
      expectAllExist(['1']);

      nav.goBack(context)();
      await tester.pumpAndSettle();
      expectAllExist(['initial']);
    });

    testWidgets('getInitial', (tester) async {
      await tester.inflate(Container(child: const Text('initial')));
      expectAllExist(['initial']);

      await tester.inflate(Container(child: nav.selectInitial(false)));
      expectAllExist([Const.authView]);

      await tester.inflate(Container(child: nav.selectInitial(true)));
      expectAllExist([Const.homeView]);
    });
  });
}
