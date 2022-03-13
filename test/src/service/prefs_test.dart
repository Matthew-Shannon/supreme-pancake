import 'package:mydex/src/service/service.dart';

import '../core/util.dart';

void main() {
  group('Prefs', () {
    late Prefs prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      var shared = await SharedPreferences.getInstance();
      prefs = Prefs(shared);
    });

    test('pos', () async {
      await expectLater(prefs.clear().then((_) => prefs.getPos()), completion(0));
      await expectLater(prefs.setPos(1).then((_) => prefs.getPos()), completion(1));
      await expectLater(prefs.clear().then((_) => prefs.getPos()), completion(0));
    });

    test('auth', () async {
      await expectLater(prefs.clear().then((_) => prefs.getAuth()), completion(false));
      await expectLater(prefs.setAuth(true).then((_) => prefs.getAuth()), completion(true));
      await expectLater(prefs.clear().then((_) => prefs.getAuth()), completion(false));
    });

    test('theme', () async {
      await expectLater(prefs.clear().then((_) => prefs.getTheme()), completion(false));
      await expectLater(prefs.setTheme(true).then((_) => prefs.getTheme()), completion(true));
      await expectLater(prefs.clear().then((_) => prefs.getTheme()), completion(false));
    });

    test('owner', () async {
      await expectLater(prefs.clear().then((_) => prefs.getOwner()), completion(''));
      await expectLater(prefs.setOwner('a').then((_) => prefs.getOwner()), completion('a'));
      await expectLater(prefs.clear().then((_) => prefs.getOwner()), completion(''));
    });
  });
}
