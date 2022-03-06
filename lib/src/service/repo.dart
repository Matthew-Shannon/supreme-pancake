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
  BaseRepo(this.local);

  Future<T> doGet(String query);
  Future<List<T>> doGetAll();

  Future doInsert(List<T> xs) => //
      local.onInsert(xs);

  Future<T> doCache(T x) => //
      doCacheAll([x]).then((_) => x);

  Future<List<T>> doCacheAll(List<T> xs) => Future.value(xs)
      .then((_) => local.onDelete(xs)) //
      .then((_) => local.onInsert(xs))
      .then((_) => xs);
}

abstract class BaseLocal<T> {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> onInsert(List<T> items);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> onUpdate(List<T> items);

  @delete
  Future<void> onDelete(List<T> items);
}
