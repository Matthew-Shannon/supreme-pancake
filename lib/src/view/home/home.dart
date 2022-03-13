import '../../core/const.dart';
import '../../core/view.dart';
import '../../service/service.dart';

part 'home.freezed.dart';
part 'home.g.dart';

class HomeView extends StatelessWidget with GetItMixin {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeStore store = get();
    final INav nav = get();
    return Observer(
      builder: (_) => Scaffold(
        body: nav.getBy(bottomItems()[store.pos.value].viewName),
        bottomNavigationBar: bottomNav(bottomItems(), store),
      ),
    );
  }

  static Widget bottomNav(List<BottomItem> items, HomeStore store) => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: items.map(barItem).toList(),
        currentIndex: store.pos.value,
        onTap: store.onPosChanged,
      );

  static BottomNavigationBarItem barItem(BottomItem item) => BottomNavigationBarItem(
        label: item.title,
        icon: Icon(item.normalIcon),
        activeIcon: Icon(item.selectedIcon),
      );

  static List<BottomItem> bottomItems() => const [
        BottomItem(Const.newsTitle, Const.newsView, MdiIcons.viewStreamOutline, MdiIcons.viewStream),
        BottomItem(Const.searchTitle, Const.searchView, MdiIcons.archiveSearchOutline, MdiIcons.archiveSearch),
        BottomItem(Const.favoritesTitle, Const.favoritesView, Icons.favorite_outline, Icons.favorite),
        BottomItem(Const.settingsTitle, Const.settingsView, MdiIcons.cogOutline, MdiIcons.cog),
      ];
}

@freezed
class BottomItem with _$BottomItem {
  const factory BottomItem(
    String title,
    String viewName,
    IconData normalIcon,
    IconData selectedIcon,
  ) = _BottomItem;
}

class HomeStore = HomeBase with _$HomeStore;

abstract class HomeBase with Store {
  final Observable<int> pos = Observable(0);
  final IPrefs prefs;

  HomeBase(this.prefs);

  @action
  void posChanged(int _) => pos.value = _;

  @action
  Future<void> onPosChanged(int _) async {
    await prefs.setPos(_);
    posChanged(_);
  }
}
