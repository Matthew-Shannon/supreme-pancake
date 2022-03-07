import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mydex/src/service/style.dart';

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
  });
}
