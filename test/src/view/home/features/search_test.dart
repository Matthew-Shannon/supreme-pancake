import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mydex/src/core/const.dart';
import 'package:mydex/src/core/di.dart';
import 'package:mydex/src/core/view.dart';
import 'package:mydex/src/model/pokemon/pair.dart';
import 'package:mydex/src/model/pokemon/pokemon.dart';
import 'package:mydex/src/model/state.dart';
import 'package:mydex/src/view/home/features/search.dart';

import '../../../core/mock.dart';
import '../../../core/util.dart';

void main() {
  group('search', () {
    late SearchMiddleware middleware;
    late PokemonRepo pokemonRepo;
    late PairRepo pairRepo;
    late MyDexStore store;

    setUp(() {
      print('called');
      pairRepo = MockPairRepo();
      when(() => pairRepo.doGetAll()).thenReply([mockPair, mockPairB, mockPairC]);

      pokemonRepo = MockPokemonRepo();
      when(() => pokemonRepo.doGet(any())).thenReply(mockPokemon);

      middleware = SearchMiddleware(pokemonRepo, pairRepo);
      store = setupStore([MyDexReducer.searchSelector]);
    });

    group('middleware', () {
      test('searchStatus', () async {
        expect(store.state.searchState.isSearching, equals(false));

        await middleware.searchStatusChanged(true)(store);
        expect(store.state.searchState.isSearching, equals(true));

        await middleware.searchStatusChanged(false)(store);
        expect(store.state.searchState.isSearching, equals(false));

        store.dispatch(const SearchAction.pairsChanged([mockPair]));
        store.dispatch(const SearchAction.pokemonSelected(mockPokemon));
        expect(store.state.searchState.pairs, equals([mockPair]));
        expect(store.state.searchState.pokemon, equals(mockPokemon));

        await middleware.searchStatusChanged(false)(store);
        expect(store.state.searchState.pairs, equals([]));
        expect(store.state.searchState.pokemon, equals(const Pokemon()));
        expect(store.state.searchState.isSearching, equals(false));
      });

      test('pairSelected', () async {
        expect(store.state.searchState.isSearching, equals(false));
        store.dispatch(const SearchAction.isSearching(true));
        expect(store.state.searchState.isSearching, equals(true));

        await middleware.pairSelected(mockPair)(store);
        expect(store.state.searchState.pokemon, equals(mockPokemon));
      });

      test('searchTextChanged', () async {
        expect(store.state.searchState.pairs, equals([]));

        await middleware.searchTextChanged('')(store);
        expect(store.state.searchState.pairs, equals([]));

        when(() => pairRepo.doGetAll()).thenReply([mockPair, mockPairB, mockPairC]);
        await middleware.searchTextChanged('a')(store);
        expect(store.state.searchState.pairs, equals([mockPair]));
      });
    });

    group('view', () {
      testWidgets('pokemonTitle', (tester) async {
        store.dispatch(const SearchAction.pokemonSelected(mockPokemon));
        var vm = SearchVM.fromStore(store, middleware);
        await tester.pumpWidget(SearchView.pokemonTitle(vm.pokemonVm).app());
        expectAllExist(['a']);
      });

      testWidgets('pokemonCardView', (tester) async {
        store.dispatch(const SearchAction.pokemonSelected(mockPokemon));
        var vm = SearchVM.fromStore(store, middleware);
        await tester.pumpWidget(testApp(() => SearchView.pokemonCardView(vm.pokemonVm).material()));
        expectAllExist(['Id: 1', 'Name: a', 'Order: 2', 'Height: 3', 'Weight: 4', 'BaseExp: 5']);
      });

      testWidgets('pairListView', (tester) async {
        store.dispatch(const SearchAction.pairsChanged([mockPair, mockPairB, mockPairC]));
        var vm = SearchVM.fromStore(store, middleware);
        await tester.pumpWidget(testApp(() => SearchView.pairListView(vm).material()));
        expectAllExist(['a (1']);
        expectKeysExist(['pairListView']);
      });

      testWidgets('searchEditText', (tester) async {
        var vm = SearchVM.fromStore(store, middleware);
        await tester.pumpWidget(testApp(() => SearchView.searchEditText(vm, ThemeData.fallback()).material()));
        expectAllExist(['Search...']);
      });

      testWidgets('actions_search', (tester) async {
        store.dispatch(const SearchAction.isSearching(false));
        var vm = SearchVM.fromStore(store, middleware);
        await tester.pumpWidget(testApp(() => SearchView.actions(vm).column().material()));
        expectKeysExist(['search']);
        expectKeysNotExist(['clear']);
      });

      testWidgets('actions_clear', (tester) async {
        store.dispatch(const SearchAction.isSearching(true));
        var vm = SearchVM.fromStore(store, middleware);
        await tester.pumpWidget(testApp(() => SearchView.actions(vm).column().material()));
        expectKeysNotExist(['search']);
        expectKeysExist(['clear']);
      });

      testWidgets('title_noSearch_noPokemon', (tester) async {
        var vm = SearchVM.fromStore(store, middleware);
        await tester.pumpWidget(testApp(() => SearchView.title(vm, ThemeData.fallback()).material()));
        expectAllExist([Const.appName]);
      });

      testWidgets('title_search_noPokemon', (tester) async {
        store.dispatch(const SearchAction.isSearching(true));
        var vm = SearchVM.fromStore(store, middleware);
        await tester.pumpWidget(testApp(() => SearchView.title(vm, ThemeData.fallback()).material()));
        expectKeysExist(['searchEditText']);
        await tester.enterText(find.byType(TextField).at(0), 'ab');
      });

      testWidgets('title_search_pokemon', (tester) async {
        store.dispatch(const SearchAction.isSearching(true));
        store.dispatch(const SearchAction.pokemonSelected(mockPokemon));
        var vm = SearchVM.fromStore(store, middleware);
        await tester.pumpWidget(testApp(() => SearchView.title(vm, ThemeData.fallback()).material()));
        expectKeysExist(['pokemonTitle']);
      });

      testWidgets('body_noPokemon_noPairs', (tester) async {
        var vm = SearchVM.fromStore(store, middleware);
        await tester.pumpWidget(testApp(() => SearchView.body(vm).column().material()));
        expectAllExist([Const.searchTitle]);
      });

      testWidgets('body_noPokemon_Pairs', (tester) async {
        store.dispatch(const SearchAction.pairsChanged([mockPair]));
        var vm = SearchVM.fromStore(store, middleware);
        await tester.pumpWidget(testApp(() => SearchView.body(vm).column().material()));
        expectKeysExist(['pairListView']);
      });

      testWidgets('body_Pokemon_Pairs', (tester) async {
        store.dispatch(const SearchAction.pokemonSelected(mockPokemon));
        var vm = SearchVM.fromStore(store, middleware);
        await tester.pumpWidget(testApp(() => SearchView.body(vm).column().material()));
        expectKeysExist(['pokemonCardView']);
      });

      testWidgets('build', (tester) async {
        DI.instance.registerLazySingleton<MyDexStore>(() => store);
        DI.instance.registerLazySingleton<SearchMiddleware>(() => middleware);
        store.dispatch(const SearchAction.isSearching(true));
        await tester.pumpWidget(testApp(SearchView.new).storeProvider(store));
        expectAllExist([Const.searchTitle]);
        await DI.instance.reset();
      });
    });
  });
}
