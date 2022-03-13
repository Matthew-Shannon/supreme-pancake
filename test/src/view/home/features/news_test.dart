import 'package:mydex/src/core/const.dart';
import 'package:mydex/src/view/home/features/news.dart';

import '../../../core/util.dart';

void main() {
  middlewareTests();
  viewTests();
}

void middlewareTests() {}

void viewTests() {
  group('NewsView', () {
    setUp(() {});

    //tearDown(() async => DI.instance.reset());

    testWidgets('build', (tester) async {
      await tester.inflate(NewsView());
      expectAllExist([Const.newsTitle, Const.appName]);
    });
  });
}
