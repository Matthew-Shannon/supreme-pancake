import 'package:flutter_test/flutter_test.dart';
import 'package:mydex/src/model/user.dart';
import 'package:mydex/src/service/repo.dart';

import '../core/mock.dart';

void main() {
  model();
  local();
}

void model() {
  group('User', () {
    test('equals', () {
      expect(const User() == const User(), isTrue);
      expect(const User(id: 1) == const User(id: 2), isFalse);
    });
  });
}

void local() {
  group('User', () {
    group('local', () {
      late AppDatabase database;
      late UserLocal local;
      late UserRepo repo;

      setUp(() async {
        database = await testDb();
        local = database.userLocal;
        repo = UserRepo(local);
      });

      tearDown(() async => database.close());

      test('find user by id', () async {
        await expectLater(repo.doGet('1'), completion(const User()));
        await repo.doInsert([mockUser]);
        await expectLater(repo.doGet('1'), completion(mockUser));
        await expectLater(repo.doGetAll(), completion([mockUser]));
      });
    });
  });
}
