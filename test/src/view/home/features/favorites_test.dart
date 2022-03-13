import 'package:mydex/src/core/const.dart';
import 'package:mydex/src/view/home/features/favorites.dart';

import '../../../core/util.dart';

void main() {
  middlewareTests();
  viewTests();
}

void middlewareTests() {}

void viewTests() {
  group('FavoritesView', () {
    setUp(() {});

    testWidgets('build', (tester) async {
      await tester.inflate(FavoritesView());
      expectAllExist([Const.favoritesTitle, Const.appName]);
    });
  });
}
