import 'package:mydex/src/core/const.dart';
import 'package:mydex/src/model/model.dart';
import 'package:mydex/src/service/service.dart';

import 'util.dart';

class FakeUser extends Fake implements User {}

class FakeContext extends Fake implements BuildContext {}

class MockNav extends Mock implements INav {}

class MockPrefs extends Mock implements IPrefs {}

class MockStyle extends Mock implements IStyle {}

class MockUserRepo extends Mock implements UserRepo {}

class MockPokemonRemote extends Mock implements PokemonRemote {}

class MockPokemonRepo extends Mock implements PokemonRepo {}

class MockResourceRemote extends Mock implements ResourceRemote {}

class MockNamedResRepo extends Mock implements ResourceRepo {}

const mockNamedRes = NamedApiResource(name: 'a', url: 'https://pokeapi.co/api/v2/pokemon/1/');
const mockNamedResB = NamedApiResource(name: 'b', url: 'https://pokeapi.co/api/v2/pokemon/2/');
const mockNamedResC = NamedApiResource(name: 'c', url: 'https://pokeapi.co/api/v2/pokemon/3/');

const mockUser = User(name: 'a', email: 'b@', password: 'c');
const mockUserB = User(name: 'd', email: 'e@', password: 'f');

const mockSpriteMale = Sprite(
  front_default: '',
  front_shiny: '',
  back_default: '',
  back_shiny: '',
);

const mockSpriteFemale = Sprite(
  front_female: '',
  front_shiny_female: '',
  back_female: '',
  back_shiny_female: '',
);

const mockAbility = Ability(
    isHidden: false,
    slot: 2,
    ability: NamedApiResource(
      name: 'limber',
      url: '${Const.pokeBaseUrl}ability/7/',
    ));

const mockPokemon = Pokemon(
    id: 77,
    name: 'ponyta',
    order: 121,
    height: 10, // 3'03"
    weight: 300, // 66.1lbs
    base_experience: 82,
    sprites: mockSpriteMale,
    abilities: [mockAbility]);

const mockPokemonB = Pokemon(
  id: 1,
  name: 'b',
  order: 6,
  height: 7,
  weight: 8,
  base_experience: 9,
  sprites: mockSpriteMale,
);
