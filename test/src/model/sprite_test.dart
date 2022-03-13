import 'package:mydex/src/core/const.dart';
import 'package:mydex/src/model/model.dart';

import '../core/mock.dart';
import '../core/util.dart';

void main() {
  group('Sprite', () {
    group('model', () {
      test('equals', () {
        expect(const Sprite() == const Sprite(), isTrue);
        expect(const Sprite(front_default: 'a') == const Sprite(front_default: 'b'), isFalse);
      });
      test('json', () {
        expect(Sprite.fromJson(const Sprite().toJson()) == const Sprite(), isTrue);
        expect(Sprite.fromJson(const Sprite(front_default: 'a').toJson()) == const Sprite(front_default: 'b'), isFalse);
      });
    });

    group('vm', () {
      test('drawMale', () {
        var maleSpriteVM = const SpriteVM(mockSpriteMale);
        expect(maleSpriteVM.normal()[0], equals(''));
        expect(maleSpriteVM.normal()[1], equals(''));
        expect(maleSpriteVM.shiny()[0], equals(''));
        expect(maleSpriteVM.shiny()[1], equals(''));
      });
      test('drawFemale', () {
        var femaleSpriteVM = const SpriteVM(mockSpriteFemale);
        expect(femaleSpriteVM.normal()[0], equals(''));
        expect(femaleSpriteVM.normal()[1], equals(''));
        expect(femaleSpriteVM.shiny()[0], equals(''));
        expect(femaleSpriteVM.shiny()[1], equals(''));
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
