import 'dart:developer';

import '../../../core/const.dart';
import '../../../core/view.dart';
import '../../../model/model.dart';
import '../../../service/service.dart';

part 'search.g.dart';

class SearchView extends StatelessWidget with GetItMixin {
  SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchStore store = get();
    return Observer(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: SearchView.title(store, Theme.of(_)),
          actions: SearchView.actions(store),
        ),
        body: View.frame(SearchView.body(store)),
      ),
    );
  }

  static List<Widget> body(SearchStore store) => [
        store.pokemon.value.cata(
            () => store.namedRes.value.isNotEmpty //
                ? pairListView(store)
                : const Text(Const.searchTip),
            (_) => [
                  pokemonCardView(_),
                  abilityView(_.abilities),
                ].column()),
      ];

  static Widget title(SearchStore store, ThemeData theme) => //
      store.pokemon.value.fold(
        () => store.isSearching.value ? SearchView.searchEditText(store, theme) : const Text(Const.appName),
        SearchView.pokemonTitle,
      );

  static List<Widget> actions(SearchStore store) => [
        store.pokemon.value.fold(
          () => store.isSearching.value //
              ? View.action('clear', Icons.clear, () => store.searchStatusChanged(false))
              : View.action('search', Icons.search, () => store.searchStatusChanged(true)),
          (_) => View.action('back', Icons.arrow_back, store.onBack),
        ),
      ];

  static Widget searchEditText(SearchStore store, ThemeData theme) => TextFormField(
      autofocus: true,
      showCursor: false,
      key: const Key('searchEditText'),
      onChanged: store.searchTextChanged,
      style: const TextStyle(color: Colors.white),
      initialValue: store.query.value.toNullable(),
      decoration: const InputDecoration(
        hintText: 'Search...',
        hintStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(MdiIcons.magnify, color: Colors.white),
        border: OutlineInputBorder(borderSide: BorderSide.none),
      ));

  static Widget pairListView(SearchStore store) => Column(
        key: const Key('pairListView'),
        children: store.namedRes.value //
            .map(NamedApiResourceVM.new)
            .map(
              (_) => ListTile(
                key: Key(_.res.name),
                onTap: () => store.pairSelected(_.res.name),
                title: Text(_.title),
              ),
            )
            .toList(),
      );

  static Widget pokemonTitle(PokemonVM vm) => //
      Text(vm.name.split(':').last, key: const Key('pokemonTitle'));

  static Widget spriteView(SpriteVM vm) => //
      [...vm.normal(), ...vm.shiny()] //
          .map(Image.network)
          .toList()
          .column()
          .container(color: Colors.blue, width: 0.5.sw);

  static Widget abilityView(List<AbilityVM> abilities) => Column(
        key: const Key('abilityListView'),
        children: abilities //
            .map(
              (_) => ListTile(
                key: Key(_.name),
                title: Text('${_.name} -${_.id} - ${_.category}'),
                subtitle: Text(_.url),
              ),
            )
            .toList(),
      );

  static Widget pokemonCardView(PokemonVM vm) => [
        ListView.builder(
          shrinkWrap: true,
          itemCount: vm.fields().length,
          itemBuilder: (_, i) => ListTile(
            dense: true,
            tileColor: Colors.purpleAccent,
            title: Text(vm.fields()[i].split(':')[0]),
            subtitle: Text(vm.fields()[i].split(':')[1]),
          ),
        ).container(width: 0.4.sw),
        spriteView(vm.sprites)
      ] //
          .row(size: MainAxisSize.min)
          .container(key: const Key('pokemonCardView'));
}

class SearchStore = SearchBase with _$SearchStore;

abstract class SearchBase with Store {
  final Observable<List<NamedApiResource>> namedRes = Observable([])..observe((x) => log('namedRes: ${x.newValue}'));
  final Observable<Option<PokemonVM>> pokemon = Observable(none())..observe((x) => log('onPokemonChange: ${x.newValue}'));
  final Observable<Option<String>> query = Observable(none())..observe((x) => log('onQueryChange: ${x.newValue}'));
  final Observable<bool> isSearching = Observable(false)..observe((x) => log('isSearching: ${x.newValue}'));
  final PokemonRepo pokemonRepo;
  final ResourceRepo pairRepo;

  SearchBase(this.pokemonRepo, this.pairRepo);

  @action
  void namedResChanged([List<NamedApiResource> _ = const []]) => namedRes.value = _;

  @action
  void pokemonChanged([Option<PokemonVM> _ = const None()]) => pokemon.value = _;

  @action
  void queryChanged([Option<String> _ = const None()]) => query.value = _;

  @action
  void isSearchingChanged([bool _ = false]) => isSearching.value = _;

  @action
  Future<void> pairSelected(String res) async => //
      Future.value(res) //
          .then(pokemonRepo.doGet)
          .then((_) => _.map(PokemonVM.def))
          .then(pokemonChanged)
          .then((_) => isSearchingChanged());

  @action
  Future<void> onBack() async => //
      Future.value(true) //
          .then(isSearchingChanged)
          .then((_) => pokemonChanged());

  @action
  Future<void> searchStatusChanged(bool searching) async => //
      Future.value(searching) //
          .then(isSearchingChanged)
          .then((_) {
        if (searching == false) {
          pokemonChanged();
          queryChanged();
          namedResChanged();
        }
      });

  @action
  Future<void> searchTextChanged(String query) async => //
      Future.value(query) //
          .then(pairRepo.doGetAll)
          .then(namedResChanged)
          .then((_) => query)
          .then(some)
          .then(queryChanged);
}
