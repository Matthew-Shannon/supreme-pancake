import '../../../core/const.dart';
import '../../../core/view.dart';

class NewsView extends StatelessWidget with GetItMixin {
  NewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const Text(Const.newsTitle).appBar(),
        body: const Text(Const.appName).center(),
      );
}
