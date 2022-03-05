import 'package:flutter_test/flutter_test.dart';
import 'package:mydex/src/core/const.dart';
import 'package:mydex/src/core/types.dart';
import 'package:mydex/src/core/view.dart';
import 'package:mydex/src/view/home/features/news.dart';

import '../../../core/util.dart';

void main() {
  middlewareTests();
  viewTests();
}

void middlewareTests() {}

void viewTests() {
  group('NewsView', () {
    late MyDexStore store;

    setUp(() {
      store = setupStore((_, c) => _);
    });

    //tearDown(() async => DI.instance.reset());

    testWidgets('build', (tester) async {
      await tester.pumpWidget(const TestApp(NewsView.new).storeProvider(store));
      expect(find.text(Const.newsTitle), findsOneWidget);
      expect(find.text(Const.appName), findsOneWidget);
    });
  });
}
