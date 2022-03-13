import 'package:mydex/src/model/model.dart';
import 'package:mydex/src/service/service.dart';

import '../core/mock.dart';
import '../core/util.dart';

void main() {
  group('User', () {
    group('model', () {
      test('equals', () {
        expect(const User() == const User(), isTrue);
        expect(const User(email: 'a@') == const User(email: 'b@'), isFalse);
      });
    });

    group('vm', () {
      test('drawEmpty', () async {
        var emptyUserVM = const UserVM(User());
        expect(emptyUserVM.fields().length, equals(3));
        expect(emptyUserVM.name(), 'Name: ');
        expect(emptyUserVM.email(), 'Email: ');
        expect(emptyUserVM.password(), 'Password: ');
      });
      test('drawUser', () async {
        var userVM = const UserVM(mockUser);
        expect(userVM.fields().length, equals(3));
        expect(userVM.name(), 'Name: a');
        expect(userVM.email(), 'Email: b@');
        expect(userVM.password(), 'Password: c');
      });
    });

    group('local', () {
      late String ownerJson;
      late UserRepo repo;
      late IPrefs prefs;

      setUp(() {
        ownerJson = jsonEncode(mockUser.toJson());
        prefs = MockPrefs();
        when(() => prefs.getOwner()).thenReply(ownerJson);
        when(() => prefs.setOwner(any())).thenCall();
        repo = UserRepo(prefs);
      });

      test('rest', () async {
        await repo.doInsert(mockUser);
        await expectLater(repo.doGet(), completion(some(mockUser)));
        when(() => prefs.getOwner()).thenReply('');
        await expectLater(repo.doGet(), completion(none<User>()));
      });
    });
  });
}
