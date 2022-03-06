import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../model/pokemon/pair.dart';
import '../model/pokemon/pokemon.dart';
import '../model/pokemon/sprite.dart';
import '../model/user.dart';

part 'repo.g.dart';

typedef JSON = Map<String, dynamic>;

@TypeConverters([SpriteLocalConverter])
@Database(version: 1, entities: [User, Pokemon, Pair])
abstract class AppDatabase extends FloorDatabase {
  PokemonLocal get pokemonLocal;
  PairLocal get pairLocal;
  UserLocal get userLocal;
}

abstract class BaseRepo<T> {
  final BaseLocal<T> local;
  const BaseRepo(this.local);

  Future<T> doGet(String query);

  Future<List<T>> doGetAll();

  Future<void> doInsert(List<T> xs) => //
      local.onInsertOrUpdate(xs);

  Future<T> doCache(T x) => //
      doCacheAll([x]).then((_) => x);

  Future<void> doCacheAll(List<T> xs) => //
      local.onInsertOrUpdate(xs);
}

abstract class BaseLocal<T> {
  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<List<int>> onInsert(List<T> items);

  @update
  Future<void> onUpdate(List<T> items);

  @delete
  Future<void> onDelete(List<T> items);

  @transaction
  Future<void> onInsertOrUpdate(List<T> items) => //
      Future.value(items) //
          .then(onInsert)
          .then((_) => _.asMap().entries)
          .then((_) => _.map((_) => _.key == -1 ? items[_.key] : null))
          .then((_) => _.whereType<T>().toList())
          .then(onUpdate);
}
