import 'package:flutter_test/flutter_test.dart';
import '../core/mock.dart';

void main() {
  group('Repo', () {
    test('clear', () async {
      var database = await testDb();
      await database.clear();
      await database.close();
    });
  });
}
