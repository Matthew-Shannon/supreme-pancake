import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mydex/src/model/pokemon/pokemon.dart';
import 'package:mydex/src/service/repo.dart';

import '../core/mock.dart';
import '../core/util.dart';

void main() {
  group('Pokemon', () {
    group('model', () {
      test('equals', () {
        expect(const Pokemon() == const Pokemon(), isTrue);
        expect(const Pokemon(id: 1) == const Pokemon(id: 2), isFalse);
      });

      test('json', () {
        expect(Pokemon.fromJson(const Pokemon().toJson()) == const Pokemon(), isTrue);
        expect(Pokemon.fromJson(const Pokemon(id: 1).toJson()) == const Pokemon(id: 2), isFalse);
      });
    });

    group('vm', () {
      test('render', () {
        var vm = PokemonVM.def(mockPokemon);
        expect(vm.isNotEmpty(), isTrue);
        expect(vm.fields().length, equals(6));
        expect(vm.id(), equals('Id: 1'));
        expect(vm.name(), equals('Name: a'));
        expect(vm.order(), equals('Order: 2'));
        expect(vm.height(), equals('Height: 3'));
        expect(vm.weight(), equals('Weight: 4'));
        expect(vm.baseExp(), equals('BaseExp: 5'));
      });
    });

    group('local', () {
      late AppDatabase database;
      late PokemonRepo repo;
      late MockDio remote;

      setUp(() async {
        remote = MockDio();
        database = await testDb();
        repo = PokemonRepo(database.pokemonLocal, remote);
      });

      tearDown(() async => database.close());

      test('rest', () async {
        when(() => remote.get<JSON>(any())).thenReply(remoteResponse(mockPokemon.toJson()));
        await expectLater(repo.doGet('1'), completion(const Pokemon()));
        await repo.doInsert([mockPokemon, mockPokemon]);
        await expectLater(repo.doGet('1'), completion(mockPokemon));
        await expectLater(repo.doGetAll(), completion([mockPokemon]));

        when(() => remote.get<JSON>(any())).thenReply(remoteResponse(mockPokemonB.toJson()));
        await expectLater(repo.doGet('1'), completion(mockPokemon));
        await expectLater(repo.doGet('1'), completion(mockPokemonB));
      });
    });
  });
}
