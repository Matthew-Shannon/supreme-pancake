import 'package:mydex/src/service/style.dart';

import '../core/util.dart';

void main() {
  group('Style', () {
    late IStyle style;

    setUp(() => style = Style());

    test('darkTheme', () {
      expect(style.darkTheme().brightness, Brightness.dark);
    });

    test('lightTheme', () {
      expect(style.lightTheme().brightness, Brightness.light);
    });
    test('selectTheme', () {
      expect(style.selectTheme(false).brightness, Brightness.light);
      expect(style.selectTheme(true).brightness, Brightness.dark);
    });
  });
}
