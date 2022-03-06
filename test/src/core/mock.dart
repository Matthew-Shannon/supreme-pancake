import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mydex/src/model/pokemon/sprite.dart';
import 'package:mydex/src/service/nav.dart';
import 'package:mydex/src/service/prefs.dart';
import 'package:mydex/src/service/style.dart';

import 'package:mydex/src/model/pokemon/pair.dart';
import 'package:mydex/src/model/pokemon/pokemon.dart';
import 'package:mydex/src/model/user.dart';
import 'package:mydex/src/service/repo.dart';

class MockDio extends Mock implements Dio {}

class MockNav extends Mock implements INav {}

class MockPrefs extends Mock implements IPrefs {}

class MockStyle extends Mock implements IStyle {}

class MockBaseLocal<String> extends Mock implements BaseLocal<String> {}

class MockUserRepo extends Mock implements UserRepo {}

class MockPokemonRepo extends Mock implements PokemonRepo {}

class MockPairRepo extends Mock implements PairRepo {}

Future<AppDatabase> testDb() => $FloorAppDatabase.inMemoryDatabaseBuilder().build();

const mockPair = Pair(id: 1, name: 'a', url: 'b');
const mockPairB = Pair(id: 2, name: 'c', url: 'd');
const mockPairC = Pair(id: 3, name: 'e', url: 'f');

const mockUser = User(id: 1, name: 'a', email: 'b@', password: 'c');
const mockUserB = User(id: 2, name: 'd', email: 'e@', password: 'f');

const mockSpriteMale = Sprite(
  front_default: 'a',
  front_female: null,
  front_shiny: 'c',
  front_shiny_female: null,
  back_default: 'b',
  back_female: null,
  back_shiny: 'd',
  back_shiny_female: null,
);

const mockSpriteFemale = Sprite(
  front_default: null,
  front_female: 'a',
  front_shiny: null,
  front_shiny_female: 'c',
  back_default: null,
  back_female: 'b',
  back_shiny: null,
  back_shiny_female: 'd',
);

const mockPokemon = Pokemon(
  id: 1,
  name: 'a',
  order: 2,
  height: 3,
  weight: 4,
  base_experience: 5,
  sprites: mockSpriteMale,
);

const mockPokemonB = Pokemon(
  id: 1,
  name: 'b',
  order: 6,
  height: 7,
  weight: 8,
  base_experience: 9,
  sprites: mockSpriteMale,
);
