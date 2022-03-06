import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mydex/src/model/pokemon/pair.dart';
import 'package:mydex/src/service/repo.dart';

import '../core/mock.dart';
import '../core/util.dart';

void main() {
  tests();
}

void tests() {
  group('Pair', () {
    test('equals', () {
      expect(const Pair() == const Pair(), isTrue);
      expect(const Pair(id: 1) == const Pair(id: 2), isFalse);
    });

    test('json', () {
      expect(Pair.fromJson(const Pair().toJson()) == const Pair(), isTrue);
      expect(Pair.fromJson(const Pair(id: 1).toJson()) == const Pair(id: 2), isFalse);
    });

    test('id', () {
      expect(PairRepo.withID({'name': 'a', 'url': 'https://pokeapi.co/api/v2/pokemon/1/'}) == 1, isTrue);
    });

    test('vm', () {
      var vm = const PairVM(mockPair);
      expect(vm.title(), equals('a (1'));
    });

    group('local', () {
      late AppDatabase database;
      late PairLocal local;
      late MockDio remote;
      late PairRepo repo;

      setUp(() async {
        remote = MockDio();
        database = await testDb();
        local = database.pairLocal;
        repo = PairRepo(local, remote);
      });

      tearDown(() async => database.close());

      test('insert, get, getAll', () async {
        JSON data = {
          'results': [
            {'name': 'a', 'url': 'https://pokeapi.co/api/v2/pokemon/1/'}
          ]
        };
        when(() => remote.get<JSON>(any())).thenReply(remoteResponse(data));
        await expectLater(repo.doGet('1'), completion(const Pair()));
        await repo.doInsert([mockPair]);
        await expectLater(repo.doGet('1'), completion(mockPair));
        await expectLater(repo.doGetAll(), completion([mockPair]));
      });
    });
  });
}
