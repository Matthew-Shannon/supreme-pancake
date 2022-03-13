import 'dart:async';

import 'package:get_it/get_it.dart';

import '../model/model.dart';
import '../service/service.dart';
import '../view/auth/auth.dart';
import '../view/auth/features/login.dart';
import '../view/auth/features/register.dart';
import '../view/home/features/favorites.dart';
import '../view/home/features/news.dart';
import '../view/home/features/search.dart';
import '../view/home/features/settings.dart';
import '../view/home/home.dart';
import 'const.dart';

typedef DI = GetIt;

class Graph {
  static Future<void> setup() => Future.value(DI.instance) //
      .then(PresentationModule.setup)
      .then(ServiceModule.setup)
      .then(RepositoryModule.setup)
      .then(StoreModule.setup)
      .then((_) => _.allReady());
}

class ServiceModule {
  static DI setup(DI di) => di
    // prefs
    ..registerSingletonAsync<SharedPreferences>(SharedPreferences.getInstance)
    ..registerSingletonWithDependencies<IPrefs>(() => Prefs(di.get()), dependsOn: [SharedPreferences])
    // remote
    ..registerLazySingleton<PrettyDioLogger>(PrettyDioLogger.new)
    ..registerLazySingleton<Dio>(Dio.new); //..interceptors.add(di.get<PrettyDioLogger>()));
}

class RepositoryModule {
  static DI setup(DI di) => di
    // user
    ..registerLazySingleton<UserRepo>(() => UserRepo(di.get()))
    // pokemon
    ..registerLazySingleton<PokemonRemote>(() => PokemonRemote(di.get()))
    ..registerLazySingleton<PokemonRepo>(() => PokemonRepo(di.get()));
}

class StoreModule {
  static DI setup(DI di) => di
    ..registerLazySingleton<AuthStore>(() => !Const.isDev //
        ? AuthStore()
        : (AuthStore() //
          ..authChanged(true)
          ..ownerChanged(const User(name: 'matthew', email: 'mshannon93@gmail.com', password: 'abc123'))))
    ..registerLazySingleton<HomeStore>(() => !Const.isDev //
        ? HomeStore(di.get())
        : (HomeStore(di.get()) //
          ..posChanged(1)))
    ..registerLazySingleton<SettingsStore>(() => SettingsStore(di.get(), di.get()))
    ..registerLazySingleton<LoginStore>(() => LoginStore(di.get(), di.get(), di.get()))
    ..registerLazySingleton<SearchStore>(() => SearchStore(di.get()))
    ..registerLazySingleton<RegisterStore>(() => RegisterStore(di.get()));
}

class PresentationModule {
  static DI setup(DI di) => di
    ..registerLazySingleton<IStyle>(Style.new)
    ..registerLazySingleton<INav>(() => Nav(Const.homeView, Const.authView, {
          Const.authView: AuthView.new,
          Const.loginView: LoginView.new,
          Const.registerView: RegisterView.new,
          Const.homeView: HomeView.new,
          Const.newsView: NewsView.new,
          Const.searchView: SearchView.new,
          Const.favoritesView: FavoritesView.new,
          Const.settingsView: SettingsView.new,
        }));
}
