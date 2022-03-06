import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../service/repo.dart';

part 'user.g.dart';

@entity
@autoequal
class User extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String name;
  final String email;
  final String password;

  const User({
    this.id = 0,
    this.name = '',
    this.email = '',
    this.password = '',
  });

  @override
  List<Object?> get props => _autoequalProps;
}

@dao
abstract class UserLocal extends BaseLocal<User> {
  @Query('SELECT * FROM User')
  Future<List<User>> onGetAll();

  @Query('SELECT * FROM User WHERE id = :id')
  Future<User?> onGet(int id);
}

class UserRepo extends BaseRepo<User> {
  final UserLocal local;
  UserRepo(this.local) : super(local);

  @override
  Future<void> doInsert(List<User> users) => //
      local.onInsert(users);

  @override
  Future<List<User>> doGetAll() => //
      local.onGetAll();

  @override
  Future<User> doGet(String id) => local //
      .onGet(int.tryParse(id) ?? 0)
      .then((_) => _ ?? const User());

  Future<User> doGetByEmail(String email) => doGetAll() //
      .then((xs) => xs.firstWhere((_) => _.email == email, orElse: () => const User())); //

}

class UserVM {
  final User owner;
  const UserVM(this.owner);

  String name() => 'Name: ${owner.name}';
  String email() => 'Email: ${owner.email}';
  String password() => 'Password: ${owner.password}';
  List<String> fields() => [name(), email(), password()];
}
