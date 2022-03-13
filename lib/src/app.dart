import 'package:device_preview/device_preview.dart';

import 'core/view.dart';
import 'service/service.dart';
import 'view/auth/auth.dart';
import 'view/home/features/settings.dart';

class AppView extends StatelessWidget with GetItMixin {
  AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    final SettingsStore settingsStore = get();
    final AuthStore authStore = get();
    final IStyle style = get();
    final INav nav = get();
    return Observer(
      builder: (_) => MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(_),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        home: nav.selectInitial(authStore.isAuthed.value),
        theme: style.selectTheme(settingsStore.isDarkMode.value),
      ) //
          .screenUtil()
          .devicePreview(true),
    );
  }
}

extension AppEx on Widget {
  Widget devicePreview([bool enabled = false]) => //
      DevicePreview(enabled: enabled, builder: (_) => this);

  Widget screenUtil() => //
      ScreenUtilInit(designSize: const Size(360, 690), minTextAdapt: true, builder: () => this);
}
