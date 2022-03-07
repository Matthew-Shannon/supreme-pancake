import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../core/extensions.dart';
import '../model/pokemon/pair.dart';
import '../model/pokemon/pokemon.dart';
import '../model/pokemon/sprite.dart';
import '../model/user.dart';

part 'repo.g.dart';

typedef JSON = Map<String, dynamic>;

@TypeConverters([SpriteLocalConverter])
@Database(version: 1, entities: [User, Pair, Pokemon])
abstract class AppDatabase extends FloorDatabase {
  PokemonLocal get pokemonLocal;
  PairLocal get pairLocal;
  UserLocal get userLocal;

  Future<void> clear() => Future.value() //
      .thenDo(() => database.delete('User'))
      .thenDo(() => database.delete('Pair'))
      .thenDo(() => database.delete('Pokemon'));
}

abstract class BaseRepo<T> {
  final BaseLocal<T> local;
  const BaseRepo(this.local);

  Future<T> doGet(String query);

  Future<List<T>> doGetAll();

  Future<void> doInsert(List<T> xs) => //
      local.onInsert(xs).then((_) => xs);

  Future<T> doCache(T x) => //
      doCacheAll([x]).then((_) => x);

  Future<List<T>> doCacheAll(List<T> xs) => //
      local.onUpdate(xs).then((_) => xs);
}

abstract class BaseLocal<T> {
  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> onInsert(List<T> items);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> onUpdate(List<T> items);

  @delete
  Future<void> onDelete(List<T> items);

  Future<List<T>> onGetAll();

  Future<T?> onGet(String query);
}
