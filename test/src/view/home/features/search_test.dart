import 'package:mydex/src/core/const.dart';
import 'package:mydex/src/core/di.dart';
import 'package:mydex/src/model/model.dart';
import 'package:mydex/src/view/home/features/search.dart';

import '../../../core/mock.dart';
import '../../../core/util.dart';

void main() {
  group('search', () {
    late ResourceRepo resourceRepo;
    late PokemonRepo pokemonRepo;
    late SearchStore store;

    setUp(() {
      resourceRepo = MockNamedResRepo();
      when(() => resourceRepo.doGetAll(any())).thenReply([mockNamedRes]);

      pokemonRepo = MockPokemonRepo();
      when(() => pokemonRepo.doGet(any())).thenReply(some(mockPokemon));

      store = SearchStore(pokemonRepo, resourceRepo);
    });

    group('middleware', () {
      test('searchStatus', () async {
        await store.searchStatusChanged(true);
        expect(store.isSearching.value, equals(true));

        store.namedResChanged([mockNamedRes]);
        store.pokemonChanged(some(PokemonVM.def(mockPokemon)));
        expect(store.pokemon.value.toNullable()!.pokemon, equals(mockPokemon));
        expect(store.namedRes.value, equals([mockNamedRes]));

        await store.searchStatusChanged(false);
        expect(store.pokemon.value, equals(none()));
        expect(store.isSearching.value, equals(false));
      });

      test('pairSelected', () async {
        await store.searchStatusChanged(true);
        expect(store.isSearching.value, equals(true));

        await store.pairSelected(mockNamedRes.name);
        expect(store.pokemon.value.toNullable()!.pokemon, equals(mockPokemon));
      });

      test('searchTextChanged', () async {
        expect(store.query.value, equals(none()));

        await store.searchTextChanged('a');
        expect(store.query.value, equals(some('a')));
        expect(store.namedRes.value, equals([mockNamedRes]));
      });
      test('back', () async {
        store.pokemonChanged(some(PokemonVM.def(mockPokemon)));
        expect(store.isSearching.value, equals(false));
        expect(store.pokemon.value.toNullable()!.pokemon, equals(mockPokemon));

        await store.onBack();
        expect(store.isSearching.value, equals(true));
        expect(store.pokemon.value, equals(none()));
      });
    });

    group('view', () {
      testWidgets('pokemonTitle', (tester) async {
        var view = SearchView.pokemonTitle(PokemonVM.def(mockPokemon));
        await tester.inflate(view);
        expectAllExist(['Ponyta']);
      });

      testWidgets('pokemonCardView', (tester) async {
        var view = () => SearchView.pokemonCardView(PokemonVM.def(mockPokemon));
        await tester.inflateWithNetwork(view);
        expectAllExist(['ID', '77', 'Name', 'Ponyta', 'Order', '121', 'Height', '3\'03\"', 'Weight', '66.1 lbs', 'BaseExp', '82']);
      });

      testWidgets('pairListView', (tester) async {
        store.namedResChanged([mockNamedRes]);
        var view = SearchView.pairListView(store);
        await tester.inflate(view);
        expectAllExist(['a (1']);
        expectKeysExist(['pairListView']);
        expectKeysExist(['a']);
        await tester.tap(find.byKey(const Key('a')));
      });

      testWidgets('searchEditText', (tester) async {
        var view = SearchView.searchEditText(store, ThemeData.fallback());
        await tester.inflate(view);
        expectAllExist(['Search...']);
      });

      testWidgets('actions_search', (tester) async {
        await store.searchStatusChanged(false);
        var view = () => Column(children: SearchView.actions(store));
        await tester.inflateWithScaling(view);
        expectKeysNotExist(['clear', 'back']);
        expectKeysExist(['search']);
      });

      testWidgets('actions_clear', (tester) async {
        await store.searchStatusChanged(true);
        var view = () => Column(children: SearchView.actions(store));
        await tester.inflateWithScaling(view);
        expectKeysNotExist(['search', 'back']);
        expectKeysExist(['clear']);
      });

      testWidgets('actions_back', (tester) async {
        store.pokemonChanged(some(PokemonVM.def(mockPokemon)));
        var view = () => Column(children: SearchView.actions(store));
        await tester.inflateWithScaling(view);
        expectKeysNotExist(['search', 'clear']);
        expectKeysExist(['back']);
      });

      testWidgets('title_noSearch_noPokemon', (tester) async {
        var view = SearchView.title(store, ThemeData.fallback());
        await tester.inflate(view);
        expectAllExist([Const.appName]);
      });

      testWidgets('title_search_noPokemon', (tester) async {
        await store.searchStatusChanged(true);
        var view = SearchView.title(store, ThemeData.fallback());
        await tester.inflate(view);
        expectKeysExist(['searchEditText']);
        await tester.enterText(find.byType(TextField).at(0), 'ab');
      });

      testWidgets('title_search_pokemon', (tester) async {
        await store.searchStatusChanged(true);
        store.pokemonChanged(some(PokemonVM.def(mockPokemon)));
        var view = SearchView.title(store, ThemeData.fallback());
        await tester.inflate(view);
        expectKeysExist(['pokemonTitle']);
      });

      testWidgets('body_noPokemon_noNamedRes', (tester) async {
        var view = () => Column(children: SearchView.body(store));
        await tester.inflateWithScaling(view);
        expectAllExist([Const.searchTip]);
      });

      testWidgets('body_noPokemon_NamedRes', (tester) async {
        store.namedResChanged([mockNamedRes]);
        var view = () => Column(children: SearchView.body(store));
        await tester.inflateWithScaling(view);
        expectKeysExist(['pairListView']);
      });

      testWidgets('body_Pokemon_NamedRes', (tester) async {
        store.pokemonChanged(some(PokemonVM.def(mockPokemon)));
        var view = () => Column(children: SearchView.body(store));
        await tester.inflateWithNetwork(view);
        expectKeysExist(['pokemonCardView']);
      });

      testWidgets('build', (tester) async {
        DI.instance.registerLazySingleton<SearchStore>(() => store);
        await store.searchStatusChanged(true);
        await tester.inflateWithScaling(SearchView.new);
        expectAllExist([Const.searchTip]);
        await DI.instance.reset();
      });
    });
  });
}
