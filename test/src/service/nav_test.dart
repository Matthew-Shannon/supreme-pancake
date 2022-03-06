import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mydex/src/core/view.dart';
import 'package:mydex/src/service/nav.dart';

import '../core/util.dart';

void main() {
  tests();
}

void tests() {
  late INav nav;

  group('Nav', () {
    setUp(() => nav = Nav({'a': () => const Text('1')}));

    testWidgets('getBy', (tester) async {
      await tester.pumpWidget(nav.getBy('').app());
      expectText('View Not Found');

      await tester.pumpWidget(nav.getBy('a').app());
      expectText('1');
    });

    testWidgets('goTo', (tester) async {
      await tester.pumpWidget(const Text('initial').container().app());
      final BuildContext context = tester.element(find.byType(Container));

      expectText('initial');

      nav.goTo(context, 'a')();
      await tester.pumpAndSettle();
      expectText('1');
    });

    testWidgets('goBack', (tester) async {
      await tester.pumpWidget(const Text('initial').container().app());
      final BuildContext context = tester.element(find.byType(Container));
      expectText('initial');

      nav.goTo(context, 'a')();
      await tester.pumpAndSettle();
      expectText('1');

      nav.goBack(context)();
      await tester.pumpAndSettle();
      expectText('initial');
    });
  });
}
