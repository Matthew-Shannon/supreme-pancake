import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mydex/src/core/view.dart';
import 'package:mydex/src/service/nav.dart';

import '../core/util.dart';

void main() {
  group('Nav', () {
    late Nav nav;

    setUp(() => nav = Nav({'a': () => const Text('1')}));

    testWidgets('getBy', (tester) async {
      await tester.pumpWidget(nav.getBy('').app());
      expectAllExist([nav.msg]);

      await tester.pumpWidget(nav.getBy('a').app());
      expectAllExist(['1']);
    });

    testWidgets('goTo', (tester) async {
      await tester.pumpWidget(const Text('initial').container().app());
      final BuildContext context = tester.element(find.byType(Container));
      expectAllExist(['initial']);

      nav.goTo(context, 'a')();
      await tester.pumpAndSettle();
      expectAllExist(['1']);
    });

    testWidgets('goBack', (tester) async {
      await tester.pumpWidget(const Text('initial').container().app());
      final BuildContext context = tester.element(find.byType(Container));
      expectAllExist(['initial']);

      nav.goTo(context, 'a')();
      await tester.pumpAndSettle();
      expectAllExist(['1']);

      nav.goBack(context)();
      await tester.pumpAndSettle();
      expectAllExist(['initial']);
    });
  });
}
