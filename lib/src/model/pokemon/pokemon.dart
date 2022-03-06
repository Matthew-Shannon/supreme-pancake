import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../core/const.dart';
import '../../core/extensions.dart';
import '../../service/repo.dart';
import 'sprite.dart';

part 'pokemon.g.dart';

@entity
@JsonSerializable()
@SpriteRemoteConverter()
class Pokemon extends Equatable {
  @primaryKey
  final int id;
  final String name;
  final int height;
  final int weight;
  final int order;
  final int base_experience;
  final Sprite sprites;

  const Pokemon({this.id = 0, this.name = '', this.height = 0, this.weight = 0, this.order = 0, this.base_experience = 0, this.sprites = const Sprite()});

  @override
  List<Object?> get props => [id, name, height, weight, order, base_experience, sprites];

  factory Pokemon.fromJson(JSON json) => _$PokemonFromJson(json);

  JSON toJson() => _$PokemonToJson(this);
}

class PokemonVM {
  final Pokemon pokemon;
  final SpriteVM sprites;
  const PokemonVM(this.pokemon, this.sprites);
  factory PokemonVM.def(Pokemon pokemon) => PokemonVM(pokemon, SpriteVM(pokemon.sprites));

  bool isNotEmpty() => pokemon != const Pokemon();
  String id() => 'Id: ${pokemon.id}';
  String name() => 'Name: ${pokemon.name}';
  String order() => 'Order: ${pokemon.order}';
  String height() => 'Height: ${pokemon.height}';
  String weight() => 'Weight: ${pokemon.weight}';
  String baseExp() => 'BaseExp: ${pokemon.base_experience}';

  List<String> fields() => [id(), name(), order(), height(), weight(), baseExp()];
}

@dao
abstract class PokemonLocal extends BaseLocal<Pokemon> {
  @Query('SELECT * FROM Pokemon')
  Future<List<Pokemon>> onGetAll();

  @Query('SELECT * FROM Pokemon WHERE id = :query OR name = :query')
  Future<Pokemon?> onGet(String query);
}

class PokemonRepo extends BaseRepo<Pokemon> {
  final Dio remote;
  const PokemonRepo(PokemonLocal local, this.remote) : super(local);

  @override
  Future<Pokemon> doGet(String query) => Future.any([
        local.onGet(query).thenUnwrap(Pokemon.new),
        _doGet(query).then(doCache),
      ]);

  @override
  Future<List<Pokemon>> doGetAll() => //
      local.onGetAll();

  Future<Pokemon> _doGet(String query) => remote //
      .get<JSON>(Const.pokeBaseUrl + 'pokemon/$query')
      .then((_) => Pokemon.fromJson(_.data ?? {}));
}
