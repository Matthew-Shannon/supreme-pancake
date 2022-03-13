import '../../core/const.dart';
import '../../service/service.dart';

part 'sprite.freezed.dart';
part 'sprite.g.dart';

@freezed
class Sprite with _$Sprite {
  const factory Sprite({
    @Default(null) String? back_default,
    @Default(null) String? back_female,
    @Default(null) String? back_shiny,
    @Default(null) String? back_shiny_female,
    @Default(null) String? front_default,
    @Default(null) String? front_female,
    @Default(null) String? front_shiny,
    @Default(null) String? front_shiny_female,
  }) = _Sprite;

  factory Sprite.fromJson(JSON json) => _$SpriteFromJson(json);
}

class SpriteVM {
  final Sprite sprites;
  const SpriteVM(this.sprites);

  List<String> normal() => [
        unwrap(sprites.front_default, sprites.front_female),
        //unwrap(sprites.back_default, sprites.back_female),
      ];
  List<String> shiny() => [
        unwrap(sprites.front_shiny, sprites.front_shiny_female),
        //unwrap(sprites.back_shiny, sprites.back_shiny_female),
      ];

  String unwrap(String? a, String? b) => a ?? b ?? Const.defImage;
}
