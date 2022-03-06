import 'package:flutter_test/flutter_test.dart';
import 'package:mydex/src/model/user.dart';

void main() {
  tests();
}

void tests() {
  group('User', () {
    test('equals', () {
      expect(const User() == const User(), isTrue);
      expect(const User(id: 1) == const User(id: 2), isFalse);
    });
  });
}
