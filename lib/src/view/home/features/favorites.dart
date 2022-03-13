import '../../../core/const.dart';
import '../../../core/view.dart';

class FavoritesView extends StatelessWidget with GetItMixin {
  FavoritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const Text(Const.favoritesTitle).appBar(),
        body: const Text(Const.appName).center(),
      );
}
