import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../core/const.dart';
import '../../core/extensions.dart';
import '../../service/repo.dart';

part 'pair.g.dart';

@entity
@JsonSerializable()
class Pair extends Equatable {
  @primaryKey
  final int id;
  final String name;
  final String url;
  const Pair({this.id = 0, this.name = '', this.url = ''});

  @override
  List<Object?> get props => [id, name, url];

  factory Pair.fromJson(JSON json) => _$PairFromJson(json);

  JSON toJson() => _$PairToJson(this);
}

class PairVM {
  final Pair pair;
  const PairVM(this.pair);

  String title() => pair.name + ' (${pair.id}';
}

@dao
abstract class PairLocal extends BaseLocal<Pair> {
  @Query('SELECT * FROM Pair')
  Future<List<Pair>> onGetAll();

  @Query('SELECT * FROM Pair WHERE id = :query OR name = :query')
  Future<Pair?> onGet(String query);
}

class PairRepo extends BaseRepo<Pair> {
  final Dio remote;
  const PairRepo(PairLocal local, this.remote) : super(local);

  @override
  Future<Pair> doGet(String query) => //
      local.onGet(query).thenUnwrap(Pair.new);

  @override
  Future<List<Pair>> doGetAll() => Future.any([
        local.onGetAll(),
        _doGetAll().then(doCacheAll),
      ]);

  Future<List<Pair>> _doGetAll() => remote
      .get<JSON>(Const.pokeBaseUrl + 'pokemon/?limit=898') //
      .then((res) => List<JSON>.from(res.data?['results'] ?? {}))
      .then((xs) => xs.map((_) => _.copyWith('id', withID(_))).mapList(Pair.fromJson));

  static int withID(JSON data) => int.parse((data['url'] as String) //
      .replaceAll(Const.pokeDataUrl, '')
      .split('/')
      .first);
}
