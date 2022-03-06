import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../service/repo.dart';

@entity
class User extends Equatable {
  @primaryKey
  final int id;
  final String name;
  final String email;
  final String password;
  const User({this.id = 0, this.name = '', this.email = '', this.password = ''});

  @override
  List<Object?> get props => [id, name, email, password];
}

class UserVM {
  final User owner;
  const UserVM(this.owner);

  String name() => 'Name: ${owner.name}';
  String email() => 'Email: ${owner.email}';
  String password() => 'Password: ${owner.password}';
  List<String> fields() => [name(), email(), password()];
}

@dao
abstract class UserLocal extends BaseLocal<User> {
  @Query('SELECT * FROM User')
  Future<List<User>> onGetAll();

  @Query('SELECT * FROM User WHERE id = :query OR email = :query')
  Future<User?> onGet(String query);
}

class UserRepo extends BaseRepo<User> {
  final UserLocal local;
  const UserRepo(this.local) : super(local);

  @override
  Future<List<User>> doGetAll() => //
      local.onGetAll();

  @override
  Future<User> doGet(String id) => //
      local.onGet(id).then((_) => _ ?? const User());
}
