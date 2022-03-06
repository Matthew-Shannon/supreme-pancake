import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../core/extensions.dart';
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

  String id() => 'Id: ${owner.id}';
  String name() => 'Name: ${owner.name}';
  String email() => 'Email: ${owner.email}';
  String password() => 'Password: ${owner.password}';
  List<String> fields() => [id(), name(), email(), password()];
}

@dao
abstract class UserLocal extends BaseLocal<User> {
  @Query('SELECT * FROM User')
  Future<List<User>> onGetAll();

  @Query('SELECT * FROM User WHERE id = :query OR email = :query')
  Future<User?> onGet(String query);
}

class UserRepo extends BaseRepo<User> {
  const UserRepo(UserLocal local) : super(local);

  @override
  Future<User> doGet(String query) => //
      local.onGet(query).thenUnwrap(User.new);

  @override
  Future<List<User>> doGetAll() => //
      local.onGetAll();
}
