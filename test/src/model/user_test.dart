import 'package:flutter_test/flutter_test.dart';
import 'package:mydex/src/model/user.dart';
import 'package:mydex/src/service/repo.dart';

import '../core/mock.dart';

void main() {
  tests();
}

void tests() {
  group('User', () {
    test('equals', () {
      expect(const User() == const User(), isTrue);
      expect(const User(id: 1) == const User(id: 2), isFalse);
    });

    group('vm', () {
      test('vm', () async {
        var emptyUserVM = const UserVM(User());
        expect(emptyUserVM.fields().length, equals(4));
        expect(emptyUserVM.id(), 'Id: 0');
        expect(emptyUserVM.name(), 'Name: ');
        expect(emptyUserVM.email(), 'Email: ');
        expect(emptyUserVM.password(), 'Password: ');

        var userVM = const UserVM(mockUser);
        expect(userVM.fields().length, equals(4));
        expect(userVM.id(), 'Id: 1');
        expect(userVM.name(), 'Name: a');
        expect(userVM.email(), 'Email: b@');
        expect(userVM.password(), 'Password: c');
      });
    });

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

      test('insert, get, getAll', () async {
        await expectLater(repo.doGet('1'), completion(const User()));
        await repo.doInsert([mockUser]);
        await expectLater(repo.doGet('1'), completion(mockUser));
        await expectLater(repo.doGetAll(), completion([mockUser]));
      });
    });
  });
}
