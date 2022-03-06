import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mydex/src/core/const.dart';
import 'package:mydex/src/core/di.dart';
import 'package:mydex/src/core/view.dart';
import 'package:mydex/src/model/pokemon/pokemon.dart';
import 'package:mydex/src/model/state.dart';
import 'package:mydex/src/view/home/features/search.dart';

import '../../../core/mock.dart';
import '../../../core/util.dart';

void main() {
  middlewareTests();
  viewTests();
}

void middlewareTests() {
  late SearchMiddleware middleware;
  late MockPokemonRepo pokemonRepo;
  late MockPairRepo pairRepo;
  late MyDexStore store;

  group('SearchMiddleware', () {
    setUp(() {
      pairRepo = MockPairRepo();
      pokemonRepo = MockPokemonRepo();
      middleware = SearchMiddleware(pokemonRepo, pairRepo);
      store = setupStore((_, c) => _.copyWith(
            searchState: SearchReducer.reduce(_.searchState, c),
          ));
    });

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
      when(() => pokemonRepo.doGet(any())).thenReply(mockPokemon);
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
}

void viewTests() {
  late SearchMiddleware middleware;
  late MockPokemonRepo pokemonRepo;
  late MockPairRepo pairRepo;
  late MyDexStore store;

  group('SearchView', () {
    setUp(() {
      pairRepo = MockPairRepo();
      pokemonRepo = MockPokemonRepo();
      middleware = SearchMiddleware(pokemonRepo, pairRepo);
      store = setupStore((_, c) => _.copyWith(
            searchState: SearchReducer.reduce(_.searchState, c),
          ));
      DI.instance
        ..registerLazySingleton<MyDexStore>(() => store)
        ..registerLazySingleton<SearchMiddleware>(() => middleware);
    });

    tearDown(() async => DI.instance.reset());

    testWidgets('pokemonTitle', (tester) async {
      store.dispatch(const SearchAction.pokemonSelected(mockPokemon));
      var vm = SearchVM.fromStore(store, middleware);
      await tester.pumpWidget(SearchView.pokemonTitle(vm.pokemonVm).app());
      expect(find.text('a'), findsOneWidget);
    });

    testWidgets('pokemonCardView', (tester) async {
      store.dispatch(const SearchAction.pokemonSelected(mockPokemon));
      var vm = SearchVM.fromStore(store, middleware);
      await tester.pumpWidget(testApp(() => SearchView.pokemonCardView(vm.pokemonVm).material()));
      expect(find.text('Id: 1'), findsOneWidget);
      expect(find.text('Name: a'), findsOneWidget);
      expect(find.text('Order: 2'), findsOneWidget);
      expect(find.text('Height: 3'), findsOneWidget);
      expect(find.text('Weight: 4'), findsOneWidget);
      expect(find.text('BaseExp: 5'), findsOneWidget);
    });

    testWidgets('pairListView', (tester) async {
      store.dispatch(const SearchAction.pairsChanged([mockPair, mockPairB, mockPairC]));
      var vm = SearchVM.fromStore(store, middleware);
      await tester.pumpWidget(testApp(() => SearchView.pairListView(vm).material()));
      expect(find.text('a (1'), findsOneWidget);
      expect(find.byKey(const Key('pairListView')), findsOneWidget);
    });

    testWidgets('searchEditText', (tester) async {
      var vm = SearchVM.fromStore(store, middleware);
      await tester.pumpWidget(testApp(() => SearchView.searchEditText(vm, ThemeData.fallback()).material()));
      expect(find.text('Search...'), findsOneWidget);
    });

    testWidgets('actions_search', (tester) async {
      store.dispatch(const SearchAction.isSearching(false));
      var vm = SearchVM.fromStore(store, middleware);
      await tester.pumpWidget(testApp(() => SearchView.actions(vm).column().material()));
      expect(find.byKey(const Key('search')), findsOneWidget);
      expect(find.byKey(const Key('clear')), findsNothing);
    });

    testWidgets('actions_clear', (tester) async {
      store.dispatch(const SearchAction.isSearching(true));
      var vm = SearchVM.fromStore(store, middleware);
      await tester.pumpWidget(testApp(() => SearchView.actions(vm).column().material()));
      expect(find.byKey(const Key('search')), findsNothing);
      expect(find.byKey(const Key('clear')), findsOneWidget);
    });

    testWidgets('title_noSearch_noPokemon', (tester) async {
      var vm = SearchVM.fromStore(store, middleware);
      await tester.pumpWidget(testApp(() => SearchView.title(vm, ThemeData.fallback()).material()));
      expect(find.text(Const.appName), findsOneWidget);
    });

    testWidgets('title_search_noPokemon', (tester) async {
      store.dispatch(const SearchAction.isSearching(true));
      var vm = SearchVM.fromStore(store, middleware);
      await tester.pumpWidget(testApp(() => SearchView.title(vm, ThemeData.fallback()).material()));
      expect(find.byKey(const Key('searchEditText')), findsOneWidget);
    });

    testWidgets('title_search_pokemon', (tester) async {
      store.dispatch(const SearchAction.isSearching(true));
      store.dispatch(const SearchAction.pokemonSelected(mockPokemon));
      var vm = SearchVM.fromStore(store, middleware);
      await tester.pumpWidget(testApp(() => SearchView.title(vm, ThemeData.fallback()).material()));
      expect(find.byKey(const Key('pokemonTitle')), findsOneWidget);
    });

    testWidgets('body_noPokemon_noPairs', (tester) async {
      var vm = SearchVM.fromStore(store, middleware);
      await tester.pumpWidget(testApp(() => SearchView.body(vm).column().material()));
      expect(find.text(Const.searchTitle), findsOneWidget);
    });

    testWidgets('body_noPokemon_Pairs', (tester) async {
      store.dispatch(const SearchAction.pairsChanged([mockPair]));

      var vm = SearchVM.fromStore(store, middleware);
      await tester.pumpWidget(testApp(() => SearchView.body(vm).column().material()));
      expect(find.byKey(const Key('pairListView')), findsOneWidget);
    });

    testWidgets('body_Pokemon_Pairs', (tester) async {
      store.dispatch(const SearchAction.pokemonSelected(mockPokemon));
      var vm = SearchVM.fromStore(store, middleware);
      await tester.pumpWidget(testApp(() => SearchView.body(vm).column().material()));
      expect(find.byKey(const Key('pokemonCardView')), findsOneWidget);
    });

    testWidgets('build', (tester) async {
      store.dispatch(const SearchAction.isSearching(true));
      await tester.pumpWidget(testApp(SearchView.new).storeProvider(store));
      expect(find.text(Const.searchTitle), findsOneWidget);

      await tester.enterText(find.byType(TextField).at(0), 'ab');

      //expect(find.text(Const.searchTitle), findsOneWidget);
    });
  });
}
