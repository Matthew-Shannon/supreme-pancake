import '../../core/const.dart';
import '../../service/service.dart';
import '../util.dart';
import 'resource.dart';
import 'sprite.dart';

part 'pokemon.freezed.dart';
part 'pokemon.g.dart';

@RestApi(baseUrl: Const.pokeBaseUrl)
abstract class PokemonRemote {
  factory PokemonRemote(Dio dio, {String baseUrl}) = _PokemonRemote;

  @GET('pokemon/{id}/')
  Future<Pokemon?> getPokemon(@Path('id') String id);
}

@freezed
class Pokemon with _$Pokemon {
  const factory Pokemon({
    @Default(0) int id,
    @Default('') String name,
    @Default(0) int base_experience,
    @Default(0.0) double height,
    @Default(false) bool isDefault,
    @Default(0) int order,
    @Default(0.0) double weight,
    @Default(NamedApiResource()) NamedApiResource species,
    @Default([]) List<Ability> abilities,
    @Default([]) List<NamedApiResource> forms,
    // @Default([]) List<VersionGameIndex> gameIndices,
    // @Default([]) List<HeldItem> heldItems,
    // @Default([]) List<Move> moves,
    // @Default([]) List<Stats> stats,
    // @Default([]) List<Types> types,
    @Default(Sprite()) Sprite sprites,
  }) = _Pokemon;

  factory Pokemon.fromJson(JSON json) => //
      _$PokemonFromJson(json);
}

@freezed
class Ability with _$Ability {
  const factory Ability({
    @Default(false) bool isHidden,
    @Default(0) int slot,
    @Default(NamedApiResource()) NamedApiResource ability,
  }) = _Ability;
  factory Ability.fromJson(JSON json) => _$AbilityFromJson(json);
}

class AbilityVM {
  const AbilityVM(this.ability);
  final Ability ability;
  factory AbilityVM.def(Ability ability) => AbilityVM(ability);

  String get id => 'Id:${ability.ability.id()}';
  String get name => 'Name:${capitalize(ability.ability.name)}';
  String get url => 'Url:${ability.ability.url}';
  String get category => 'Category:${ability.ability.category()}';
}

class PokemonVM {
  const PokemonVM(this.pokemon, this.sprites, this.abilities);
  final List<AbilityVM> abilities;
  final SpriteVM sprites;
  final Pokemon pokemon;

  factory PokemonVM.def(Pokemon pokemon) => PokemonVM(
        pokemon,
        SpriteVM(pokemon.sprites),
        pokemon.abilities.map(AbilityVM.def).toList(),
      );

  String get id => 'ID:${pokemon.id}';
  String get order => 'Order:${pokemon.order}';
  String get name => 'Name:${capitalize(pokemon.name)}';
  String get height => 'Height:${UnitConvert.extractHeight(pokemon.height)}';
  String get weight => 'Weight:${UnitConvert.extractWeight(pokemon.weight)}';
  String get baseExp => 'BaseExp:${pokemon.base_experience}';

  List<String> fields() => [id, order, name, height, weight, baseExp];
}

class PokemonRepo {
  final PokemonRemote remote;
  const PokemonRepo(this.remote);

  Future<Option<Pokemon>> doGet(String query) => remote //
      .getPokemon(query)
      .then(optionOf);
}
