import 'package:mocktail/mocktail.dart';
import 'package:mydex/src/service/nav.dart';
import 'package:mydex/src/service/prefs.dart';
import 'package:mydex/src/service/style.dart';

import 'package:mydex/src/model/pokemon/pair.dart';
import 'package:mydex/src/model/pokemon/pokemon.dart';
import 'package:mydex/src/model/user.dart';
import 'package:mydex/src/service/repo.dart';

class MockNav extends Mock implements INav {}

class MockPrefs extends Mock implements IPrefs {}

class MockStyle extends Mock implements IStyle {}

class MockBaseLocal<String> extends Mock implements BaseLocal<String> {}

class MockUserRepo extends Mock implements UserRepo {}

class MockPokemonRepo extends Mock implements PokemonRepo {}

class MockPairRepo extends Mock implements PairRepo {}

const mockUser = User(id: 1, name: 'a', email: 'b@', password: 'c');

Future<AppDatabase> testDb() => $FloorAppDatabase.inMemoryDatabaseBuilder().build();
