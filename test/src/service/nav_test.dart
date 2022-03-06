import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mydex/src/core/view.dart';
import 'package:mydex/src/service/nav.dart';

import '../core/util.dart';

class MockNav extends Mock implements INav {}

void main() {
  tests();
}

void tests() {
  late INav nav;

  group('Nav', () {
    setUp(() {
      nav = Nav({'a': () => const Text('1')});
    });
    testWidgets('getBy', (tester) async {
      await tester.pumpWidget(testApp(() => nav.getBy('')));
      expect(find.text('View Not Found'), findsOneWidget);

      await tester.pumpWidget(testApp(() => nav.getBy('a')));
      expect(find.text('1'), findsOneWidget);
    });
    testWidgets('goTo', (tester) async {
      await tester.pumpWidget(testApp(() => const Text('initial').container()));
      final BuildContext context = tester.element(find.byType(Container));
      expect(find.text('initial'), findsOneWidget);

      nav.goTo(context, 'a')();
      await tester.pumpAndSettle();
      expect(find.text('1'), findsOneWidget);
    });
    testWidgets('goBack', (tester) async {
      await tester.pumpWidget(testApp(() => const Text('initial').container()));

      final BuildContext context = tester.element(find.byType(Container));
      expect(find.text('initial'), findsOneWidget);

      nav.goTo(context, 'a')();
      await tester.pumpAndSettle();
      expect(find.text('1'), findsOneWidget);

      nav.goBack(context)();
      await tester.pumpAndSettle();
      expect(find.text('initial'), findsOneWidget);
    });
  });
}
