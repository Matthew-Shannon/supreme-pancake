import 'package:flutter_test/flutter_test.dart';
import 'package:mydex/src/core/const.dart';
import 'package:mydex/src/model/pokemon/sprite.dart';

import '../core/mock.dart';

void main() {
  group('Sprite', () {
    group('model', () {
      test('equals', () {
        expect(const Sprite() == const Sprite(), isTrue);
        expect(const Sprite(front_default: 'a') == const Sprite(front_default: 'b'), isFalse);
        expect(Sprite.fromJson(const Sprite().toJson()) == const Sprite(), isTrue);
        expect(Sprite.fromJson(const Sprite(front_default: 'a').toJson()) == const Sprite(front_default: 'b'), isFalse);
      });
      test('json', () {
        expect(Sprite.fromJson(const Sprite().toJson()) == const Sprite(), isTrue);
        expect(Sprite.fromJson(const Sprite(front_default: 'a').toJson()) == const Sprite(front_default: 'b'), isFalse);

        var localConverter = SpriteLocalConverter();
        expect(localConverter.decode(localConverter.encode(const Sprite())), equals(const Sprite()));
        expect(localConverter.decode(localConverter.encode(mockSpriteMale)), equals(mockSpriteMale));
        expect(localConverter.decode(localConverter.encode(mockSpriteFemale)), equals(mockSpriteFemale));

        var remoteConverter = const SpriteRemoteConverter();
        expect(remoteConverter.fromJson(remoteConverter.toJson(const Sprite())), equals(const Sprite()));
        expect(remoteConverter.fromJson(remoteConverter.toJson(mockSpriteMale)), equals(mockSpriteMale));
        expect(remoteConverter.fromJson(remoteConverter.toJson(mockSpriteFemale)), equals(mockSpriteFemale));
      });
    });

    group('vm', () {
      test('drawMale', () {
        var maleSpriteVM = const SpriteVM(mockSpriteMale);
        expect(maleSpriteVM.normal()[0], equals('a'));
        expect(maleSpriteVM.normal()[1], equals('b'));
        expect(maleSpriteVM.shiny()[0], equals('c'));
        expect(maleSpriteVM.shiny()[1], equals('d'));
      });
      test('drawFemale', () {
        var femaleSpriteVM = const SpriteVM(mockSpriteFemale);
        expect(femaleSpriteVM.normal()[0], equals('a'));
        expect(femaleSpriteVM.normal()[1], equals('b'));
        expect(femaleSpriteVM.shiny()[0], equals('c'));
        expect(femaleSpriteVM.shiny()[1], equals('d'));
      });
      test('drawFemale', () {
        var emptySpriteVM = const SpriteVM(Sprite());
        expect(emptySpriteVM.normal()[0], equals(Const.defImage));
        expect(emptySpriteVM.normal()[1], equals(Const.defImage));
        expect(emptySpriteVM.shiny()[0], equals(Const.defImage));
        expect(emptySpriteVM.shiny()[1], equals(Const.defImage));
      });
    });
  });
}
