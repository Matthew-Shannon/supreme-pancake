import 'package:mydex/src/model/model.dart';

import '../core/mock.dart';
import '../core/util.dart';

void main() {
  group('Pokemon', () {
    group('model', () {
      test('equals', () {
        expect(const Pokemon() == const Pokemon(), isTrue);
        expect(const Pokemon(id: 1) == const Pokemon(id: 2), isFalse);
        expect(Ability.fromJson(mockPokemon.abilities[0].toJson()) == mockPokemon.abilities[0], true);
      });

      test('json', () {
        expect(Pokemon.fromJson(const Pokemon().toJson()) == const Pokemon(), isTrue);
        expect(Pokemon.fromJson(const Pokemon(id: 1).toJson()) == const Pokemon(id: 2), isFalse);
      });
    });

    group('vm', () {
      test('renderPokemon', () {
        var vm = PokemonVM.def(mockPokemon);
        expect(vm.id, equals('ID:77'));
        expect(vm.name, equals('Name:Ponyta'));
        expect(vm.order, equals('Order:121'));
        expect(vm.baseExp, equals('BaseExp:82'));
        expect(vm.height, equals('Height:3\'03"'));
        expect(vm.weight, equals('Weight:66.1 lbs'));
        expect(vm.fields().length, equals(6));
      });
      test('renderEmptyPokemon', () {
        var vm = PokemonVM.def(const Pokemon());
        expect(vm.id, equals('ID:0'));
        expect(vm.name, equals('Name:'));
        expect(vm.order, equals('Order:0'));
        expect(vm.baseExp, equals('BaseExp:0'));
        expect(vm.height, equals('Height:0\'00"'));
        expect(vm.weight, equals('Weight:0.0 lbs'));
        expect(vm.fields().length, equals(6));
      });
      test('height', () {
        var joltic = PokemonVM.def(mockPokemon.copyWith(height: 1));
        expect(joltic.height, equals('Height:0\'04"'));

        var ponyta = PokemonVM.def(mockPokemon.copyWith(height: 10));
        expect(ponyta.height, equals('Height:3\'03"'));

        var wishiwashi = PokemonVM.def(mockPokemon.copyWith(height: 82));
        expect(wishiwashi.height, equals('Height:26\'11"'));

        var onyx = PokemonVM.def(mockPokemon.copyWith(height: 88));
        expect(onyx.height, equals('Height:28\'10"'));

        var eternatus = PokemonVM.def(mockPokemon.copyWith(height: 200));
        expect(eternatus.height, equals('Height:65\'07"'));
      });
      test('weight', () {
        var joltic = PokemonVM.def(mockPokemon.copyWith(weight: 6));
        expect(joltic.weight, equals('Weight:1.3 lbs'));

        var ponyta = PokemonVM.def(mockPokemon.copyWith(weight: 300));
        expect(ponyta.weight, equals('Weight:66.1 lbs'));

        var wishiwashi = PokemonVM.def(mockPokemon.copyWith(weight: 786));
        expect(wishiwashi.weight, equals('Weight:173.3 lbs'));

        var onyx = PokemonVM.def(mockPokemon.copyWith(weight: 2100));
        expect(onyx.weight, equals('Weight:463.0 lbs'));

        var eternatus = PokemonVM.def(mockPokemon.copyWith(weight: 9500));
        expect(eternatus.weight, equals('Weight:2094.4 lbs'));
      });
    });

    group('local', () {
      late PokemonRemote remote;
      late PokemonRepo repo;

      setUp(() async {
        remote = MockPokemonRemote();
        repo = PokemonRepo(remote);
      });

      test('rest', () async {
        when(() => remote.getPokemon(any())).thenReply(mockPokemon);
        await expectLater(repo.doGet('foo'), completion(some(mockPokemon)));

        when(() => remote.getPokemonResources(any(), any())).thenReply(const NamedApiResourceList(results: [mockNamedRes, mockNamedResB, mockNamedResC]));
        await expectLater(repo.doGetAll('a'), completion([mockNamedRes]));
      });
    });
  });
}
