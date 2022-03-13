import '../service/service.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    @Default('') String name,
    @Default('') String email,
    @Default('') String password,
  }) = _User;
  factory User.fromJson(JSON json) => _$UserFromJson(json);
}

class UserVM {
  final User owner;
  const UserVM(this.owner);

  String name() => 'Name: ${owner.name}';
  String email() => 'Email: ${owner.email}';
  String password() => 'Password: ${owner.password}';
  List<String> fields() => [name(), email(), password()];
}

class UserRepo {
  final IPrefs prefs;
  const UserRepo(this.prefs);

  Future<void> doInsert(User user) => //
      prefs.setOwner(jsonEncode(user.toJson()));

  Future<Option<User>> doGet() async => //
      prefs.getOwner().then((_) => _.isEmpty ? none() : some(User.fromJson(jsonDecode(_))));
}
