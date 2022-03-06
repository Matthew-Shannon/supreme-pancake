import 'package:flutter_test/flutter_test.dart';
import 'package:mydex/src/core/extensions.dart';
import 'package:mydex/src/service/prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  tests();
}

void tests() {
  late Prefs prefs;

  group('Prefs', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      var shared = await SharedPreferences.getInstance();
      prefs = Prefs(shared);
    });

    test('id', () async {
      await expectLater(prefs.clear().thenDo(prefs.getId), completion(0));
      await expectLater(prefs.setId(1).thenDo(prefs.getId), completion(1));
      await expectLater(prefs.clear().thenDo(prefs.getId), completion(0));
    });

    test('pos', () async {
      await expectLater(prefs.clear().thenDo(prefs.getPos), completion(0));
      await expectLater(prefs.setPos(1).thenDo(prefs.getPos), completion(1));
      await expectLater(prefs.clear().thenDo(prefs.getPos), completion(0));
    });

    test('auth', () async {
      await expectLater(prefs.clear().thenDo(prefs.getAuth), completion(false));
      await expectLater(prefs.setAuth(true).thenDo(prefs.getAuth), completion(true));
      await expectLater(prefs.clear().thenDo(prefs.getAuth), completion(false));
    });

    test('theme', () async {
      await expectLater(prefs.clear().thenDo(prefs.getTheme), completion(false));
      await expectLater(prefs.setTheme(true).thenDo(prefs.getTheme), completion(true));
      await expectLater(prefs.clear().thenDo(prefs.getTheme), completion(false));
    });
  });
}
